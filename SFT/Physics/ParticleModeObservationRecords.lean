import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.ParticleModeObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 20000
def sourcePath : String := "experiments/external_sources/physics/snapshots/particle-mode-generation-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/particle-mode-generation-postseal-source-record.json","sha256:abf29f6244ad64e49b169489675627424bcdbdc3d38e8ceef4b1628681889cd5"),("experiments/external_sources/physics/snapshots/pdg-2025-leptons-summary.pdf","sha256:5aa9a3a33b554204056cb04c42319bb32c9664ae518907652ff5cdc1cb87e5bb"),("experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("experiments/external_sources/physics/snapshots/pdg-2025-quark-masses.pdf","sha256:d544d099aa15739ec83d87711bd4c5b1e0a1032d6f70aaa4847ec78601f7aeae"),("experiments/external_sources/physics/snapshots/pdg-2025-ckm-matrix.pdf","sha256:a0a78578971f38ff89c6fc5579bc608de41ec383a205dc25cba1d26f7145610a"),("experiments/external_sources/physics/snapshots/pdg-2025-neutrino-mixing.pdf","sha256:d7067e2e3c9098cc924f10ffbca579c557fb8e848bf3acc17f9815598cdda7a6")]
def sourceIds : List String := ["PDG-2025-LEPTON-SUMMARY", "NIST-CODATA-2022-ALL-CONSTANTS", "PDG-2025-QUARK-MASSES", "PDG-2025-CKM-MATRIX", "PDG-2025-NEUTRINO-MIXING"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "particle-mode generation source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-particle-mode-generation-postseal-source-record/1") then throw "particle-mode generation source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:18e4aac0792a01c613d31f4d980951b0e2da69107155c4e50967ed80c9eaa700") then throw "particle-mode generation formal binding changed"
 let sources ← array (getDefault record "sources" (.array []))
 if !sameValue (.array (sources.map (fun row=>getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then throw "complete five-source particle-mode record required"
 let boundary := getDefault record "interpretive_boundary" (.object [])
 let required : List (String × Value) := match boundary with
  | .object fields => fields.filter (fun (key,_)=>!(Text.equal key "measurement_selected_formal_survivor" || Text.equal key "blind_forward_discovery_claimed"))
  | .null | .boolean _ | .integer _ | .text _ | .array _ => []
 if !required.all (fun (_,v)=>ThermometryMeasurement.literalBoolean v true) ||
  !ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false ||
  !ThermometryMeasurement.literalBoolean (getDefault boundary "blind_forward_discovery_claimed") false then throw "particle-mode interpretation boundary changed"
 .ok record
end SFT.Physics.ParticleModeObservationRecords
