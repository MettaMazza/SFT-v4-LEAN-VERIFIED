import SFT.Physics.FizeauRecords
namespace SFT.Physics.InflationObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourcePath : String := "experiments/external_sources/physics/snapshots/inflation-growth-postseal-source-record.json"
def sourceHash : String := "sha256:b04ac2ae7426e91117f0f7594019354fd4921629b22e42dbc38d3acce93ff45b"
def sourceIds : List String := ["PLANCK-2018-INFLATION","BICEP-PLANCK-2022-TENSOR"]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/inflation-growth-postseal-source-record.json","sha256:b04ac2ae7426e91117f0f7594019354fd4921629b22e42dbc38d3acce93ff45b"),("experiments/external_sources/physics/snapshots/arxiv-1807.06211-planck-inflation.pdf","sha256:fa728dc0198ccfddd7132c0e0a29cca586a1431a045568a33d7a197a0427427d"),("experiments/external_sources/physics/snapshots/arxiv-2112.07961-bicep-planck-tensor.pdf","sha256:5a1add11c98a8e5c4d70fd438eacd5242aa10631ffea0c72358f49e59eda07f2")]
def expectedTarget : List (String × Value) := [("planck_scalar_index_central",.text "0.9649"),("planck_scalar_index_standard_uncertainty",.text "0.0042"),("bicep_planck_tensor_ratio_upper_95",.text "0.032"),("tensor_bound_strict",.boolean true),("all_registered_rows_retained",.boolean true)]
def requiredCustody : List String := ["formal_receipt_precedes_source_retrieval","target_inaccessible_to_formal_executable","target_did_not_rewrite_formal_survivor","complete_uncertainty_and_bound_rows_retained","no_conventional_efold_value_asserted"]
def payloadBoundary (record : Value) : Except String Value := do
 if !sameValue (getDefault record "schema") (.text "sft-v3-inflation-growth-postseal-source-record/1") then throw "inflation-growth source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:00aa52b47f8ebfe57fb5a90530a54614ba175d87f6708c69e454fcf9fd888aa7") then throw "inflation-growth formal receipt binding changed"
 let count ← FizeauRecords.recordLength (getDefault record "sources" (.array []))
 if count != 2 then throw "complete two-source record is required"
 let target := getDefault record "registered_target" (.object [])
 if !expectedTarget.all (fun (k,v) => sameValue (getDefault target k) v || (sameValue v (.boolean true) && sameValue (getDefault target k) (.integer 1))) then throw "inflation-growth target row changed"
 let custody := getDefault record "row_custody" (.object [])
 if !requiredCustody.all (fun k => sameValue (getDefault custody k) (.boolean true)) then throw "inflation-growth custody record changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "inflation-growth source identity changed: " relative)
  pure ())
 payloadBoundary payload
end SFT.Physics.InflationObservationRecords
