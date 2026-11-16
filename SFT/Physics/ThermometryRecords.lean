import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.ThermometryRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/thermal-equilibrium-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/thermal-equilibrium-postseal-source-record.json","sha256:8048a2397c064290a0b948b4238b4133c1a2e5c76a72ecf0c47222c9a951d7b5"),("experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("experiments/external_sources/physics/snapshots/nist-acoustic-boltzmann-2017.pdf","sha256:1cbb21f0e5817270b5e028105aa79fea22017fd84130c2c4b79d1492fb37e418"),("experiments/external_sources/physics/snapshots/nist-electronic-boltzmann-2011.pdf","sha256:187066b5390d57a3c058e0a34f6c7803a659045ba714ca4b25eed7b84b212bbb")]
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "thermal-equilibrium source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-thermal-equilibrium-postseal-source-record/1") then
  throw "thermal-equilibrium source schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:cf536f7516eb1c85bb075500d9c1a0ebd64bdddb544878f26a27424d08de25bf") then
  throw "formal thermal-equilibrium receipt binding changed"
 if (← array (getDefault payload "sources" (.array []))).length != 3 then
  throw "complete three-source thermometry record required"
 pure payload
def sourceIds : List String := ["NIST-CODATA-2022-BOLTZMANN","NIM-NIST-ACOUSTIC-BOLTZMANN-2017","NIST-JOHNSON-NOISE-BOLTZMANN-2011"]
end SFT.Physics.ThermometryRecords
