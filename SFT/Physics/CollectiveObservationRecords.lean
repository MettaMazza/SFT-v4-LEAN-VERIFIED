import SFT.Physics.FizeauRecords
namespace SFT.Physics.CollectiveObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourcePath : String := "experiments/external_sources/physics/snapshots/collective-radiation-postseal-source-record.json"
def sourceHash : String := "sha256:fb68982f853344dbb055e0a7bb51512d6b3f631044ae3e89b81c86ec019c7470"
def sourceIds : List String := ["NIST-COBLENTZ-BLACKBODY","NIST-DIODE-LASER-LINEWIDTH","NBS-ACOUSTIC-CAVITY-1986","NASA-PLASMA-FREQUENCY-PROBE-1992","NASA-STEREO-ALFVEN-LIST"]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/collective-radiation-postseal-source-record.json","sha256:fb68982f853344dbb055e0a7bb51512d6b3f631044ae3e89b81c86ec019c7470"),("experiments/external_sources/physics/snapshots/nist-blackbody-coblentz.html","sha256:deb600e47fd138dfe82aef3271b19f2030cd7cd3e4fa202ef80f4f1ae82eec71"),("experiments/external_sources/physics/snapshots/nist-diode-laser-linewidth.html","sha256:7c0a9a1b4dc19b573cb6603f87453161508784ca59ec26ed698b0354bb7520b6"),("experiments/external_sources/physics/snapshots/nist-acoustic-cavity-resonance.pdf","sha256:f4dbf2b01604b8a6f26621bb8bafa856913e25158a8635f7454838ef5360f1b4"),("experiments/external_sources/physics/snapshots/nasa-plasma-frequency-probe.html","sha256:4fff15fe03f66e4009ca34e83f0d0ea02e66b2d40e92ee987ae46f437f39f36c"),("experiments/external_sources/physics/snapshots/nasa-stereo-alfven-wave-list.html","sha256:da0eab2e7955e0670d734c905c360758aabe57bb900de277e42da13fa0314385")]
def payloadBoundary (record : Value) : Except String Value := do
 if !sameValue (getDefault record "schema") (.text "sft-v3-collective-radiation-postseal-source-record/1") then throw "source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:50974ab152438d8b84fe8220281e0d98737df0880f9a6384d50bac6060987b07") then throw "formal receipt binding changed"
 let count ← FizeauRecords.recordLength (getDefault record "sources" (.array []))
 if count != 5 then throw "complete five-source record required"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "collective-radiation source changed: " relative)
  pure ())
 payloadBoundary payload
end SFT.Physics.CollectiveObservationRecords
