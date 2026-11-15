import SFT.Physics.OrbitalDimensionStabilityEvidence
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.OrbitalRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "D9F-EXTERNAL-ORBITAL-DIMENSION-STABILITY"
def sourcePath : String := "experiments/external_sources/physics/snapshots/orbital-dimension-stability-source-record.json"
def sourceHash : String := "sha256:f8fca45480808d3863b7c528e811c1563c1c988d9289248f1f39409f05ebbacb"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/orbital-dimension-stability-source-record.json","sha256:f8fca45480808d3863b7c528e811c1563c1c988d9289248f1f39409f05ebbacb"),("experiments/external_sources/physics/snapshots/cambridge-central-forces-chapter6.pdf","sha256:59de9d143492b1fdf2f1f0b96c9653d861822081f6ee57c7689b943e31210024"),("experiments/external_sources/physics/snapshots/tong-central-forces-four.pdf","sha256:2d999345dd33fce016498a1ed2dc5085f8e7513530f75dfeb94dfbff05aad44e")]
def requiredKeys : List String := ["gravity_dimension_domain", "gravity_force_power", "centrifugal_force_power", "circular_balance", "perturbation_direction", "external_force_stability_criterion", "external_dimension_boundary", "stable_dimensions", "marginal_dimension", "unstable_dimension_family", "potential_power_boundary", "effective_potential_condition", "higher-dimensional-topology_assumed", "measured_parameter_fitted"]
def requiredTarget : Value := .object [("stable_dimensions",.array [.text "2",.text "3"]),("marginal_dimension",.text "4"),("higher-dimensional-topology_assumed",.boolean false),("measured_parameter_fitted",.boolean false)]
def requiredCustody : Value := .object [("formal_claim_contains_external_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_registered_rows_retained",.boolean true),("measurements_select_formal_survivor",.boolean false)]
def getDefault (v : Value) (key : String) (fallback : Value := .null) : Value :=
 match v with
 | .object fields => match fields.find? (fun p => Text.equal p.1 key) with | some p => p.2 | none => fallback
 | .null | .boolean _ | .integer _ | .text _ | .array _ => fallback
def requiredFields (payload expected : Value) : Bool :=
 match expected with
 | .object fields => fields.all (fun (key,value) => Text.equal (render (getDefault payload key)) (render value))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def payloadBoundary (record : Value) : Except String Value := do
 if !Text.equal (render (getDefault record "source_id")) (render (.text sourceId)) ||
    (← array (getDefault record "snapshots" (.array []))).length != 2 then throw "D9f record changed"
 let target := getDefault record "registered_target" (.object [])
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "D9f record changed"
 if !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) || !requiredFields target requiredTarget then throw "D9f record changed"
 pure record
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "D9f custody changed"
 pure record
def fileBytes (files : List (String × ByteArray)) (relative : String) : Except String ByteArray :=
 match files.find? (fun p => Text.equal p.1 relative) with
 | none => .error (Text.append "FileNotFoundError: " relative)
 | some p => .ok p.2
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "D9f source changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 custodyBoundary record
end SFT.Physics.OrbitalRecords
