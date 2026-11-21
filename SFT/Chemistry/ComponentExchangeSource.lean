import SFT.Chemistry.ComponentExchangeExperiment
import SFT.Chemistry.ComponentExchangeAnalysis
namespace SFT.Chemistry.ComponentExchangeSource
open SFT.Host SFT.Host.Canonical SFT.Physics ComponentExchangeExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ComponentExchangeAnalysis.Analysis
def exactComponentExchangeAnalysis := ComponentExchangeAnalysis.exactComponentExchangeAnalysis
def sourceRows (identityBytes targetBytes primaryBytes rawBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),(rawBytes,rawPath,rawHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-008 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 74) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 74 then
  throw "THERMO-008 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get id "system_ordinal") (get target "system_ordinal") ||
   !sameValue (get id "temperature_dataset_ordinal") (get target "temperature_dataset_ordinal") ||
   !sameValue (get id "composition_dataset_ordinal") (get target "composition_dataset_ordinal") then
   throw "THERMO-008 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-multicomponent-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.ComponentExchangeSource
