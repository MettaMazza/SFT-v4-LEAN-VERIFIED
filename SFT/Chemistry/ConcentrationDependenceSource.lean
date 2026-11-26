import SFT.Chemistry.ConcentrationDependenceExperiment
import SFT.Chemistry.ConcentrationDependenceAnalysis
namespace SFT.Chemistry.ConcentrationDependenceSource
open SFT.Host SFT.Host.Canonical SFT.Physics ConcentrationDependenceExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ConcentrationDependenceAnalysis.Analysis
def exactConcentrationDependenceAnalysis := ConcentrationDependenceAnalysis.exactConcentrationDependenceAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ ConcentrationDependenceExperiment.sourceFiles.zipIdx.map (fun (row : (String×String)×Nat)=>((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-002 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 9) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 9 then
  throw "KIN-002 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id","source_id","table_number","source_row_ordinal"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-002 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-concentration-rate-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.ConcentrationDependenceSource
