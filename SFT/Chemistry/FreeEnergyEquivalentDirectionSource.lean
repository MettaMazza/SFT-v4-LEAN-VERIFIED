import SFT.Chemistry.FreeEnergyEquivalentDirectionExperiment
import SFT.Chemistry.FreeEnergyReactionAnalysis
namespace SFT.Chemistry.FreeEnergyEquivalentDirectionSource
open SFT.Host SFT.Host.Canonical SFT.Physics FreeEnergyEquivalentDirectionExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := FreeEnergyReactionAnalysis.Analysis
def exactReactionDirectionAnalysis := FreeEnergyReactionAnalysis.exactReactionDirectionAnalysis
def speciesKeys (target : Value) : Bool := match target with
 | .object fields => fields.length==8 && FreeEnergyReactionAnalysis.speciesColumns.all (hasKey target)
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-007 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 64) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 64 then
  throw "THERMO-007 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get id "common_source_row_ordinal") (get target "common_source_row_ordinal") ||
   !speciesKeys (get target "NO2_complete_row") || !speciesKeys (get target "N2O4_complete_row") then
   throw "THERMO-007 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-reaction-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.FreeEnergyEquivalentDirectionSource
