import SFT.Chemistry.CompetingChannelExperiment
import SFT.Chemistry.CompetingChannelAnalysis
namespace SFT.Chemistry.CompetingChannelSource
open SFT.Host SFT.Host.Canonical SFT.Physics CompetingChannelExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := CompetingChannelAnalysis.Analysis
def exactCompetingChannelAnalysis := CompetingChannelAnalysis.exactCompetingChannelAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ (CompetingChannelExperiment.sourceFiles.take 1).zipIdx.map (fun (row : (String×String)×Nat)=>((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-006 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_registered_product_channel_count") (.integer 8) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 8 then
  throw "KIN-006 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id", "source_id", "article_doi", "reaction_identity", "measurement_identity", "condition_identity", "source_table_identity", "source_product_row", "product_channel_identity"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-006 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-competing-channel-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.CompetingChannelSource
