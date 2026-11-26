import SFT.Chemistry.MolecularFormationEnergyExperiment
import SFT.Chemistry.MolecularPolarizabilitySource
namespace SFT.Chemistry.MolecularFormationEnergySource
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularFormationEnergyExperiment
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
def sourceRows (identityBytes targetBytes primaryBytes resultBytes referenceBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),
  (resultBytes,resultPath,resultHash),(referenceBytes,referencePath,referenceHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-013 registered source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "schema") (.text "sft-v3-formation-energy-withheld-targets/1") ||
  !sameValue (get targets "release_requires_prediction_seal") (.boolean true) || targetRows.length != 2098 then
  throw "PROP-013 withheld registry changed"
 let resolved ← (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") then throw "PROP-013 identity and target order differ"
  let native := get target "native_value"
  let (value,orientation,resultClass) ← if hasKey native "exact_positive_magnitude_kJ_per_mol" then do
    let value ← field native "exact_positive_magnitude_kJ_per_mol" >>= pair
    let orientation ← field native "external_state_orientation" >>= text
    pure (value,orientation,"exact-positive-formation-separation")
   else if sameValue (get native "structural_absence") (.text "EmptyOne") &&
    sameValue (get target "source_value_present") (.boolean true) then
    pure (CapabilityValues.Value.emptyOne "empty-One","product-and-reference-state-equal-structural-EmptyOne","printed-equality-structural-EmptyOne")
   else if sameValue (get native "structural_absence") (.text "EmptyOne") &&
    sameValue (get native "source_measurement_absent") (.boolean true) then
    pure (CapabilityValues.Value.emptyOne "empty-One","source-measurement-absent","unmeasured-structural-EmptyOne")
   else throw "PROP-013 target value class changed"
  let targetId ← field id "target_id" >>= text
  pure (⟨targetId,mergeRows id target,value,orientation,resultClass⟩ : Target)
 let positive := resolved.filter fun row => match row.value with
  | .ratio _ _ => true
  | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
 if resolved.length != 2098 || positive.length != 1463 ||
  (resolved.filter fun row => Text.equal row.resultClass "printed-equality-structural-EmptyOne").length != 22 ||
  (resolved.filter fun row => Text.equal row.resultClass "unmeasured-structural-EmptyOne").length != 613 ||
  (resolved.filter fun row => Text.equal row.sourceOrientation "product-state-below-reference-state").length != 756 ||
  (resolved.filter fun row => Text.equal row.sourceOrientation "product-state-above-reference-state").length != 707 then
  throw "PROP-013 complete value/orientation partition changed"
 pure resolved
end SFT.Chemistry.MolecularFormationEnergySource
