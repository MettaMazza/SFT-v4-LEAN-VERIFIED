import SFT.Chemistry.RealGasExchangeExperiment
import SFT.Chemistry.RealGasAnalysis
namespace SFT.Chemistry.RealGasExchangeSource
open SFT.Host SFT.Host.Canonical SFT.Physics RealGasExchangeExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := RealGasAnalysis.Analysis
def exactRealGasAnalysis := RealGasAnalysis.exactRealGasAnalysis
def sourceRows (identityBytes targetBytes primaryBytes rawBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),(rawBytes,rawPath,rawHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-010 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 94) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 94 then
  throw "THERMO-010 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get id "pressure_dataset_ordinal") (get target "pressure_dataset_ordinal") ||
   !sameValue (get id "pressure_point_ordinal") (get target "pressure_point_ordinal") ||
   (sameValue (get id "composition_companion_class") (.text "present") != !sameValue (get target "composition_dataset_ordinal") .null) then
   throw "THERMO-010 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-real-gas-equilibrium-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.RealGasExchangeSource
