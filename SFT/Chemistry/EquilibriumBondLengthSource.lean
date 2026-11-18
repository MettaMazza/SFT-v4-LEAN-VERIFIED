import SFT.Chemistry.EquilibriumBondLengthExperiment
import SFT.Chemistry.JointCorrelationTargets
import SFT.Physics.MolecularSpectroscopyRecords
import SFT.Physics.CapabilityValues
import SFT.Host.SHA256Chunks
namespace SFT.Chemistry.EquilibriumBondLengthSource
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals
abbrev field := JointCorrelationTargets.field
-- The original JSON integer domain includes Python's Boolean integer subtype.
def integer : Value → Except String Int
 | .integer n => .ok n
 | .boolean b => .ok (if b then 1 else 0)
 | .null | .text _ | .array _ | .object _ => .error "both arguments should be Rational instances"
-- Original _fraction: normalize first, then require a strictly positive result.
def fraction (row : Value) : Except String Rat := do
 let n ← field row "numerator" >>= integer
 let d ← field row "denominator" >>= integer
 if hd : d.natAbs = 0 then
  throw (Text.intercalate "" ["Fraction(",render (.integer n),", 0)"])
 else
  let numerator := if @decide (Int.lt d 0) (Int.decLt _ _) then -n else n
  let value := normalize numerator d.natAbs (Nat.pos_of_ne_zero hd)
  if !(@decide (Int.lt 0 value.num) (Int.decLt _ _)) then
   throw "PROP-001 external interval left the positive exact domain"
  pure value
-- Original _ratio retains the normalized positive fraction as a capability value.
def ratio (value : Rat) : Except String CapabilityValues.Value := do
 if !(@decide (Int.lt 0 value.num) (Int.decLt _ _)) then
  throw "PROP-001 ratio must be positive"
 let numerator ← CapabilityValues.count value.num.natAbs
 let denominator ← CapabilityValues.count value.den
 pure (.ratio numerator denominator)
def loadScale (bytes : ByteArray) (document : Value) : Except String (Rat × Rat × Rat) := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) EquilibriumBondLengthExperiment.scaleHash then
  throw "PROP-001 scale input changed"
 let schema := (field document "schema").toOption.getD .null
 let absent := (field document "target_values_absent").toOption.getD .null
 if !RunningConvergenceMeasurement.sameValue schema (.text "sft-v3-equilibrium-bond-length-scale-input/1") ||
    !RunningConvergenceMeasurement.sameValue absent (.boolean true) then
  throw "PROP-001 public scale input contains a target"
 let row ← field document "registered_scale_input"
 let central ← field row "central" >>= fraction
 let lower ← field row "lower" >>= fraction
 let upper ← field row "upper" >>= fraction
 pure (central,lower,upper)
-- Original dictionary comprehensions retain the last row for each target identifier.
def indexedRows (document : Value) : Except String (List (String × Value)) := do
 let rows ← field document "rows"
 let rows ← match rows with
  | .array xs => .ok xs
  | .null | .integer _ | .boolean _ | .text _ | .object _ => .error "target rows must be a sequence"
 rows.foldlM (fun acc row => do
  let key ← field row "target_id" >>= JointCorrelationTargets.text
  if acc.any (fun p => Text.equal p.1 key) then
   pure (acc.map fun p => if Text.equal p.1 key then (key,row) else p)
  else pure (acc ++ [(key,row)])) []
structure Target where
 targetId : String
 species : String
 inscription : String
 interval : CapabilityValues.Value
 lower : Rat
 upper : Rat
def loadTargets (identityBytes targetBytes sourceBytes : ByteArray)
 (identities targetDocument sourceDocument : Value) (files : List (String × ByteArray)) : Except String (List Target) := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest identityBytes)) EquilibriumBondLengthExperiment.identityHash ||
    !Text.equal (Text.append "sha256:" (SHA256Chunks.digest targetBytes)) EquilibriumBondLengthExperiment.targetHash then
  throw "PROP-001 identity or target registry changed"
 if !RunningConvergenceMeasurement.sameValue ((field identities "schema").toOption.getD .null)
     (.text "sft-v3-equilibrium-bond-length-identities/1") ||
    !RunningConvergenceMeasurement.sameValue ((field targetDocument "schema").toOption.getD .null)
     (.text "sft-v3-equilibrium-bond-length-withheld-targets/1") then
  throw "PROP-001 registry schema changed"
 let identityRows ← indexedRows identities
 let targetRows ← indexedRows targetDocument
 if !(identityRows.all fun p => targetRows.any fun q => Text.equal p.1 q.1) ||
    !(targetRows.all fun p => identityRows.any fun q => Text.equal p.1 q.1) || targetRows.length != 2 then
  throw "PROP-001 complete target vector changed"
 let source ← MolecularSpectroscopyRecords.authoritativeRecord sourceBytes files sourceDocument
 [("hydrogen","H2"),("deuterium","D2")].mapM fun (isotope,species) => do
  let id := Text.intercalate "" ["NIST-",species,"-X1SIGMA-G-EQUILIBRIUM-DISTANCE"]
  let identity ← field (.object identityRows) id
  let target ← field (.object targetRows) id
  let sourceRow ← field (← field (← field (← field source "sources") isotope) "rows") "equilibrium_internuclear_distance_angstrom"
  let centre ← RunningConvergenceMeasurement.decimalField sourceRow "inscription"
  let halfWidth ← RunningConvergenceMeasurement.decimalField sourceRow "last_inscribed_digit_half_width"
  let lower := subtract centre halfWidth
  let upper := add centre halfWidth
  let mismatch := Text.append "PROP-001 source reconstruction differs: " species
  if !RunningConvergenceMeasurement.sameValue ((field identity "target_value_absent").toOption.getD .null) (.boolean true) then throw mismatch
  if !RunningConvergenceMeasurement.sameValue (← field identity "species") (.text species) then throw mismatch
  if !RunningConvergenceMeasurement.sameValue (← field target "inscription") (← field sourceRow "inscription") then throw mismatch
  if !RunningConvergenceMeasurement.sameValue (← field target "last_inscribed_digit_half_width") (← field sourceRow "last_inscribed_digit_half_width") then throw mismatch
  let targetCentre ← field target "central" >>= fraction
  if !(targetCentre == centre) then throw mismatch
  let targetLower ← field target "lower" >>= fraction
  if !(targetLower == lower) then throw mismatch
  let targetUpper ← field target "upper" >>= fraction
  if !(targetUpper == upper) then throw mismatch
  let path ← field identity "snapshot_path" >>= JointCorrelationTargets.text
  let expected ← field identity "snapshot_hash" >>= JointCorrelationTargets.text
  let bytes ← match files.find? (fun p => Text.equal p.1 path) with
   | some (_,bytes) => .ok bytes
   | none => .error (Text.append "FileNotFoundError: " path)
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw mismatch
  let lowerValue ← ratio lower
  let upperValue ← ratio upper
  let inscription ← field target "inscription" >>= JointCorrelationTargets.text
  pure ⟨id,species,inscription,.pair lowerValue upperValue,lower,upper⟩
-- equilibrium_bond_length_batch_v1.py: initial registry binding before spec creation.
def validateRegistryBinding (identityBytes scaleBytes targetBytes : ByteArray) (document : Value) : Except String Unit := do
 let rows := [(EquilibriumBondLengthExperiment.identityPath,EquilibriumBondLengthExperiment.identityHash,identityBytes),
  (EquilibriumBondLengthExperiment.scalePath,EquilibriumBondLengthExperiment.scaleHash,scaleBytes),
  (EquilibriumBondLengthExperiment.targetPath,EquilibriumBondLengthExperiment.targetHash,targetBytes)]
 let _ ← rows.mapM fun (path,expected,bytes) => do
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "PROP-001 registered source changed: " path)
 let originalRows := (field document "rows").toOption.getD (.array [])
 let rows ← match originalRows with
  | .array xs => .ok xs
  | .null | .integer _ | .boolean _ | .text _ | .object _ => .error "PROP-001 identity registry is incomplete or contains a target"
 if !RunningConvergenceMeasurement.sameValue ((field document "schema").toOption.getD .null)
     (.text "sft-v3-equilibrium-bond-length-identities/1") || rows.length != 2 ||
    !(rows.all fun row => RunningConvergenceMeasurement.sameValue ((field row "target_value_absent").toOption.getD .null) (.boolean true)) then
  throw "PROP-001 identity registry is incomplete or contains a target"
 pure ()
end SFT.Chemistry.EquilibriumBondLengthSource
