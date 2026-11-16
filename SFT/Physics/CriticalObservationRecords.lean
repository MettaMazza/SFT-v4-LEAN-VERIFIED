import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.CriticalObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
def sourcePath : String := "experiments/external_sources/physics/snapshots/criticality-universality-turbulence-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/criticality-universality-turbulence-postseal-source-record.json","sha256:7c3cb34584f3581b46c9c9e1f91d2c550cfd8441761a512fee767baf8cc801fa"),("experiments/external_sources/physics/snapshots/cetin-manganite-critical-exponents-2026.html","sha256:afd0f783bd40b8ed376238eda9b254387c75c0c26ecc57488ab9b81b33d1d455"),("experiments/external_sources/physics/snapshots/lin-erbium-critical-scattering-1993.html","sha256:d8b6495b7defb46daa4d1162967d11b4680012ebd4a8e6d60e8892b83b9b3564"),("experiments/external_sources/physics/snapshots/mccomb-turbulence-structure-exponent-2014.pdf","sha256:0c9f4321b52f78fe64b02684b4139a450955c12092c4faf8487f49bf6ff1d0f5"),("experiments/external_sources/physics/snapshots/huang-turbulence-spectrum-2010.pdf","sha256:1bff196a24bc3f852dd384469c5f8e4112fcdf717c2416190ad44b0012ac06cb")]
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "criticality/turbulence source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-criticality-universality-turbulence-postseal-source-record/1") then
  throw "criticality/turbulence source schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:0601d19640943c4b99eb8cccf061e3115c520773eac5e762bf7c5b7440339b25") then
  throw "formal criticality/turbulence receipt binding changed"
 if (← array (getDefault payload "sources" (.array []))).length != 4 then
  throw "complete four-source criticality/turbulence record required"
 pure payload
def sourceIds : List String := ["SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026", "MCMASTER-LIN-ERBIUM-CRITICAL-SCATTERING-1993", "APS-MCCOMB-TURBULENCE-STRUCTURE-2014", "APS-HUANG-TURBULENCE-SPECTRUM-2010"]
end SFT.Physics.CriticalObservationRecords
