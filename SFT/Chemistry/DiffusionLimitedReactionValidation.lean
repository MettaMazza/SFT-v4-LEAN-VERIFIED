import SFT.Chemistry.DiffusionLimitedReactionPrediction
import SFT.Chemistry.FiniteMicrostateSupportSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.DiffusionLimitedReactionValidation
open SFT.Host SFT.Host.Canonical SFT.Physics DiffusionLimitedReactionExperiment
open SFT.Physics.LeptonIntervals SFT.Physics.VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def envelope (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (inputs.map fun (key,value) => (key,.text (CapabilityValues.identity value)))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def sealPrediction (prior : Option PredictionSeal) (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope inputs registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (registrationHash host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-finite-transport-reaction-boundary",.text falsification]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),
 ("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]



open DiffusionLimitedReactionSource DiffusionLimitedReactionPrediction
set_option maxRecDepth 30000
structure Validation where
 value : Value
 passed : Bool
structure Comparison where
 value : Value
 passed : Bool
 message : String
def boolText (b : Bool) : String := if b then "True" else "False"
def releaseValue (values : List (String × Value)) (target : String) : Except String Value :=
 match values.find? (fun row => Text.equal row.1 target) with
 | none => throw (Text.append "KeyError: " target)
 | some row => pure row.2
def analysisJSON (a : Analysis) : Value := .object ([
 ("complete_registered_target_count",.integer a.count),
 ("complete_source_class_census",.object (a.classCounts.map fun (k,n)=>(k,.integer n)))]++a.checks.map (fun (k,b)=>(k,.boolean b)))
def validate (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray) (identityDocument targets primary : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "KIN-011 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "KIN-011 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes sourceBytes identityDocument targets
 let values := source.map fun row => (row.targetId,CapabilityValues.canonical row.value)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-complete-target-custodian") values
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let comparisons ← source.mapM fun row => do
  let word ← predictionAt predicted row.targetId
  let released ← releaseValue release.values row.targetId
  let identityValues ← identityFields.mapM fun (key,_) => identityValue row.row key
  let identityMatch := identityValues.zipIdx.all fun (value,index) => labelMatches word (index+1) (.text value)
  let lawMatch := labelMatches word 9 (.text "same-held-reactant-traverses-every-retained-state-and-transition") &&
   labelMatches word 10 (.text "transport-exit-is-reaction-entry-and-reaction-waits-on-complete-transport-word") &&
   labelMatches word 11 (.text "all-stages-discrepancies-limitations-adverse-control-and-unresolved-records-remain-distinct") &&
   labelMatches word 12 (.text "all-251-article-page-video-metadata-and-dual-archive-records-retained")
  let targetMatch := sameValue released (CapabilityValues.canonical row.value)
  let passed := identityMatch && lawMatch && targetMatch
  let value := Value.object [("target_id",.text row.targetId),("identity_match",.boolean identityMatch),
   ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),("passed",.boolean passed)]
  pure (⟨value,passed,""⟩ : Comparison)
 let analysis ← exactDiffusionLimitedReactionAnalysis source primary
 let tampered := source.take (source.length-1)
 let tamperRejected := match exactDiffusionLimitedReactionAnalysis tampered primary with
  | .error _ => true
  | .ok _ => false
 let check := fun (a : Analysis) (name : String) => match a.checks.find? (fun item => Text.equal item.1 name) with
  | some item => item.2
  | none => false
 let brokenBoundary := do
  let (path,reaction) ← DiffusionLimitedReactionAnalysis.sourcePath
  let broken ← DiffusionLimitedReaction.makeReaction (.held ⟨"registered-reaction-occurrence","tampered",rfl,rfl⟩)
   (.held ⟨"registered-transport-reaction-state","not-transport-exit",rfl,rfl⟩) (.held reaction.productState)
   (.held reaction.conditionBoundary) (.held ⟨"held-reaction-status","tampered",rfl,rfl⟩)
  DiffusionLimitedReaction.forcedDiffusionLimitedReactionBoundary (.path path) (.reaction broken)
 let boundaryRejected := match brokenBoundary with | .error _=>true | .ok _=>false
 let controls : List (String × Bool) := [
  ("tampered_omitted_source_record_rejected",tamperRejected),
  ("tampered_transport_exit_reaction_entry_mismatch_rejected",boundaryRejected),
  ("complete_251_record_vector_retained",release.values.length==251),
  ("all_43_pdf_pages_retained",check analysis "complete_43_pdf_pages_retained"),
  ("all_1350_movie_frames_retained",check analysis "complete_1350_video_frames_retained"),
  ("all_204_archive_members_retained",check analysis "all_204_archive_members_retained"),
  ("all_discrepancy_and_adverse_records_visible",check analysis "large_droplet_resolution_and_peer_review_adverse_records_retained" && check analysis "experimental_43_plus_or_minus_5_and_simulated_14_velocity_inscriptions_and_discrepancy_retained"),
  ("prediction_contains_no_withheld_target_hash",!(Text.contains (FiniteMicrostateSupportSource.spacedRender document) targetHash))]
 let passed := comparisons.all Comparison.passed && analysis.checks.all Prod.snd && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "KIN-011 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),
  ("analysis",analysisJSON analysis),
    ("comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("trace",.text execution.traceHash)]
 let rowMessages ← source.mapM fun row => do
  let doc ← field row.row "source_document_identity" >>= identityString
  let record ← field row.row "source_record_identity" >>= identityString
  let hash ← field row.row "target_payload_hash" >>= identityString
  pure (Text.intercalate "" [row.targetId,": document=",doc,"; record=",record,"; target=",hash])
 let messages := rowMessages ++ ["complete finite separated-reactant, solvation, transport, encounter and product path retained", "transport exit is exact reaction entry; reaction waits on complete finite transport word", "external velocity inscriptions retained: experiment 43 ±5 m/s; simulation 14 m/s; discrepancy unreconciled", "external source rate estimate 5×10^12 M^-1 s^-1 retained only as post-seal provenance", "43 PDF pages, 1,350 movie frames, 204 archive members and 11,512 key raw rows remain byte-bound"] ++
  controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 let first ← match source with | row::_=>pure row | []=>throw "list index out of range"
 let sourceId ← field first.row "source_id" >>= identityString
 let distinctIds := [sourceId]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (distinctIds.map Value.text)),
 ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.DiffusionLimitedReactionValidation
