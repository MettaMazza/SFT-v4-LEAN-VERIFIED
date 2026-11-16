import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.QuantumSupportObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/quantum-support-bell-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/quantum-support-bell-postseal-source-record.json","sha256:51df41e3e1669d853ea3894b3ce039f6f631ad75d519bc632f26b013ff6a7ab1"),("experiments/external_sources/physics/snapshots/storz-loophole-free-bell-2023.html","sha256:fabe97e4970990cef6246f0541a8b9e80e47b0df58f10234b8f8155d1b4ade81")]
def sourceIds : List String := ["NATURE-STORZ-LOOPHOLE-FREE-BELL-2023"]
def boundaryKeys : List String := ["observed_record_tests_local_factorization_bound", "observed_record_does_not_exclude_all_deterministic_models", "random_setting_method_is_not_imported_as_ontic_nondeterminism", "support_cardinality_is_not_relabelled_as_statistical_variance", "Bell_measurement_does_not_empirically_measure_the_separate_Walsh_support_product", "target_inaccessible_to_formal_derivation"]
def boundariesRetained (boundary : Value) : Bool :=
 boundaryKeys.all (fun key => ThermometryMeasurement.literalBoolean (getDefault boundary key) true) &&
 ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "quantum-support Bell source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-quantum-support-bell-postseal-source-record/1") then
  throw "quantum-support Bell source schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:1560f2e0de3870abac2bdc6575aa9811c4dc013d5a6d705e729a832dc451b79f") then
  throw "formal quantum-support receipt binding changed"
 let sources ← array (getDefault payload "sources" (.array []))
 let source ← match sources with
  | [] => throw "complete one-source Bell record required"
  | source::rest => match rest with
    | [] => pure source
    | _::_ => throw "complete one-source Bell record required"
 if !sameValue (getDefault source "source_id") (.text "NATURE-STORZ-LOOPHOLE-FREE-BELL-2023") then
  throw "complete one-source Bell record required"
 if !sameValue (getDefault source "snapshot_hash") (.text "sha256:fabe97e4970990cef6246f0541a8b9e80e47b0df58f10234b8f8155d1b4ade81") then
  throw "Bell source snapshot binding changed"
 if !boundariesRetained (getDefault payload "interpretive_boundary" (.object [])) then
  throw "complete Bell interpretive boundary required"
 pure payload
end SFT.Physics.QuantumSupportObservationRecords
