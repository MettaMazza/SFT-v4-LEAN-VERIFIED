import SFT.Physics.CoupledMapCriticalityEvidence
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.CriticalityRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "PH3-EXTERNAL-COUPLED-MAP-CRITICALITY"
def sourcePath : String := "experiments/external_sources/physics/snapshots/coupled-map-criticality-source-record.json"
def sourceHash : String := "sha256:a637fd6f2780279c0f38523e10e4c0b505e6a463c2dfb47d60fa60339456ac6c"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/coupled-map-criticality-source-record.json","sha256:a637fd6f2780279c0f38523e10e4c0b505e6a463c2dfb47d60fa60339456ac6c"),("experiments/external_sources/physics/snapshots/arxiv-nlin-0504012-coupled-logistic-threshold.pdf","sha256:6ec59cc2f85ed4d90ef3bd457b1f2877d92a4e10059548ab11297e363f588a4d"),("experiments/external_sources/physics/snapshots/pubmed-15447575-sync-threshold.xml","sha256:08ab034a50e7e6383669d3c6f607634c080cd741018628c4355eeeb8e142d8e1")]
def requiredKeys : List String := ["pubmed_id", "publication_doi", "criterion_inputs", "criterion_method", "criterion_empirical_status", "lattice_local_map", "coupling_class", "complete_synchronization_state", "stability_condition", "transverse_rate_relation", "threshold_lower_label", "threshold_upper_label", "ulam_local_rate_label", "normalized-zero-eigenratio-lower-bound", "finite_example_member_count", "finite_example_coupling", "finite_example_critical_alpha", "finite_time_distribution", "outside_window_behavior", "topology_independence_claimed"]
def requiredTarget : Value := .object [("pubmed_id",.text "15447575"),("publication_doi",.text "10.1103/PhysRevE.70.026217"),("normalized-zero-eigenratio-lower-bound",.text "half-One"),("topology_independence_claimed",.boolean false)]
def requiredCustody : Value := .object [("formal_claim_contains_external_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_registered_favorable_adverse_and_scope_rows_retained",.boolean true),("measurements_select_formal_survivor",.boolean false),("analytic_values_used_as_sft_proof_values",.boolean false)]
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
    (← array (getDefault record "snapshots" (.array []))).length != 2 then throw "PH3 source record changed"
 let target := getDefault record "registered_target" (.object [])
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "PH3 registered target changed"
 if !(keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredKeys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)) || !requiredFields target requiredTarget then throw "PH3 registered target changed"
 pure record
-- Extract the original three text nodes from the hash-locked PubMed document.
def afterOpening (opening : List Char) : List Char → Option (List Char)
 | [] => none
 | x::xs => if opening.isPrefixOf (x::xs) then some ((x::xs).drop opening.length) else afterOpening opening xs
def beforeClosing (closing : List Char) : List Char → List Char
 | [] => []
 | x::xs => if closing.isPrefixOf (x::xs) then [] else x::beforeClosing closing xs
def nodeText (document opening closing : String) : String :=
 match afterOpening (Text.chars opening) (Text.chars document) with
 | none => ""
 | some rest => String.ofList (beforeClosing (Text.chars closing) rest)
def pubmedBoundary (document : String) (target : Value) : Except String Unit := do
 let title := nodeText document "<ArticleTitle>" "</ArticleTitle>"
 let abstract := nodeText document "<AbstractText>" "</AbstractText>"
 let doi := nodeText document "<ArticleId IdType=\"doi\">" "</ArticleId>"
 if !Text.contains title "Simple estimation of synchronization threshold" ||
    !Text.contains abstract "largest Lyapunov exponent and the coupling coefficient" ||
    !Text.contains abstract "Numerical simulations confirm" ||
    !Text.equal (render (.text doi)) (render (getDefault target "publication_doi")) then throw "PH3 PubMed record changed"
 pure ()
def custodyBoundary (record : Value) : Except String Value := do
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then throw "PH3 custody changed"
 pure record
def fileBytes (files : List (String × ByteArray)) (relative : String) : Except String ByteArray :=
 match files.find? (fun p => Text.equal p.1 relative) with
 | none => .error (Text.append "FileNotFoundError: " relative)
 | some p => .ok p.2
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "PH3 source identity changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 let xml ← fileBytes files "experiments/external_sources/physics/snapshots/pubmed-15447575-sync-threshold.xml"
 let document := String.ofList (Text.decode xml.size xml.data.toList)
 let _ ← pubmedBoundary document (getDefault record "registered_target" (.object []))
 custodyBoundary record
end SFT.Physics.CriticalityRecords
