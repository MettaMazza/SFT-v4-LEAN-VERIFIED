import SFT.Chemistry.TemperatureDependenceExperiment
import SFT.Chemistry.TemperatureDependenceAnalysis
namespace SFT.Chemistry.TemperatureDependenceSource
open SFT.Host SFT.Host.Canonical SFT.Physics TemperatureDependenceExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := TemperatureDependenceAnalysis.Analysis
def exactTemperatureDependenceAnalysis := TemperatureDependenceAnalysis.exactTemperatureDependenceAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ TemperatureDependenceExperiment.sourceFiles.zipIdx.map (fun (row : (String×String)×Nat)=>((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-003 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 19) ||
  !sameValue (get targets "complete_condition_row_count") (.integer 14) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 19 then
  throw "KIN-003 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id","source_id","table_number","source_condition_row_ordinal","reaction_key"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-003 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-temperature-rate-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.TemperatureDependenceSource
