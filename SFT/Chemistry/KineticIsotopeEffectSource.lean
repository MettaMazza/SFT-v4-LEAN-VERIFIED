import SFT.Chemistry.KineticIsotopeEffectExperiment
import SFT.Chemistry.KineticIsotopeEffectAnalysis
namespace SFT.Chemistry.KineticIsotopeEffectSource
open SFT.Host SFT.Host.Canonical SFT.Physics KineticIsotopeEffectExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := KineticIsotopeEffectAnalysis.Analysis
def exactKineticIsotopeEffectAnalysis := KineticIsotopeEffectAnalysis.exactKineticIsotopeEffectAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ KineticIsotopeEffectExperiment.sourceFiles.zipIdx.map (fun (entry : (String × String) × Nat) => ((sourceBytes.drop entry.2).head?.getD ByteArray.empty,entry.1.1,entry.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-012 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_registered_target_count") (.integer 71) ||
  !sameValue (get targets "complete_pdf_page_target_count") (.integer 47) ||
  !sameValue (get targets "complete_source_data_worksheet_target_count") (.integer 23) ||
  !sameValue (get targets "release_requires_complete_identity_and_prediction_seal") (.boolean true) ||
  !sameValue (get targets "all_complete_source_records_preserved") (.boolean true) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) || targetRows.length != 71 then
  throw "KIN-012 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id", "source_id", "article_doi", "isotopologue_reaction_system_identity", "source_document_identity", "source_record_class", "source_record_identity", "source_record_ordinal"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-012 identity/target binding changed"
  let payload ← field target "target_payload"
  let nonempty := match payload with
   | .object fields=> !fields.isEmpty
   | .null=>false
   | .boolean _=>false
   | .integer _=>false
   | .text _=>false
   | .array _=>false
  if !nonempty then throw "KIN-012 target payload is absent"
  let hash := identity payload
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-complete-source-record-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id payload hash,.label held⟩ : Target)
end SFT.Chemistry.KineticIsotopeEffectSource
