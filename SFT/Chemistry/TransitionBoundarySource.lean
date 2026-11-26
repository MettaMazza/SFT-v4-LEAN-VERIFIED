import SFT.Chemistry.TransitionBoundaryExperiment
import SFT.Chemistry.TransitionBoundaryAnalysis
namespace SFT.Chemistry.TransitionBoundarySource
open SFT.Host SFT.Host.Canonical SFT.Physics TransitionBoundaryExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := TransitionBoundaryAnalysis.Analysis
def exactTransitionBoundaryAnalysis := TransitionBoundaryAnalysis.exactTransitionBoundaryAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ (TransitionBoundaryExperiment.sourceFiles.take 1).zipIdx.map (fun (row : (String×String)×Nat)=>((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-005 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_experimental_isotopologue_count") (.integer 2) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 2 then
  throw "KIN-005 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id", "source_id", "article_doi", "material_system_identity", "experimental_method_identity", "source_figure_identity", "isotopologue_identity", "exposure_identity"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-005 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-transition-boundary-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.TransitionBoundarySource
