import SFT.Chemistry.MolecularDiffusionExperiment
import SFT.Chemistry.MolecularDiffusionAnalysis
namespace SFT.Chemistry.MolecularDiffusionSource
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularDiffusionExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := MolecularDiffusionAnalysis.Analysis
def exactMolecularDiffusionAnalysis := MolecularDiffusionAnalysis.exactMolecularDiffusionAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ MolecularDiffusionExperiment.sourceFiles.zipIdx.map (fun (row : (String × String) × Nat) => ((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-016 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 164) ||
  !sameValue (get targets "diffusion_class_counts") (.object [("binary",.integer 138),("self",.integer 4),("tracer",.integer 22)]) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 164 then
  throw "THERMO-016 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id","source_id","diffusion_class","dataset_ordinal","source_point_ordinal"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "THERMO-016 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-molecular-diffusion-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.MolecularDiffusionSource
