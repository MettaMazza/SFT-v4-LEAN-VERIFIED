import SFT.Chemistry.OneComponentPhaseBoundaryExperiment
import SFT.Chemistry.OneComponentBoundaryAnalysis
namespace SFT.Chemistry.OneComponentPhaseBoundarySource
open SFT.Host SFT.Host.Canonical SFT.Physics OneComponentPhaseBoundaryExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := OneComponentBoundaryAnalysis.Analysis
def exactOneComponentBoundaryAnalysis := OneComponentBoundaryAnalysis.exactPhaseBoundaryAnalysis
def sourceRows (identityBytes targetBytes primaryBytes rawBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),(rawBytes,rawPath,rawHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-012 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 15) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 15 then
  throw "THERMO-012 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get id "dataset_ordinal") (get target "dataset_ordinal") ||
   !sameValue (get id "source_point_ordinal") (get target "source_point_ordinal") then
   throw "THERMO-012 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-one-component-coexistence-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.OneComponentPhaseBoundarySource
