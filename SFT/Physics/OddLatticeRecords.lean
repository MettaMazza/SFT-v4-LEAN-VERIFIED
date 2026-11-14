import SFT.Physics.OddLatticeAllRegionEvidence
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.OddLatticeRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "SFTOM-V1-E3-EXACT-OBSERVATION"
def sourcePath : String := "experiments/external_sources/physics/snapshots/odd-lattice-all-region-source-record.json"
def sourceHash : String := "sha256:9ea9421a47a6945d08915e0bdc03ec96b89e981718d99a84fe1ceae9e118cbfc"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/odd-lattice-all-region-source-record.json","sha256:9ea9421a47a6945d08915e0bdc03ec96b89e981718d99a84fe1ceae9e118cbfc"),("experiments/external_sources/physics/snapshots/sftom-v1-e3-claims-emergence.py","sha256:627f1a340d656cf744449f3e7542ee6040a72766ba912c8ac4edb6149cdca446"),("experiments/external_sources/physics/snapshots/sftom-v1-e3-density.py","sha256:a4fdd45d43307d7a5ecf0bcc2cdca68b5290da48f8c4ce1c0abf33bcf22d397b")]
def requiredTarget : Value := .object [("source_entry",.text "E3"),("evidence_label",.text "OBS"),("declared_status",.text "measured"),("lattice_member_count",.text "255"),("fold_step_count",.text "12"),("region_count",.text "8"),("legacy_acceptance_rule",.text "every one of the eight region tallies is positive")]
def requiredCustody : Value := .object [("development_target_already_known",.boolean true),("formal_claim_contains_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_original_source_lines_retained",.boolean true),("all_result_coordinates_retained_after_release",.boolean true),("measurements_select_formal_survivor",.boolean false),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-replication")]
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
  throw "odd-lattice source record identity changed"
 if !requiredFields (getDefault record "registered_target" (.object [])) requiredTarget then
  throw "odd-lattice registered target changed"
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then
  throw "odd-lattice custody record changed"
 pure record
def sourceLines (claims density : String) : Except String Unit := do
 if !Text.contains claims "occ=D.occupancy(D.even_lattice(255),12,8)" ||
    !Text.contains claims "return all(occ)" ||
    !Text.contains density "def occupancy(starts, folds, regions):" ||
    !Text.contains density "def even_lattice(N):  return [Fraction(i,N) for i in range(1,N+1)]" then
  throw "frozen E3 procedure lines changed"
 pure ()
def fileBytes (files : List (String × ByteArray)) (relative : String) : Except String ByteArray :=
 match files.find? (fun p => Text.equal p.1 relative) with
 | none => .error (Text.append "FileNotFoundError: " relative)
 | some p => .ok p.2
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "odd-lattice observation source identity changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let claims ← fileBytes files "experiments/external_sources/physics/snapshots/sftom-v1-e3-claims-emergence.py"
 let density ← fileBytes files "experiments/external_sources/physics/snapshots/sftom-v1-e3-density.py"
 let _ ← sourceLines (String.ofList (Text.decode claims.size claims.data.toList))
  (String.ofList (Text.decode density.size density.data.toList))
 pure record
end SFT.Physics.OddLatticeRecords
