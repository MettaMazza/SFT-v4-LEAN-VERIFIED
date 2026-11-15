import SFT.Physics.PostNewtonianFixedPointEvidence
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.PostNewtonianRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "D9M-POST-NEWTONIAN-FIXED-POINT-COMPARISON"
def sourcePath : String := "experiments/external_sources/physics/snapshots/post-newtonian-fixed-point-source-record.json"
def sourceHash : String := "sha256:672d9fcdc4f60a7d51312909908082304bc95ea3c6166a06816124b69199d50d"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/post-newtonian-fixed-point-source-record.json","sha256:672d9fcdc4f60a7d51312909908082304bc95ea3c6166a06816124b69199d50d"),("audits/v1_theorem_manifest_observation_census.json","sha256:05c7c285e87720c0b22a69cc69b07cdd9749a1aa1728afd934e1ed9f7c30ce93"),("audits/v2_407_step_observation_census.json","sha256:abc262ac488a35eb00ab38bf5c94b7b3c7a49110868ab86275c27e454eb62d3f"),("experiments/external_sources/physics/snapshots/arxiv-1310.1528-post-newtonian-theory.pdf","sha256:c3b1b7c454e15b65bade4245a8e6d61b6e5c0546baaee436a17b99ef6983b4a8")]
def requiredKeys : List String := ["v1_source_entry", "v1_corrections", "v1_relation", "v2_source_step", "v2_map", "v2_matter_source", "v2_coupling", "v2_fixed_point", "external_scheme", "external_nonlinearity", "external_1PN_scalar_structure", "external_domain", "external_formal_order", "external_universal_numeric_convergence_claimed", "measured_parameter_fitted"]
def requiredTarget : Value := .object [("v1_corrections",.array [.text "7/50",.text "7/150",.text "7/1350",.text "7/109350"]),("v2_source_step",.text "179"),("external_universal_numeric_convergence_claimed",.boolean false),("measured_parameter_fitted",.boolean false)]
def requiredCustody : Value := .object [("formal_claim_contains_historical_or_external_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_historical_and_external_rows_retained",.boolean true),("targets_select_formal_survivor",.boolean false)]
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
    (← array (getDefault record "snapshots" (.array []))).length != 3 then throw "D9m target record changed"
 let target := getDefault record "registered_target" (.object [])
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "D9m target record changed"
 if !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) || !requiredFields target requiredTarget then throw "D9m target record changed"
 pure record
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "D9m custody changed"
 pure record
def fileBytes (files : List (String × ByteArray)) (relative : String) : Except String ByteArray :=
 match files.find? (fun p => Text.equal p.1 relative) with
 | none => .error (Text.append "FileNotFoundError: " relative)
 | some p => .ok p.2
def historicalBoundary (v1 v2 : Value) : Except String Unit := do
 let rows ← array (← field v1 "rows")
 let steps ← array (← field v2 "steps")
 let first ← match rows.find? (fun row => sameValue (getDefault row "v1_claim_id") (.text "D9m")) with
  | none => .error "StopIteration"
  | some row => .ok row
 let second ← match steps.find? (fun row => sameValue (getDefault row "step") (.integer 179)) with
  | none => .error "StopIteration"
  | some row => .ok row
 let a ← text (← field first "prior_result_observation")
 let b ← text (← field second "prior_result_observation")
 if !Text.contains a "7/50, 7/150, 7/1350, 7/109350" || !Text.contains b "f = g" || !Text.contains b "f* = 1/4" then throw "D9m historical rows changed"
 pure ()
def authoritativeRecord (files : List (String × ByteArray)) (payload v1 v2 : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "D9m source changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let _ ← historicalBoundary v1 v2
 custodyBoundary record
end SFT.Physics.PostNewtonianRecords
