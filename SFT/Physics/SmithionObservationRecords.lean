import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.SmithionObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
def sourcePath : String := "experiments/external_sources/physics/snapshots/dark-smithion-lfv-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/dark-smithion-lfv-postseal-source-record.json","sha256:ed0dba82cdd49f67258eb152466a629d9086804197d2c56bcfdc49e2849345f3"),("experiments/external_sources/physics/snapshots/planck-2018-density-abstract-record.json","sha256:274e0189de5846ce0b8c2d7b83ae06c72587cf8325d4d2b2338e88dd0a74a88f"),("experiments/external_sources/physics/snapshots/arxiv-1606.09251-sparc.pdf","sha256:d089215877213661e40965543ee7e05736619082ad16d95e65ec059029588c63"),("experiments/external_sources/physics/snapshots/arxiv-2504.15711-megii-lfv.pdf","sha256:0efbf99543c92d340eb7b07f40e6fea580b7746caab26c9233d3e30e8b71a5b6"),("experiments/external_sources/physics/snapshots/arxiv-0908.2381-babar-tau-lfv.pdf","sha256:ba3e1352f4c14b1867e06f6436b4a6b1e1980cd55ce52d9a9454bd618ed70015")]
def sourceIds : List String := ["PLANCK-2018-VI-ABSTRACT-DENSITIES", "SPARC-2016-175-GALAXY-MASS-MODELS", "MEGII-2025-MU-E-GAMMA", "BABAR-2010-TAU-LFV-GAMMA"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "dark/Smithion/LFV source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-dark-smithion-lfv-postseal-source-record/1") || !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:71a131119ffd152690ec772019177fb06599474cd5e89b60a62c1b9b69ec5762") then throw "formal binding or schema changed"
 let sources ← array (getDefault record "sources" (.array []))
 if !sameValue (.array (sources.map (fun row=>getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then throw "complete four-source record required"
 let boundary := getDefault record "methodological_boundary" (.object [])
 if !ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false || !["all_presently_measurable_rows_retained","unobserved_new_particle_masses_not_relabelled_as_measurements","upper_limits_not_relabelled_as_rate_measurements"].all (fun key=>ThermometryMeasurement.literalBoolean (getDefault boundary key) true) then throw "methodological boundary changed"
 .ok record
end SFT.Physics.SmithionObservationRecords
