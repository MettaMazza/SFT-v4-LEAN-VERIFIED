import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.HorizonObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
def sourcePath : String := "experiments/external_sources/physics/snapshots/compact-horizon-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/compact-horizon-postseal-source-record.json","sha256:670c9467f5638513c16345de4ce15da834ed46a358ed40371160d951e739921d"),("experiments/external_sources/physics/snapshots/nasa-gsfc-white-dwarf-chandrasekhar.html","sha256:29d25e42773e2b6c5c5f292ef97b6abb28e430f4b6af6336720ee5e3d41aa2a5"),("experiments/external_sources/physics/snapshots/arxiv-2104.00880-psr-j0740-mass.pdf","sha256:66c7fbaacc06a5fa3513a7d963d2b300b05a0a52552e2358e9f257940f37b47a"),("experiments/external_sources/physics/snapshots/ligo-p1800379-gw170817-remnant.pdf","sha256:86d4efa4b4c5153799edf278bcd99b10753540337c876fbf505855b8bb949122")]
def sourceIds : List String := ["NASA-GSFC-WHITE-DWARF-CHANDRASEKHAR", "FONSECA-2021-PSR-J0740-MASS", "LIGO-VIRGO-2019-GW170817-REMNANT"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "compact-object source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-compact-horizon-postseal-source-record/1") then throw "compact-object source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:69152da01b20c6b1a7ab6ecfab4e44cf836d588cba4ea6f3b02d5827cb5a0b3f") then throw "formal compact-object receipt binding changed"
 let sources ← array (getDefault record "sources" (.array []))
 if !sameValue (.array (sources.map (fun row=>getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then throw "complete ordered three-source compact-object vector required"
 let boundary := getDefault record "methodological_boundary" (.object [])
 if !ThermometryMeasurement.literalBoolean (getDefault boundary "external_measurement_selected_formal_survivor") false then throw "measurement selected the formal survivor"
 if !["formal_receipt_existed_before_source_binding", "all_three_source_rows_retained", "theoretical_summary_distinguished_from_direct_measurement", "conditional_merger_limits_identified_as_model_assisted", "neutron_star_mass_not_relabelled_as_the_maximum", "hawking_nonobservation_not_rewarded_as_a_match", "reported_signed_or_decimal_coordinates_not_used_as_fold_proof_scalars"].all (fun key=>ThermometryMeasurement.literalBoolean (getDefault boundary key) true) then throw "compact-object methodological boundary changed"
 .ok record
end SFT.Physics.HorizonObservationRecords
