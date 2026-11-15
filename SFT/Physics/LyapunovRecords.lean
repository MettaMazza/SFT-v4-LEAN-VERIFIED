import SFT.Physics.LyapunovKSCorrespondenceEvidence
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.LyapunovRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "PH2-EXTERNAL-LYAPUNOV-KS-CORRESPONDENCE"
def sourcePath : String := "experiments/external_sources/physics/snapshots/lyapunov-ks-correspondence-source-record.json"
def sourceHash : String := "sha256:a23b394f6da97239f1cba263b949a7ca14d34ac26e657437807be5216c9c0be3"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/lyapunov-ks-correspondence-source-record.json","sha256:a23b394f6da97239f1cba263b949a7ca14d34ac26e657437807be5216c9c0be3"),("experiments/external_sources/physics/snapshots/arxiv-1211.1234-chaotic-map-trng.pdf","sha256:716c6b68b4755f47087747f67f4b2c4a7ed0ade30f77391a18129f2ad76de6c9"),("experiments/external_sources/physics/snapshots/arxiv-1004.3441-pesin-entropy-formula.pdf","sha256:ea560114c9cc196e18feb4536f63f28c292dadda465aafcb9f41ef12c20ac090")]
def requiredTarget : Value := .object [("direct_map_case",.text "complete-two-branch-Bernoulli-map"),("map_piece_count",.text "2"),("absolute_branch_slope",.text "2"),("preimage_count",.text "2"),("stationary_distribution",.text "uniform"),("output_alphabet_size",.text "2"),("output_symbols",.text "independent-and-equiprobable"),("conventional_lyapunov_label",.text "natural-logarithm-of-two"),("conventional_information_rate_label",.text "one-bit-per-step"),("entropy_formula_scope",.text "conditional-on-the-stated-regularity-invariance-and-splitting-hypotheses"),("entropy_formula_relation",.text "metric-entropy-equals-integrated-sum-of-positive-Lyapunov-exponents")]
def requiredCustody : Value := .object [("formal_claim_contains_external_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_registered_comparison_rows_retained",.boolean true),("measurements_select_formal_survivor",.boolean false),("analytic_logarithms_used_as_sft_proof_values",.boolean false)]
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
  throw "PH2 source record changed"
 if !requiredFields (getDefault record "registered_target" (.object [])) requiredTarget then
  throw "PH2 registered target changed"
 if !requiredFields (getDefault record "custody" (.object [])) requiredCustody then
  throw "PH2 custody changed"
 pure record
def fileBytes (files : List (String × ByteArray)) (relative : String) : Except String ByteArray :=
 match files.find? (fun p => Text.equal p.1 relative) with
 | none => .error (Text.append "FileNotFoundError: " relative)
 | some p => .ok p.2
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "PH2 source identity changed: " relative)
  pure ())
 let record ← payloadBoundary payload
 pure record
end SFT.Physics.LyapunovRecords
