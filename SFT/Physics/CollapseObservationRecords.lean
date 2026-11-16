import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.CollapseObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
def sourcePath : String := "experiments/external_sources/physics/snapshots/stellar-nuclear-collapse-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/stellar-nuclear-collapse-postseal-source-record.json","sha256:4315620e6c801de49869a6fe693e61ae5b5b5ced82bd8896b733c50f7a4809bd"),("experiments/external_sources/physics/snapshots/nasa-gsfc-stellar-stage-table.html","sha256:156c6ce406b0ec49ceac6921ad36fccf5d8778fb5cec7539e24ee8cce961a794"),("experiments/external_sources/physics/snapshots/arxiv-2006.15115-borexino-cno.pdf","sha256:d61241252a22a4c9614d5a29a05cf7d211c4a8dde9dec77fe21e242238ed736d"),("experiments/external_sources/physics/snapshots/arxiv-astro-ph-0107260-sn1987a-neutrinos.pdf","sha256:72b8acc99ba37cf8557492669ce53851bf154b95950c7fc34e53a6681599b2d2"),("experiments/external_sources/physics/snapshots/arxiv-1409.5477-sn2014j-gamma.pdf","sha256:aaf0bc90867cdc5e13a8ee2dfd83a23def499e5d5be9bf3f7506e56e6afdaae1"),("experiments/external_sources/physics/snapshots/arxiv-1910.10510-gw170817-strontium.pdf","sha256:34b7f1a277959937f868e6987ec8ce39d481165fccbea8cbab6cfa27457e77c1")]
def sourceIds : List String := ["NASA-GSFC-COSMIC-ELEMENTS-STELLAR-STAGES", "BOREXINO-2020-CNO-NEUTRINOS", "LOREDO-LAMB-2001-SN1987A-NEUTRINOS", "DIEHL-2014-SN2014J-GAMMA-LINES", "WATSON-2019-GW170817-STRONTIUM"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "stellar nuclear/collapse source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-stellar-nuclear-collapse-postseal-source-record/1") then throw "stellar nuclear/collapse source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:a41b28a935f54de5daabdbe77b6c1aba9286f174526b8feaa60829ec848e08af") then throw "formal stellar nuclear/collapse receipt binding changed"
 let sources ← array (getDefault record "sources" (.array []))
 if !sameValue (.array (sources.map (fun row=>getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then throw "complete ordered five-source vector required"
 let boundary := getDefault record "methodological_boundary" (.object [])
 if !ThermometryMeasurement.literalBoolean (getDefault boundary "external_measurement_selected_formal_survivor") false then throw "measurement selected formal survivor"
 if !["all_six_stage_rows_and_nonmonotonic_duration_row_retained", "development_targets_already_known", "model_assisted_interpretations_identified", "observational_rows_opened_only_after_formal_receipt", "reported_signed_coordinate_not_used_as_fold_proof_scalar"].all (fun key=>ThermometryMeasurement.literalBoolean (getDefault boundary key) true) then throw "stellar nuclear/collapse methodological boundary changed"
 .ok record
end SFT.Physics.CollapseObservationRecords
