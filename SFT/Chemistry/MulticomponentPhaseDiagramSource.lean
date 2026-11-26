import SFT.Chemistry.MulticomponentPhaseDiagramExperiment
import SFT.Chemistry.MulticomponentDiagramAnalysis
namespace SFT.Chemistry.MulticomponentPhaseDiagramSource
open SFT.Host SFT.Host.Canonical SFT.Physics MulticomponentPhaseDiagramExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := MulticomponentDiagramAnalysis.Analysis
def exactMulticomponentDiagramAnalysis := MulticomponentDiagramAnalysis.exactMulticomponentAnalysis
def sourceRows (identityBytes targetBytes primaryBytes rawBytes landingBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),(rawBytes,rawPath,rawHash),(landingBytes,landingPath,landingHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-013 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 116) then throw "THERMO-013 target count changed"
 if !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 116 then
  throw "THERMO-013 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get id "dataset_class") (get target "dataset_class") ||
   !sameValue (get id "dataset_ordinals") (get target "dataset_ordinals") ||
   !sameValue (get id "source_point_ordinal") (get target "source_point_ordinal") then
   throw "THERMO-013 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-multicomponent-coexistence-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.MulticomponentPhaseDiagramSource
