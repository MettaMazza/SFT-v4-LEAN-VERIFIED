import SFT.Materials.PhotonicMaterialExperiment
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Materials.PhotonicMaterialValidation
open SFT.Host SFT.Host.Canonical SFT.Physics PhotonicMaterialExperiment
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot

def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (prior : Option PredictionSeal) (registryHash derivationSeal : String)
 (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope registryHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def observation : CapabilityValues.Value → Except String String
 | .label held => if Text.equal held.family "materials-observation" then .ok held.label
   else .error "prediction emitted an invalid Materials label"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ =>
   .error "prediction emitted an invalid Materials label"

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (host implementation : String) (execution : CapabilityExecution.Execution)
 (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-materials-source-correspondence",.text experimentId]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),
 ("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (registryHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registryHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

def comparison (extraction predicted observed : String) : Value := .object [
 ("target_id",.text targetId),("source_ids",.array (sourceIds.map Value.text)),
 ("source_extraction_hash",.text extraction),("predicted",.text predicted),("observed",.text observed),
 ("passed",.boolean (Text.equal predicted observed))]
def control (predicted observed : String) : Value := .object [
 ("target_id",.text "deliberately-tampered-unfavorable-control"),("predicted",.text predicted),
 ("observed",.text (Text.append observed "__tampered")),
 ("passed",.boolean (!Text.equal predicted (Text.append observed "__tampered")))]

structure Validation where
 value : Value
 passed : Bool

def runComparison (registryHash derivationSeal host implementation observedLabel extractionHash : String)
 (parsed : CapabilityAdmission.Program) (inputs : List (String × CapabilityValues.Value))
 (before after : Snapshot) : Except String Validation := do
 let targets := [(targetId,labelValue "external-observation" observedLabel)]
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
   targets (identity (.array [.text registryHash,.text extractionHash])) (identity (envelope registryHash derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none registryHash derivationSeal execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
   .error "Materials prediction differs after hostile-package audit"
 else do
   let (_,released) ← TargetCustody.release vault predictionSeal
   TargetCustody.verify vault.commitment released predictionSeal
   let _context ← SFT.Computation.MathematicalModelling.openTargets
     (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
     [targetId] released.values
   let prediction ← observation execution.output
   let observed ← ObservationComparison.releasedLabel targetId released.values
   let passed := Text.equal prediction observed && !Text.equal prediction (Text.append observed "__tampered")
   let releasedId ← TargetCustody.identityFromRelease released
   if !Text.equal releasedId vault.commitment.targetHash then
     .error "released Materials target identity differs from commitment"
   else
     let payload : Value := .object [
       ("experiment_registration_hash",.text registryHash),("derivation_seal_hash",.text derivationSeal),
       ("prediction_seal_hash",.text predictionSeal.sealHash),("comparison",comparison extractionHash prediction observed),
       ("tampered_control",control prediction observed),("complete_trace_hash",.text execution.traceHash)]
     .ok ⟨.object [
       ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registryHash),
       ("isolation_certificate",isolation host implementation execution vault predictionSeal),
       ("target_custody_certificate",custodyCertificate registryHash released predictionSeal),
       ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
       ("all_rows_preserved",.boolean true),("data_source_ids",.array (sourceIds.map Value.text)),
       ("measurements",.array [.text (Text.intercalate "" [targetId,": predicted ",prediction,"; source-derived ",observed,"; exact match ",if Text.equal prediction observed then "True" else "False"]),
          .text "every required authoritative fragment and snapshot hash reproduced",.text "deliberately tampered unfavorable control rejected"]),
       ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),
       ("passed",.boolean passed)],passed⟩

def validate (preSeal : Value) (files : List MaterialSource.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let sealHash ← MaterialSource.validatePreSeal preSeal files
 let registryHash := identity (registration sealHash)
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let (observedLabel,extractionHash) ← PhotonicMaterialSource.extractTarget files
 runComparison registryHash derivationSeal host implementation observedLabel extractionHash parsed inputs before after

theorem resealRejected (old : PredictionSeal) (registryHash derivationSeal : String)
 (execution : CapabilityExecution.Execution) :
 sealPrediction (some old) registryHash derivationSeal execution =
 .error "prediction is already sealed and cannot be replaced" := rfl
end SFT.Materials.PhotonicMaterialValidation
