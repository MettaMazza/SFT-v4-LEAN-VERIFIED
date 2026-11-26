import SFT.Chemistry.PhaseRuleExperiment
import SFT.Chemistry.PhaseRuleAnalysis
namespace SFT.Chemistry.PhaseRuleSource
open SFT.Host SFT.Host.Canonical SFT.Physics PhaseRuleExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := PhaseRuleAnalysis.Analysis
def exactPhaseRuleAnalysis := PhaseRuleAnalysis.exactPhaseRuleAnalysis
def sourceRows (identityBytes targetBytes primaryBytes iupacBytes nistBytes nistTextBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),(iupacBytes,iupacPath,iupacHash),(nistBytes,nistPath,nistHash),(nistTextBytes,nistTextPath,nistTextHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-011 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 18) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 18 then
  throw "THERMO-011 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get id "component_count_identity") (get target "component_count_external_inscription") ||
   !sameValue (get id "phase_count_identity") (get target "phase_count_external_inscription") then
   throw "THERMO-011 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let value ← if sameValue (get target "sft_degree_support_state") (.text "EmptyOne") then
   pure (CapabilityValues.Value.emptyOne "empty-One")
  else do
   let n ← field target "degree_support_external_inscription" >>= TemperatureCorrespondenceSource.integer
   let n ← CapabilityValues.count n.toNat
   pure (CapabilityValues.Value.count n)
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,value⟩ : Target)

end SFT.Chemistry.PhaseRuleSource
