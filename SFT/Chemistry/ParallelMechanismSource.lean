import SFT.Chemistry.ParallelMechanismExperiment
import SFT.Chemistry.ParallelMechanismAnalysis
namespace SFT.Chemistry.ParallelMechanismSource
open SFT.Host SFT.Host.Canonical SFT.Physics ParallelMechanismExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ParallelMechanismAnalysis.Analysis
def exactParallelMechanismAnalysis := ParallelMechanismAnalysis.exactParallelMechanismAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ (ParallelMechanismExperiment.sourceFiles.zipIdx.drop 4).map (fun (entry : (String × String) × Nat) => ((sourceBytes.drop entry.2).head?.getD ByteArray.empty,entry.1.1,entry.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-008 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_registered_target_count") (.integer 28) ||
  !sameValue (get targets "complete_registered_rectangular_cell_position_count") (.integer 18158) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) ||
  !sameValue (get targets "release_requires_complete_identity_and_prediction_seal") (.boolean true) || targetRows.length != 28 then
  throw "KIN-008 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id", "source_id", "article_doi", "reaction_surface_identity", "measurement_identity", "source_sheet_identity", "source_sheet_ordinal", "declared_max_row", "declared_max_column", "source_record_class"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-008 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-parallel-mechanism-sheet-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.ParallelMechanismSource
