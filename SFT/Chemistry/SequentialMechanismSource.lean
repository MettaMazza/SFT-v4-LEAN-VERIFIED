import SFT.Chemistry.SequentialMechanismExperiment
import SFT.Chemistry.SequentialMechanismAnalysis
namespace SFT.Chemistry.SequentialMechanismSource
open SFT.Host SFT.Host.Canonical SFT.Physics SequentialMechanismExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := SequentialMechanismAnalysis.Analysis
def exactSequentialMechanismAnalysis := SequentialMechanismAnalysis.exactSequentialMechanismAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ (SequentialMechanismExperiment.sourceFiles.take 1).zipIdx.map (fun (entry : (String × String) × Nat) => ((sourceBytes.drop entry.2).head?.getD ByteArray.empty,entry.1.1,entry.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-007 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_registered_target_count") (.integer 17) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 17 then
  throw "KIN-007 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id", "source_id", "article_doi", "reaction_identity", "measurement_identity", "pdb_identity", "source_record_class", "source_row"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-007 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-sequential-mechanism-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.SequentialMechanismSource
