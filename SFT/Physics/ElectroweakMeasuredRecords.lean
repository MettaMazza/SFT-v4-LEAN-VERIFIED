import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.ElectroweakMeasuredRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/electroweak-measured-value-successor-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/electroweak-measured-value-successor-source-record.json","sha256:e608503e4832c272911c0653dd6db9cf5b662647c4fd652908b7d2299e598057"),("experiments/external_sources/physics/snapshots/pdg-2025-electroweak-model.pdf","sha256:8642888a3408d8c57fc673b379325b07f02948135491f64a2e42320e8929320a"),("experiments/external_sources/physics/snapshots/pdg-2024-w-boson-listing.pdf","sha256:91cb466bfea8fa49b53ae53d2168797189c14a5a114f30d7cc926f64c4c1e772")]
def sourceIds : List String := ["PDG-2025-STANDARD-MODEL-REVIEW", "PDG-2024-W-BOSON-LISTING"]
-- Original required_true traverses the actual keys, not an invented fixed list.
def boundariesRetained (boundary : Value) : Bool :=
 match boundary with
 | .object fields =>
  fields.all (fun (key,value) => Text.equal key "measurement_selected_formal_survivor" ||
   ThermometryMeasurement.literalBoolean value true) &&
  ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false

def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "electroweak successor source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-electroweak-measured-value-successor-source-record/1") then
  throw "electroweak successor source schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:263cf79e79ed1d7ba0246f84abe869084aa4db7b195dd0c07300d1dabdef72f4") then
  throw "electroweak formal receipt binding changed"
 let sources ← array (getDefault payload "sources" (.array []))
 if !sameValue (.array (sources.map (fun row => getDefault row "source_id")))
    (.array (sourceIds.map Value.text)) then
  throw "complete two-source electroweak record required"
 if !boundariesRetained (getDefault payload "methodological_boundary" (.object [])) then
  throw "electroweak measurement-method boundary changed"
 pure payload
def originalBoundary : Value := .object [("direct_on_shell_row_is_the_primary_like_typed_measurement",.boolean true),("compatible_W_and_Z_rows_supply_an_independent_like_typed_reconstruction",.boolean true),("internally_inconsistent_aggregate_is_a_measurement_method_record_not_a_second_physical_law",.boolean true),("no_source_row_is_deleted_or_uncertainty_rescaled",.boolean true),("measurement_selected_formal_survivor",.boolean false),("target_inaccessible_to_formal_derivation",.boolean true)]
theorem originalBoundaryRetained : boundariesRetained originalBoundary = true := rfl
#print axioms boundariesRetained
#print axioms authoritativeRecord
#print axioms originalBoundaryRetained
end SFT.Physics.ElectroweakMeasuredRecords
