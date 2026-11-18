import SFT.Chemistry.BondDissociationEnergyExperiment
import SFT.Chemistry.EquilibriumBondLengthSource
namespace SFT.Chemistry.BondDissociationEnergySource
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals
abbrev field := RunningConvergenceMeasurement.field
abbrev text := RunningConvergenceMeasurement.text
abbrev array := RunningConvergenceMeasurement.array
abbrev sameValue := RunningConvergenceMeasurement.sameValue
-- V3 _fraction rejects bools, extra fields, and nonpositive integer components.
def fraction (row : Value) : Except String Rat := do
 let fields ← match row with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-002 exact fraction record is malformed"
 if fields.length != 2 || !fields.any (fun p => Text.equal p.1 "numerator") ||
  !fields.any (fun p => Text.equal p.1 "denominator") then throw "PROP-002 exact fraction record is malformed"
 let n ← match ← field row "numerator" with
  | .integer n => pure n
  | .null | .boolean _ | .text _ | .array _ | .object _ => throw "PROP-002 exact fraction left the positive domain"
 let d ← match ← field row "denominator" with
  | .integer d => pure d
  | .null | .boolean _ | .text _ | .array _ | .object _ => throw "PROP-002 exact fraction left the positive domain"
 if !(@decide (Int.lt 0 n) (Int.decLt _ _)) || !(@decide (Int.lt 0 d) (Int.decLt _ _)) then
  throw "PROP-002 exact fraction left the positive domain"
 if positive : 0 < d.natAbs then pure (normalize n d.natAbs positive)
 else throw "PROP-002 exact fraction left the positive domain"
def sameFraction (a b : Rat) : Bool :=
 @decide (a.num = b.num) (Int.decEq _ _) && @decide (a.den = b.den) (Nat.decEq _ _)
def interval (row : Value) : Except String (Rat × Rat × Rat × Rat) := do
 let central ← field row "central" >>= fraction
 let uncertainty ← field row "uncertainty" >>= fraction
 let lower ← field row "lower" >>= fraction
 let upper ← field row "upper" >>= fraction
 if !sameFraction (add lower uncertainty) central || !sameFraction (add central uncertainty) upper || !lower.blt upper then
  throw "PROP-002 interval does not reconstruct exactly"
 pure (central,uncertainty,lower,upper)
def ratio (value : Rat) : Except String CapabilityValues.Value := do
 if !(@decide (Int.lt 0 value.num) (Int.decLt _ _)) then throw "PROP-002 measurement ratio must be exact and positive"
 pure (.ratio (← CapabilityValues.count value.num.natAbs) (← CapabilityValues.count value.den))
def atomicPath : String := "experiments/external_sources/chemistry/snapshots/prop-002-atomic-1s-2s-primary-records-v1.json"
def atomicHash : String := "sha256:a6da423edfe31be4666d56eb6b83864512e5583760b016fce00d2b825a173267"
def apsPath : String := "experiments/external_sources/chemistry/snapshots/aps-hydrogen-dissociation-1994.json"
def apsHash : String := "sha256:9c41d01395090b18b2eb8b1223e9cb430d9309f79d1a0324b092a5ed8c1b6953"
def currentPath : String := "experiments/external_sources/chemistry/snapshots/prop-002-current-dissociation-primary-records-v1.json"
def currentHash : String := "sha256:304c92c783621b12706ce1ba92a3c2dc9b6426f884fb8ab3001523c65cbbfc80"
def bytesMatch (bytes : ByteArray) (expected : String) : Bool := Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected
-- Original dictionary lookup: the last source row for the key is retained.
def sourceRow (rows : List Value) (keys : List (String × String)) : Except String Value :=
 match rows.reverse.find? (fun row => keys.all (fun (key,value) =>
  sameValue ((field row key).toOption.getD .null) (.text value))) with
 | none => .error "PROP-002 source row absent"
 | some row => .ok row
structure Expected where
 targetId : String
 species : String
 role : String
 central : Rat
 uncertainty : Rat
 snapshotHash : String
-- Integer Fraction constructor used by the original APS records, after exact source hashing.
def apsFraction (row : Value) (numerator denominator : String) : Except String Rat := do
 let n ← field row numerator >>= EquilibriumBondLengthSource.integer
 let d ← field row denominator >>= EquilibriumBondLengthSource.integer
 if nonzero : d.natAbs ≠ 0 then
  pure (normalize (if @decide (Int.lt d 0) (Int.decLt _ _) then -n else n) d.natAbs (Nat.pos_of_ne_zero nonzero))
 else throw "PROP-002 source denominator is zero"
def expectedMeasurements (apsBytes atomicBytes currentBytes : ByteArray)
 (aps atomic current : Value) : Except String (List Expected) := do
 if !bytesMatch apsBytes apsHash || !bytesMatch atomicBytes atomicHash || !bytesMatch currentBytes currentHash then
  throw "PROP-002 primary-source bytes changed"
 let apsRows ← field aps "records" >>= array
 let atomicRows ← field atomic "sources" >>= array
 let currentRows ← field current "sources" >>= array
 let hydrogen ← sourceRow atomicRows [("source_id","PRL-UDEM-H-1S2S-1997")]
 let shift ← sourceRow atomicRows [("source_id","PRL-PARTHEY-HD-1S2S-SHIFT-2010")]
 let light ← sourceRow atomicRows [("source_id","SI-DEFINING-LIGHT-SPEED")]
 if !sameValue ((field light "value_inscription_m_per_s").toOption.getD .null) (.text "299792458") ||
  !sameValue ((field light "exact_definition").toOption.getD .null) (.boolean true) then
  throw "PROP-002 SI translation identity changed"
 let scale := normalize 29979245800 1 (by decide)
 let hv ← field hydrogen "value_hz" >>= fraction
 let hu ← field hydrogen "standard_uncertainty_hz" >>= fraction
 let sv ← field shift "value_hz" >>= fraction
 let su ← field shift "standard_uncertainty_hz" >>= fraction
 let hydrogenValue ← LeptonRatios.divide hv scale
 let hydrogenUncertainty ← LeptonRatios.divide hu scale
 let deuteriumValue ← LeptonRatios.divide (add hv sv) scale
 let deuteriumUncertainty ← LeptonRatios.divide (add hu su) scale
 let rows ← [("H2","H",hydrogenValue,hydrogenUncertainty),
              ("D2","D",deuteriumValue,deuteriumUncertainty)].mapM fun (species,atom,av,au) => do
  let threshold ← sourceRow apsRows [("species",species),("kind","measured_dissociation_threshold")]
  let historical ← sourceRow apsRows [("species",species),("kind","measured_ground_state_dissociation_energy")]
  let later ← sourceRow currentRows [("species",species)]
  let tv ← apsFraction threshold "value_numerator" "value_denominator"
  let tu ← apsFraction threshold "uncertainty_numerator" "uncertainty_denominator"
  let gv ← apsFraction historical "value_numerator" "value_denominator"
  let gu ← apsFraction historical "uncertainty_numerator" "uncertainty_denominator"
  let cv ← RunningConvergenceMeasurement.decimalField later "value_inscription_cm_inverse"
  let cu ← RunningConvergenceMeasurement.decimalField later "standard_uncertainty_inscription_cm_inverse"
  pure [Expected.mk (Text.intercalate "" ["PATH-",species,"-BPRIME-THRESHOLD"]) species "path-threshold" tv tu apsHash,
   ⟨Text.intercalate "" ["PATH-",atom,"-ATOMIC-1S2S"],species,"atomic-path-segment",av,au,atomicHash⟩,
   ⟨Text.intercalate "" ["APS-1994-",species,"-X-GROUND-D0"],species,"historical-ground-dissociation",gv,gu,apsHash⟩,
   ⟨Text.intercalate "" ["CURRENT-",species,"-X-GROUND-D0"],species,"later-ground-dissociation",cv,cu,currentHash⟩]
 pure rows.flatten
structure Target where
 targetId : String
 species : String
 role : String
 inscription : String
 lower : Rat
 upper : Rat
 interval : CapabilityValues.Value
def loadTargets (identityBytes targetBytes apsBytes atomicBytes currentBytes : ByteArray)
 (identities measurements aps atomic current : Value) : Except String (List Target) := do
 if !bytesMatch identityBytes BondDissociationEnergyExperiment.identityHash ||
  !bytesMatch targetBytes BondDissociationEnergyExperiment.targetHash then
  throw "PROP-002 identity or measurement registry changed"
 let identityRows ← field identities "rows" >>= array
 let measurementRows ← field measurements "rows" >>= array
 if !sameValue ((field identities "schema").toOption.getD .null) (.text "sft-v3-bond-dissociation-energy-identities/1") ||
  !sameValue ((field identities "all_measurement_values_absent").toOption.getD .null) (.boolean true) ||
  !sameValue ((field measurements "schema").toOption.getD .null) (.text "sft-v3-bond-dissociation-energy-withheld-measurements/1") ||
  !sameValue ((field measurements "release_requires_prediction_seal").toOption.getD .null) (.boolean true) ||
  !sameValue ((field measurements "identity_document_hash").toOption.getD .null) (.text (identity identities)) ||
  identityRows.length != 8 || measurementRows.length != 8 then
  throw "PROP-002 complete eight-row boundary changed"
 let expected ← expectedMeasurements apsBytes atomicBytes currentBytes aps atomic current
 let keys := SFT.Engine.sortIdentifiers (expected.map Expected.targetId)
 let identityKeys ← identityRows.mapM (fun row => field row "target_id" >>= text)
 let measurementKeys ← measurementRows.mapM (fun row => field row "target_id" >>= text)
 if !keys.all (fun key => identityKeys.any (Text.equal key) && measurementKeys.any (Text.equal key)) ||
  !identityKeys.all (fun key => keys.any (Text.equal key)) ||
  !measurementKeys.all (fun key => keys.any (Text.equal key)) then throw "PROP-002 measurement support changed"
 keys.mapM fun targetId => do
  let expected ← match expected.find? (fun e => Text.equal e.targetId targetId) with
   | none => throw "PROP-002 expected row absent"
   | some row => pure row
  let heldIdentity ← sourceRow identityRows [("target_id",targetId)]
  let row ← sourceRow measurementRows [("target_id",targetId)]
  let (central,uncertainty,lower,upper) ← interval row
  let exactLower := subtract expected.central expected.uncertainty
  let exactUpper := add expected.central expected.uncertainty
  if !sameValue ((field heldIdentity "target_value_absent").toOption.getD .null) (.boolean true) ||
   !sameValue ((field heldIdentity "species").toOption.getD .null) (.text expected.species) ||
   !sameValue ((field heldIdentity "measurement_role").toOption.getD .null) (.text expected.role) ||
   !sameValue ((field heldIdentity "snapshot_hash").toOption.getD .null) (.text expected.snapshotHash) ||
   !sameValue ((field row "species").toOption.getD .null) (.text expected.species) ||
   !sameValue ((field row "measurement_role").toOption.getD .null) (.text expected.role) ||
   !sameValue ((field row "source_snapshot_hash").toOption.getD .null) (.text expected.snapshotHash) ||
   !sameFraction central expected.central || !sameFraction uncertainty expected.uncertainty ||
   !sameFraction lower exactLower || !sameFraction upper exactUpper then
    throw (Text.append "PROP-002 source reconstruction differs: " targetId)
  let inscription ← field row "inscription" >>= text
  pure ⟨targetId,expected.species,expected.role,inscription,exactLower,exactUpper,
   .pair (← ratio exactLower) (← ratio exactUpper)⟩
end SFT.Chemistry.BondDissociationEnergySource
