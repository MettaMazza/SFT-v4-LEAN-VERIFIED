import SFT.Chemistry.MolecularIonizationExperiment
import SFT.Chemistry.MolecularPolarizabilitySource
namespace SFT.Chemistry.MolecularIonizationSource
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularIonizationExperiment
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev pair := MolecularPolarizabilitySource.pair
structure Page where
 path : String
 bytes : ByteArray
 text : String
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
-- The original ASCII decimal capture, including its optional fractional part.
def decimalPrefix (cs : List Char) : Option (String × List Char) :=
 let digits := cs.takeWhile ElectronSpinHtml.decimal
 if digits.isEmpty then none else
 let rest := cs.drop digits.length
 match rest with
 | [] => some (String.ofList digits,[])
 | c::tail =>
  let fraction := tail.takeWhile ElectronSpinHtml.decimal
  if c=='.' && !fraction.isEmpty then
   some (String.ofList (digits++['.']++fraction),tail.drop fraction.length)
  else some (String.ofList digits,rest)
def endUnit (cs : List Char) : Bool :=
 (cs.dropWhile CapabilityValues.whitespace).take 2 == ['e','V'] ||
 (cs.dropWhile CapabilityValues.whitespace).take 2 == ['e','v'] ||
 (cs.dropWhile CapabilityValues.whitespace).take 2 == ['E','V'] ||
 (cs.dropWhile CapabilityValues.whitespace).take 2 == ['E','v']
def captureAt (cs : List Char) : Option (String × Option String) := do
 let (energy,tail) ← decimalPrefix (cs.dropWhile CapabilityValues.whitespace)
 let rest := tail.dropWhile CapabilityValues.whitespace
 match rest with
 | [] => none
 | c::remaining =>
  if c=='±' then
   match decimalPrefix (remaining.dropWhile CapabilityValues.whitespace) with
   | none => none
   | some (uncertainty,after) => if endUnit after then some (energy,some uncertainty) else none
  else if endUnit tail then some (energy,none) else none
def searchCapture : List Char → Option (String × Option String)
 | [] => none
 | c::cs =>
  let whole := c::cs
  let capturePrefix := Text.chars "experimental ionization energy is"
  if (whole.take capturePrefix.length).map (fun c => if 65 ≤ c.toNat && c.toNat ≤ 90 then Char.ofNat (c.toNat+32) else c) == capturePrefix then
   match captureAt (whole.drop capturePrefix.length) with
   | some result => some result
   | none => searchCapture cs
  else searchCapture cs
termination_by structural cs => cs
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (identityDocument targets : Value)
 (guide : Page) (pages : List Page) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),
  (guide.bytes,guidePath,guideHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-007 registered source changed: " path)
  pure ()
 let guideText := Text.lowerAscii (ElectronSpinHtml.normalizeSpace (ElectronSpinHtml.unescape guide.text))
 if !(Text.chars "is the lowest energy required").isInfixOf_internal (Text.chars guideText) ||
    !(Text.chars "must always be greater than or equal to the adiabatic ionization energy").isInfixOf_internal (Text.chars guideText) then
  throw "PROP-007 NIST definition or vertical ordering changed"
 let ids ← identities identityBytes identityDocument
 let rows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "schema") (.text "sft-v3-molecular-ionization-withheld-measurements/1") ||
    !sameValue (get targets "release_requires_prediction_seal") (.boolean true) ||
    !sameValue (get targets "all_rows_preserved") (.boolean true) ||
    !sameValue (get targets "complete_row_count") (.integer 9) || rows.length != 9 then
  throw "PROP-007 withheld registry changed"
 (ids.zip rows).mapM fun (id,row) => do
  let path ← field row "snapshot_path" >>= text
  let page ← match pages.find? (fun page => Text.equal page.path path) with
   | none => throw (Text.append "source file unavailable: " path)
   | some page => pure page
  let expected ← field row "snapshot_hash" >>= text
  if !bytesMatch page.bytes expected then throw "PROP-007 source page changed"
  let (inscription,uncertainty) ← match searchCapture (Text.chars (ElectronSpinHtml.unescape page.text)) with
   | none => throw "PROP-007 source energy is absent"
   | some result => pure result
  let exact ← ConfigurationObservation.exact inscription
  let value ← field row "value" >>= pair
  let exactMatch := match value with
   | .ratio n d => decide (Int.ofNat n.value*Int.ofNat exact.den=exact.num*Int.ofNat d.value)
   | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
  let targetId ← field row "target_id" >>= text
  if !(["target_id","formula","initial_molecular_state","resulting_ionic_state"].all
     fun key => sameValue (get id key) (get row key)) ||
    !sameValue (get row "inscription") (.text inscription) ||
    !sameValue (get row "uncertainty_inscription") (match uncertainty with | none => .null | some s => .text s) ||
    !exactMatch then throw (Text.append "PROP-007 source reconstruction differs: " targetId)
  pure ⟨targetId,row,value⟩
end SFT.Chemistry.MolecularIonizationSource
