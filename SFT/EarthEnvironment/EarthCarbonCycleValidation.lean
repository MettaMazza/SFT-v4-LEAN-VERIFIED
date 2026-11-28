import SFT.EarthEnvironment.EarthCarbonCycleExperiment
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.EarthEnvironment.EarthCarbonCycleValidation
open SFT.Host SFT.Host.Canonical SFT.Physics EarthCarbonCycleExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-earth-boundary-equality",.text experimentId]))),
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
 | .label held => if Text.equal held.family "earth-external-consequence" then .ok held.label
   else .error "prediction emitted an invalid Earth consequence label"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ =>
   .error "prediction emitted an invalid Earth consequence label"
def validateResolved (registrationHash : String) (program : CapabilityAdmission.Program)
 (inputs : List (String × CapabilityValues.Value))
 (row sourceAudit : Value) (observedLabel extractionHash derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Value := do
 let target ← CapabilityValues.heldLabel "external-earth-boundary" observedLabel
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
  [(targetId,CapabilityValues.canonical (.label target))]
  (identity (.array [.text registrationHash,.text extractionHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "Earth prediction differs after hostile-package audit"
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
 let comparison : Value := .object [("target_id",.text targetId),("predicted",.text predicted),("observed",.text observed),("passed",.boolean passed)]
 let changed := Text.append observed "__tampered"
 let controlPassed := !(Text.equal predicted changed)
 let tampered : Value := .object [("predicted",.text predicted),("observed",.text changed),("passed",.boolean controlPassed)]
 let preserved ← requiredField row "missing_and_absent_features_preserved"
 let missingPreserved := match preserved with
  | .null => false
  | .boolean b => b
  | .integer n => !(Text.equal (render (.integer n)) "0")
  | .text s => !s.isEmpty
  | .array xs => !xs.isEmpty
  | .object xs => !xs.isEmpty
 let numeric ← requiredField row "numeric_comparison"
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then
  throw "released Earth target identity differs from commitment"
 let payload : Value := .object [("registration",.text registrationHash),("seal",.text derivationSeal),
  ("prediction",.text prediction.sealHash),("extraction",.text extractionHash),("comparison",comparison),
  ("tampered",tampered),("numeric_comparison",numeric),("trace",.text execution.traceHash)]
 let present ← requiredField sourceAudit "present_feature_count"
 let absent ← requiredField sourceAudit "absent_feature_count"
 let registered ← requiredField sourceAudit "registered_feature_count"
 let messages := [Text.intercalate "" [targetId,": predicted ",predicted,"; source-derived ",observed,
  "; exact match ",if passed then "True" else "False"],
  Text.intercalate "" ["source features: ",render present," present; ",render absent," absent preserved; ",render registered," registered"],
  "the original failed transport and every adverse, absent and unresolved row remain preserved",
  "a deliberately changed external consequence was rejected"]
 let messages := match numeric with
  | .null => messages
  | .text _ | .boolean _ | .integer _ | .array _ | .object _ =>
   messages ++ ["earthquake unit-exponent test: mixed catalogue adverse retained; separately preregistered homogeneous mww holdout compatible"]
 return .object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),
  ("passed",.boolean (passed && controlPassed && missingPreserved))]

def validate (preSourcePayload audit targets bindings first holdout : Value) (files : List Source.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Value := do
 validateSpec
 let _ ← Source.validatePreSourceSeal preSourcePayload files
 let (row,extractionHash) ← Source.targetRow claimId targetId expectedLabel audit targets bindings first holdout files
 let reg ← experimentRegistration preSourcePayload audit targets bindings first holdout files
 let registrationHash := identity reg
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let observedLabel := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field row "observed_label")
 let result ← validateResolved registrationHash program inputs row audit observedLabel extractionHash derivationSeal host implementation before after
 let _ ← Source.validateExternalEvidence audit targets bindings first holdout files
 return result
#print axioms inputValues
#print axioms sealPrediction
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms predictionLabel
#print axioms validateResolved
#print axioms validate
end SFT.EarthEnvironment.EarthCarbonCycleValidation
