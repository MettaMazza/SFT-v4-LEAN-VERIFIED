import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.ChirpObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
def sourcePath : String := "experiments/external_sources/physics/snapshots/gravitational-wave-chirp-ringdown-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/gravitational-wave-chirp-ringdown-postseal-source-record.json","sha256:b24e9d1e8fc37f39bcbc692ac7cfaddbe7666bc4e161880ff45708d958ed1d92"),("experiments/external_sources/physics/snapshots/ligo-p150914-gw150914-discovery.pdf","sha256:e5e864c23d015b69be17e5b5d51b5b462d2829353a867513414b6728f54589c4"),("experiments/external_sources/physics/snapshots/ligo-p151226-gw151226-discovery.pdf","sha256:a59bb954e9850a8800e2b62e1808553012e791b879e00f108b0bf061bf530e72"),("experiments/external_sources/physics/snapshots/ligo-p2000020-gw190521-discovery.pdf","sha256:4d6661f18168267249b3ca043b0692d88376c9db9b3d9146a9500763f7b438a7")]
def sourceIds : List String := ["LIGO-VIRGO-GW151226-DISCOVERY-2016", "LIGO-VIRGO-GW190521-DISCOVERY-2020"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "gravitational-wave source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-gravitational-wave-chirp-ringdown-postseal-source-record/1") then throw "gravitational-wave source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:7add0b09e795aee79758286268637f442b40155f4af5c83a4a123f90e2150e19") then throw "formal chirp/ringdown receipt binding changed"
 let sources ← array (getDefault record "withheld_postseal_sources" (.array []))
 if !sameValue (.array (sources.map (fun row=>getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then throw "complete ordered two-source post-seal vector required"
 let boundary := getDefault record "methodological_boundary" (.object [])
 if !ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false then throw "gravitational-wave methodological boundary changed"
 if !["formal_receipt_existed_before_withheld_source_binding", "gw150914_retained_as_preseal_development_context", "gw150914_not_counted_as_blind_validation", "all_postseal_source_rows_retained", "dimensional_frequency_not_imported_as_fold_proof_scalar", "model_assisted_mass_and_ringdown_roles_retained", "exact_half_One_damping_not_claimed_as_directly_measured", "cross_event_stage_support_explicit"].all (fun key=>ThermometryMeasurement.literalBoolean (getDefault boundary key) true) then throw "gravitational-wave methodological boundary changed"
 .ok record
end SFT.Physics.ChirpObservationRecords
