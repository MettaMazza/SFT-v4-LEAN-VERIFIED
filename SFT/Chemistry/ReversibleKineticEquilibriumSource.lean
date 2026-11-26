import SFT.Chemistry.ReversibleKineticEquilibriumExperiment
import SFT.Chemistry.ReversibleKineticEquilibriumAnalysis
namespace SFT.Chemistry.ReversibleKineticEquilibriumSource
open SFT.Host SFT.Host.Canonical SFT.Physics ReversibleKineticEquilibriumExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ReversibleKineticEquilibriumAnalysis.Analysis
def exactReversibleKineticEquilibriumAnalysis := ReversibleKineticEquilibriumAnalysis.exactReversibleKineticEquilibriumAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ (ReversibleKineticEquilibriumExperiment.sourceFiles.zipIdx.drop 5).map (fun (entry : (String × String) × Nat) => ((sourceBytes.drop entry.2).head?.getD ByteArray.empty,entry.1.1,entry.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "KIN-009 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_registered_target_count") (.integer 164) ||
  !sameValue (get targets "complete_pdf_page_target_count") (.integer 155) ||
  !sameValue (get targets "complete_supplementary_movie_target_count") (.integer 1) ||
  !sameValue (get targets "complete_source_data_archive_member_target_count") (.integer 8) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) ||
  !sameValue (get targets "release_requires_complete_identity_and_prediction_seal") (.boolean true) || targetRows.length != 164 then
  throw "KIN-009 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id", "source_id", "article_doi", "reversible_system_identity", "source_document_identity", "source_page_ordinal", "source_record_class", "source_record_identity", "source_record_ordinal"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "KIN-009 identity/target binding changed"
  let payload ← field target "target_payload"
  let nonempty := match payload with
   | .object fields=> !fields.isEmpty
   | .null=>false
   | .boolean _=>false
   | .integer _=>false
   | .text _=>false
   | .array _=>false
  if !nonempty then throw "KIN-009 target payload is absent"
  let hash := identity payload
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-complete-source-record-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id payload hash,.label held⟩ : Target)
end SFT.Chemistry.ReversibleKineticEquilibriumSource
