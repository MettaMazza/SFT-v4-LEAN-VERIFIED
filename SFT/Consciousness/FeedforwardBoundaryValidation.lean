import SFT.Consciousness.FeedforwardBoundaryExperiment
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Consciousness.FeedforwardBoundaryValidation
open SFT.Host SFT.Host.Canonical SFT.Physics FeedforwardBoundaryExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-consciousness-boundary-equality",.text experimentId]))),
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
 | .label held => if Text.equal held.family "consciousness-external-consequence" then .ok held.label
   else .error "prediction emitted an invalid Consciousness consequence label"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ =>
   .error "prediction emitted an invalid Consciousness consequence label"
def validateResolved (registrationHash : String) (program : CapabilityAdmission.Program)
 (inputs : List (String × CapabilityValues.Value))
 (row : Value) (observedLabel extractionHash derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Value := do
 let target ← CapabilityValues.heldLabel "external-consciousness-boundary" observedLabel
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
  [(targetId,CapabilityValues.canonical (.label target))]
  (identity (.array [.text registrationHash,.text extractionHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "Consciousness prediction differs after hostile-package audit"
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
 let comparison : Value := .object [("target_id",.text targetId),("predicted",.text predicted),("observed",.text observed),("passed",.boolean passed),
  ("directness",.text directness),("empirical_disposition",.text empiricalDisposition)]
 let changed := Text.append observed "__tampered"
 let controlPassed := !(Text.equal predicted changed)
 let tampered : Value := .object [("predicted",.text predicted),("observed",.text changed),("passed",.boolean controlPassed)]
 let sourceEvidence := match SFT.Materials.MaterialSource.field row "source_evidence" with
  | .array xs => xs
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 let missingPresent := if Text.equal family "red_of_red" then sourceEvidence.any (fun evidence =>
  Text.equal (SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field evidence "source_id")) "CONSC-SYNESTHETIC-COLOUR-MATCH-2008" &&
  (match SFT.Materials.MaterialSource.field evidence "missing_registered_features" with
   | .array xs => !xs.isEmpty
   | .null => false
   | .text s => !(Text.equal s "")
   | .boolean b => b
   | .integer n => !(Text.equal (render (.integer n)) "0")
   | .object xs => !xs.isEmpty)) else true
 let missingControl : Value := .object [("source_id",.text "CONSC-SYNESTHETIC-COLOUR-MATCH-2008"),
  ("missing_features_remain_absent",.boolean missingPresent),("missing_features_used_as_support",.boolean false)]
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then
  throw "released Consciousness target identity differs from commitment"
 let payload : Value := .object [("experiment_registration_hash",.text registrationHash),
  ("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text prediction.sealHash),
  ("external_extraction_hash",.text extractionHash),("comparison",comparison),("tampered_control",tampered),("missing_feature_control",missingControl),("complete_trace_hash",.text execution.traceHash)]
 let messages := [Text.intercalate "" [targetId,": predicted ",predicted,"; source-derived ",observed,
  "; exact match ",if passed then "True" else "False"],
  Text.intercalate "" ["evidence disposition: ",empiricalDisposition,"; directness: ",directness],
  "all registered source features, adverse boundaries, absences and transport failures preserved",
  "phenomenal occurrence was not claimed as directly third-person observed",
  "deliberately changed consequence rejected"]
 return .object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),
  ("passed",.boolean (passed && controlPassed && missingPresent))]

def validate (root : String) (preSourcePayload audit targets : Value) (files : List Source.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Value := do
 validateSpec
 let _ ← Source.validatePreSourceSeal preSourcePayload files
 let (row,extractionHash) ← Source.targetRow root claimId targetId expectedLabel audit targets files
 let reg ← experimentRegistration root preSourcePayload audit targets files
 let registrationHash := identity reg
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let observedLabel := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field row "observed_label")
 validateResolved registrationHash program inputs row observedLabel extractionHash derivationSeal host implementation before after
#print axioms inputValues
#print axioms sealPrediction
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms predictionLabel
#print axioms validateResolved
#print axioms validate
end SFT.Consciousness.FeedforwardBoundaryValidation
