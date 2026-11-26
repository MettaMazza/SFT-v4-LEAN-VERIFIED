import SFT.Chemistry.ViscousTransportExperiment
import SFT.Chemistry.ViscousTransportAnalysis
namespace SFT.Chemistry.ViscousTransportSource
open SFT.Host SFT.Host.Canonical SFT.Physics ViscousTransportExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ViscousTransportAnalysis.Analysis
def exactViscousTransportAnalysis := ViscousTransportAnalysis.exactViscousTransportAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ ViscousTransportExperiment.sourceFiles.zipIdx.map (fun (row : (String × String) × Nat) => ((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-017 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 425) ||
  !sameValue (get targets "mixture_class_counts") (.object [("pure",.integer 11),("binary",.integer 364),("ternary",.integer 50)]) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 425 then
  throw "THERMO-017 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id","source_id","dataset_ordinal","source_point_ordinal"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "THERMO-017 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-viscosity-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.ViscousTransportSource
