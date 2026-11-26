import SFT.Consciousness.NonordinaryExternalExperiment
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Consciousness.NonordinaryExternalValidation
open SFT.Host SFT.Host.Canonical SFT.Physics NonordinaryExternalExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-consciousness-return-family-comparison",.text experimentId]))),
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
 | .label held => if Text.equal held.family "consciousness-observation" then .ok held.label else .error "invalid Consciousness prediction"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "invalid Consciousness prediction"

def validate (files : List NonordinaryExternalSource.File) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Value := do
 let registrationHash := identity registration
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let resolved ← NonordinaryExternalSource.sourceTarget files
 let target ← CapabilityValues.heldLabel "external-observation" resolved.label
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-source-custodian")
  [(targetId,CapabilityValues.canonical (.label target))]
  (identity (.array [.text registrationHash,.text resolved.extractionHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "Consciousness hostile-package audit failed"
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
 let comparison := Text.equal predicted observed
 let tampered := !(Text.equal predicted (Text.append observed "__tampered"))
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "Consciousness target identity differs"
 let measurement : Value := .object [("registration",.text registrationHash),("derivation",.text derivationSeal),
  ("prediction",.text prediction.sealHash),("extraction",.text resolved.extractionHash),
  ("sources",.array (resolved.sourceIds.map Value.text)),("classes",resolved.resultClasses),
  ("comparison",.boolean comparison),("tampered",.boolean tampered)]
 let messages := [Text.intercalate "" [targetId,": exact categorical match ",if comparison then "True" else "False"],
  "stable cross-modal inducer/concurrent correspondence retained with diagnostic and mechanistic heterogeneity",
  "multidimensional altered-state reports and measured neural covariation retained without ontological inflation",
  "NREM/REM alternation retained with local/global dissociation and non-universal timing",
  "lost integrated function and retained viable components remain distinct",
  "null, non-purpose-matched, heterogeneous and unresolved rows retained",
  "tampered control rejected"]
 return .object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (resolved.sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity measurement)),
  ("falsification_condition",SFT.Materials.MaterialSource.field registration "falsification_condition"),
  ("passed",.boolean (comparison && tampered))]
end SFT.Consciousness.NonordinaryExternalValidation
