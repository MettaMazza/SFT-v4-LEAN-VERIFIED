import SFT.Physics.CoupledEnsembleSynchronizationEvidence
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.SynchronizationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "SFTOM-V1-E4-EXACT-OBSERVATION"
def sourcePath : String := "experiments/external_sources/physics/snapshots/coupled-ensemble-synchronization-source-record.json"
def sourceHash : String := "sha256:16915101542c9bf4592f0595713a56a68932ec4f0662f90e2e6624fbd747ad8e"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/coupled-ensemble-synchronization-source-record.json","sha256:16915101542c9bf4592f0595713a56a68932ec4f0662f90e2e6624fbd747ad8e"),("experiments/external_sources/physics/snapshots/sftom-v1-e3-claims-emergence.py","sha256:627f1a340d656cf744449f3e7542ee6040a72766ba912c8ac4edb6149cdca446"),("experiments/external_sources/physics/snapshots/sftom-v1-e4-aggregate.py","sha256:b582bf60d4abdabdc4811e4f875f74248a7b7102de7cd7e25822ef3ff15d6f85")]
def requiredTarget : Value := .object [("source_entry",.text "E4"),("evidence_label",.text "OBS"),("declared_status",.text "measured"),("ensemble_denominator",.text "21"),("ensemble_member_count",.text "20"),("coupled_fold_step_count",.text "15"),("region_count",.text "12"),("complete_coupling_support",.array [.text "1/10",.text "1/3",.text "1/2",.text "7/10",.text "9/10"]),("printed_final_region_counts",.array [.text "7",.text "7",.text "1",.text "5",.text "5"])]
def requiredCustody : Value := .object [("formal_claim_contains_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_original_source_lines_retained",.boolean true),("all_coupling_rows_retained",.boolean true),("all_recurrence_coordinates_retained_after_release",.boolean true),("measurements_select_formal_survivor",.boolean false)]
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
    (← array (getDefault record "snapshots" (.array []))).length != 2 then
  throw "coupled-ensemble source record changed"
 if !requiredFields (getDefault record "registered_target" (.object [])) requiredTarget then
  throw "coupled-ensemble registered target changed"
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then
  throw "coupled-ensemble custody changed"
 pure record
def sourceLines (claims density : String) : Except String Unit := do
 if !Text.contains claims "for _ in range(15): pts=A.step(pts,Fraction(1,2))" ||
    !Text.contains claims "return A.occupied_regions(pts,12)==1" ||
    !Text.contains density "def step(points, g):" then
  throw "frozen E4 procedure lines changed"
 pure ()
def fileBytes (files : List (String × ByteArray)) (relative : String) : Except String ByteArray :=
 match files.find? (fun p => Text.equal p.1 relative) with
 | none => .error (Text.append "FileNotFoundError: " relative)
 | some p => .ok p.2
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "coupled-ensemble source identity changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let claims ← fileBytes files "experiments/external_sources/physics/snapshots/sftom-v1-e3-claims-emergence.py"
 let density ← fileBytes files "experiments/external_sources/physics/snapshots/sftom-v1-e4-aggregate.py"
 let _ ← sourceLines (String.ofList (Text.decode claims.size claims.data.toList))
  (String.ofList (Text.decode density.size density.data.toList))
 pure record
end SFT.Physics.SynchronizationRecords
