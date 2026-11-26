import SFT.Chemistry.ElementaryTransitionRateExperiment
import SFT.Chemistry.ElementaryTransitionRateAnalysis
namespace SFT.Chemistry.ElementaryTransitionRateSource
open SFT.Host SFT.Host.Canonical SFT.Physics ElementaryTransitionRateExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ElementaryTransitionRateAnalysis.Analysis
def exactElementaryRateAnalysis := ElementaryTransitionRateAnalysis.exactElementaryRateAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ ElementaryTransitionRateExperiment.sourceFiles.zipIdx.map (fun (row : (String×String)×Nat)=>((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-001 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 46) ||
  !sameValue (get targets "complete_source_count") (.integer 4) ||
  !sameValue (get targets "source_declared_order_row_counts") (.object [("1",.integer 4),("2",.integer 24),("3",.integer 18)]) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 46 then
  throw "KIN-001 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id","source_id","record_id","source_row_ordinal"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-001 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-elementary-rate-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.ElementaryTransitionRateSource
