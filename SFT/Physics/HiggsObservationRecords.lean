import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.HiggsObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
def sourcePath : String := "experiments/external_sources/physics/snapshots/higgs-terminal-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/higgs-terminal-postseal-source-record.json","sha256:62d866e1b94f43e7cb73c9da46ac672434e00b4f8bc628b17f4060e8fb019d21"),("experiments/external_sources/physics/snapshots/pdg-2024-standard-model-review.pdf","sha256:4689caae925ee279228684249333a8395a40dda74a94863549b48f758d3fdd3f"),("experiments/external_sources/physics/snapshots/pdg-2025-higgs-listing.pdf","sha256:228835096e2003bb332f456ad412cbfbd628a6973be715309da7d2f419ac77bc"),("experiments/external_sources/physics/snapshots/arxiv-2308.04775-atlas-higgs-mass.pdf","sha256:b3d2c09226e54f4553a381c70e41095f8f1c18aec3aabbc845e0481aa9207e4e"),("experiments/external_sources/physics/snapshots/arxiv-2409.13663-cms-higgs-mass.pdf","sha256:8dfaa73b5df3a958998a1a95dc123dc02013ef22c0a4fc3f82253550fc1c1807"),("experiments/external_sources/physics/snapshots/arxiv-2602.23991-atlas-cms-hh.pdf","sha256:eaf44d724e33f500781a964a2918b5d2062c55be760704736346233ed02ff678")]
def sourceIds : List String := ["PDG-2024-ELECTROWEAK-VACUUM-SCALE", "PDG-2025-HIGGS-MASS-AVERAGE", "ATLAS-2023-COMBINED-HIGGS-MASS", "CMS-2024-FOUR-LEPTON-HIGGS-MASS", "ATLAS-CMS-2026-HIGGS-PAIR-COMBINATION"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "Higgs terminal source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-higgs-terminal-postseal-source-record/1") then throw "Higgs terminal source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:3f84e4ede48a489bc78a8cc47eac935bbff3566d1e561c26ef0059d7bbcbfb1e") then throw "formal receipt binding changed"
 let sources ← array (getDefault record "sources" (.array []))
 if !sameValue (.array (sources.map (fun row=>getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then throw "complete five-source Higgs vector required"
 let boundary := getDefault record "methodological_boundary" (.object [])
 if !ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false then throw "measurement selected formal survivor"
 if !ThermometryMeasurement.literalBoolean (getDefault boundary "external_scale_selected_formal_ratio") false then throw "external scale selected formal ratio"
 if !["aggregate_and_individual_mass_rows_retained","individual_offsets_not_erased_by_aggregate","reported_signed_coordinate_not_used_as_fold_proof_scalar","self_coupling_limit_not_relabelled_as_direct_precision_measurement"].all (fun key=>ThermometryMeasurement.literalBoolean (getDefault boundary key) true) then throw "Higgs methodological boundary changed"
 .ok record
end SFT.Physics.HiggsObservationRecords
