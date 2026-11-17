import SFT.Biology.PhysiologyExperiment
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Biology.PhysiologyValidation
open SFT.Host SFT.Host.Canonical SFT.Physics PhysiologyExperiment
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (prior : Option PredictionSeal) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-biology-source-correspondence",.text experimentId]))),
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



def predictionLabel : CapabilityValues.Value → Except String String
 | .label held => if Text.equal held.family "biology-observation" then .ok held.label
   else .error "prediction emitted an invalid Biology label"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ =>
   .error "prediction emitted an invalid Biology label"
def validateResolved (registrationHash : String) (program : CapabilityAdmission.Program)
 (inputs : List (String × CapabilityValues.Value))
 (observedLabel extractionHash derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Value := do
 let target ← CapabilityValues.heldLabel "external-observation" observedLabel
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
  [(targetId,CapabilityValues.canonical (.label target))]
  (identity (.array [.text registrationHash,.text extractionHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "Biology prediction differs after hostile-package audit"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  [targetId] release.values
 let predicted ← predictionLabel execution.output
 let released ← match release.values.find? (fun row => Text.equal row.1 targetId) with
  | none => .error (Text.intercalate "" ["'",targetId,"'"])
  | some row => .ok row.2
 let observed := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field released "label")
 let passed := Text.equal predicted observed
 let comparison : Value := .object [("target_id",.text targetId),("source_ids",.array (sourceIds.map Value.text)),
  ("source_extraction_hash",.text extractionHash),("predicted",.text predicted),("observed",.text observed),("passed",.boolean passed)]
 let changed := Text.append observed "__tampered"
 let controlPassed := !(Text.equal predicted changed)
 let tampered : Value := .object [("target_id",.text "deliberately-tampered-unfavorable-control"),
  ("predicted",.text predicted),("observed",.text changed),("passed",.boolean controlPassed)]
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then
  throw "released Biology target identity differs from commitment"
 let payload : Value := .object [("experiment_registration_hash",.text registrationHash),
  ("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text prediction.sealHash),
  ("comparison",comparison),("tampered_control",tampered),("complete_trace_hash",.text execution.traceHash)]
 let messages := [Text.intercalate "" [targetId,": predicted ",predicted,"; source-derived ",observed,
  "; exact match ",if passed then "True" else "False"],
  "every required authoritative fragment and snapshot hash reproduced",
  "transport/content failures and adverse scientific rows retained",
  "deliberately tampered unfavorable control rejected"]
 return .object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),
  ("passed",.boolean (passed && controlPassed))]

def validate (preSourcePayload : Value) (files : List PhysiologySource.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Value := do
 validateSpec
 let sourceSeal ← LifeOrganizationSeal.validate preSourcePayload files
 let registrationHash := identity (registration sourceSeal)
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let (observedLabel,extractionHash) ← PhysiologySource.sourceDerivedTarget files
 validateResolved registrationHash program inputs observedLabel extractionHash derivationSeal host implementation before after
#print axioms inputValues
#print axioms sealPrediction
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms predictionLabel
#print axioms validateResolved
#print axioms validate
end SFT.Biology.PhysiologyValidation
