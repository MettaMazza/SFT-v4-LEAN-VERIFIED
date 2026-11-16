import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.StrongCPObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
def sourcePath : String := "experiments/external_sources/physics/snapshots/strong-cp-baryon-stability-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/strong-cp-baryon-stability-postseal-source-record.json","sha256:80475bde8d961642a902c84e0e1043c36a8a55d12430b72b18c6015e0c7a51db"),("experiments/external_sources/physics/snapshots/arxiv-2001.11966-nedm.pdf","sha256:1afeb830f372c7725cca9fd3d004333fe19cade698fd9798af9dfac7adc5c180"),("experiments/external_sources/physics/snapshots/arxiv-2010.16098-proton-e-pi0.pdf","sha256:6fa532b3b2671e8d6e028308297b95837567a6e3608b471aaa8af00fff6a9679"),("experiments/external_sources/physics/snapshots/arxiv-2409.19633-proton-eta.pdf","sha256:5b4bf694378930d7e38935546fea9c5deced9531137b0da276778e7b67fb4937"),("experiments/external_sources/physics/snapshots/arxiv-2604.10975-proton-two-pi0.pdf","sha256:06d10f843d39b54a14465628d72a9af18920976369326b1c717e3621b2109c98")]
def sourceIds : List String := ["NEDM-2020-PSI-PERMANENT-EDM", "SUPERK-2020-PROTON-E-MU-PI0", "SUPERK-2024-PROTON-E-MU-ETA", "SUPERK-2026-PROTON-E-MU-TWO-PI0"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "strong-CP/baryon source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-strong-cp-baryon-stability-postseal-source-record/1") then throw "strong-CP/baryon source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:6bd69d2eb78150c11fefc82f512bdfd775eaa2f3a2667127407d7a34bd695657") then throw "formal receipt binding changed"
 let sources ← array (getDefault record "sources" (.array []))
 if !sameValue (.array (sources.map (fun row=>getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then throw "complete four-source vector required"
 let boundary := getDefault record "methodological_boundary" (.object [])
 if !ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false || !["all_registered_modes_and_uncertainties_retained","background_compatible_candidates_not_relabelled_as_decay","finite_limits_not_relabelled_as_completed_infinity","null_central_estimate_not_relabelled_as_numerical_proof_zero"].all (fun key=>ThermometryMeasurement.literalBoolean (getDefault boundary key) true) then throw "methodological boundary changed"
 .ok record
end SFT.Physics.StrongCPObservationRecords
