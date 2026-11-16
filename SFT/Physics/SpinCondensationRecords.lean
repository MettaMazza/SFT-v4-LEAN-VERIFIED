import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.SpinCondensationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/spin-statistics-condensation-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/spin-statistics-condensation-postseal-source-record.json","sha256:9d24c12e31092f34854c71c3dce2b355dd1d1f2ae6347a03bbea45ef01508cfa"),("experiments/external_sources/physics/snapshots/ensher-bec-ground-occupation-1996.pdf","sha256:9086058e1c750191fb36eab5acf7c65da1aa7f0e4cdcf643887e282ad3920c93"),("experiments/external_sources/physics/snapshots/nist-pauli-blocking-2001.html","sha256:82555a4057e339aef96cde7484fe3fbd190a8d2cecbf4c3de73996af473b9af7"),("experiments/external_sources/physics/snapshots/rauch-spinor-rotation-1975.pdf","sha256:11638b8c2aaf8fbdd96aa50c9496bb9f7597b308f19d780ab779cc2dd6752824")]
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "spin-statistics source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-spin-statistics-condensation-postseal-source-record/1") then
  throw "spin-statistics source schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:f71da5b86f99d6569a1f33dc6fc37024cc5d458b12e625c5dbc4faf3c33ccda7") then
  throw "formal spin-statistics receipt binding changed"
 if (← array (getDefault payload "sources" (.array []))).length != 3 then
  throw "complete three-source spin-statistics record required"
 pure payload
def sourceIds : List String := ["APS-JILA-BEC-GROUND-OCCUPATION-1996", "NIST-JILA-PAULI-BLOCKING-2001", "RAUCH-COHERENT-SPINOR-ROTATION-1975"]
end SFT.Physics.SpinCondensationRecords
