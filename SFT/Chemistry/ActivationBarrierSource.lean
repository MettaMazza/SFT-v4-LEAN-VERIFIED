import SFT.Chemistry.ActivationBarrierExperiment
import SFT.Chemistry.ActivationBarrierAnalysis
namespace SFT.Chemistry.ActivationBarrierSource
open SFT.Host SFT.Host.Canonical SFT.Physics ActivationBarrierExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ActivationBarrierAnalysis.Analysis
def exactActivationBarrierAnalysis := ActivationBarrierAnalysis.exactActivationBarrierAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ (ActivationBarrierExperiment.sourceFiles.take 1).zipIdx.map (fun (row : (String×String)×Nat)=>((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-004 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_detail_target_count") (.integer 44) ||
  !sameValue (get targets "complete_index_species_count") (.integer 41) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 44 then
  throw "KIN-004 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id", "source_id", "source_detail_ordinal", "species_name", "formula_external_inscription", "casno_source_identity", "torsion_index_source_identity", "torsion_atom_identity", "rotor_type_identity", "source_reference_identity"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-004 identity/target binding changed"
  let snapshotPath ← field target "snapshot_path" >>= text
  let snapshotHash ← field target "snapshot_hash" >>= text
  let bytes := match ActivationBarrierExperiment.sourceFiles.zipIdx.find? (fun (row : (String×String)×Nat)=>Text.equal row.1.1 snapshotPath) with
   | some (_,i)=>(sourceBytes.drop i).head?.getD ByteArray.empty
   | none=>ByteArray.empty
  if !bytesMatch bytes snapshotHash then throw "KIN-004 detail snapshot changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-activation-barrier-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.ActivationBarrierSource
