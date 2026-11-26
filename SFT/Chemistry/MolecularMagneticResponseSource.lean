import SFT.Chemistry.MolecularMagneticResponseExperiment
import SFT.Chemistry.MolecularPolarizabilitySource
namespace SFT.Chemistry.MolecularMagneticResponseSource
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularMagneticResponseExperiment
set_option maxRecDepth 50000
set_option maxHeartbeats 100000000
abbrev pair := MolecularPolarizabilitySource.pair
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
 sourceOrientation : String
 resultClass : String
def mergeRows (identity target : Value) : Value := match identity with
 | .object old => match target with
  | .object newer => .object ((old.filter fun (key,_) => !(newer.any fun (k,_) => Text.equal key k))++newer)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => target
 | .null | .boolean _ | .integer _ | .text _ | .array _ => target
def quadrupoleFrequencyTensor (row : Value) : Bool := match get row "magnetic_parameter" with
 | .text parameter => Text.contains parameter "χ" && ["mhz","khz","cm^-1"].any (Text.contains (Text.lowerAscii parameter))
 | .null | .boolean _ | .integer _ | .array _ | .object _ => false
def sourceRows (identityBytes targetBytes primaryBytes pdfBytes textBytes resolutionBytes : ByteArray)
 (identityDocument targets primary : Value) : Except String (List Target) := do
 let _ ← [(primaryBytes,primaryPath,primaryHash),(targetBytes,targetPath,targetHash),
  (pdfBytes,diatomicPdfPath,diatomicPdfHash),(textBytes,diatomicTextPath,diatomicTextHash),
  (resolutionBytes,resolutionPath,resolutionHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-012 registered source changed: " path)
  pure ()
 let primaryRows ← RunningConvergenceMeasurement.array (get primary "rows")
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 let ids ← identities identityBytes identityDocument
 if !sameValue (get primary "complete_target_cell_count") (.integer 174) ||
  !sameValue (get primary "source_value_present_count") (.integer 136) ||
  !sameValue (get primary "source_value_absent_count") (.integer 38) ||
  !sameValue (get primary "diatomic_reference_pdf_target_count") (.integer 22) ||
  !sameValue (get targets "schema") (.text "sft-v3-magnetic-response-withheld-targets/1") ||
  !sameValue (get targets "release_requires_prediction_seal") (.boolean true) ||
  !sameValue (get targets "complete_target_count") (.integer 174) ||
  primaryRows.length != 174 || targetRows.length != 174 || ids.length != 174 then
  throw "PROP-012 complete source surface changed"
 let resolved ← ((ids.zip targetRows).zip primaryRows).mapM fun ((id,target),primaryRow) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get target "target_id") (get primaryRow "target_id") then
   throw "PROP-012 source order or identity changed"
  if !(["source_value_present","source_value_inscription","native_value"].all fun key =>
   sameValue (get target key) (get primaryRow key)) then
   throw "PROP-012 withheld and primary values differ"
  let native ← field target "native_value"
  let (value,orientation,resultClass) ← if sameValue (get target "source_value_present") (.boolean true) then do
    let value ← field native "exact_positive_magnitude" >>= pair
    let orientation ← field native "external_orientation" >>= text
    pure (value,orientation,"exact-positive-molecular-magnetic-magnitude-with-held-source-orientation")
   else pure (CapabilityValues.Value.emptyOne "empty-One","source-orientation-absent-with-blank-cell","blank-source-cell-structural-EmptyOne")
  let targetId ← field id "target_id" >>= text
  pure (⟨targetId,mergeRows id target,value,orientation,resultClass⟩ : Target)
 let positive := resolved.filter fun row => match row.value with
  | .ratio _ _ => true
  | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
 let absent := resolved.filter fun row => match row.value with
  | .emptyOne _ => true
  | .ratio _ _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
 if resolved.length != 174 || positive.length != 136 || absent.length != 38 ||
  resolved.any (fun row => quadrupoleFrequencyTensor row.row) then
  throw "PROP-012 positive/absence or susceptibility classification changed"
 pure resolved
end SFT.Chemistry.MolecularMagneticResponseSource
