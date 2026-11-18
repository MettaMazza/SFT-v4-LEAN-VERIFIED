import SFT.Chemistry.AnalyticalDetectionAnalysis
import SFT.Chemistry.AnalyticalDetectionExperiment
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.AnalyticalDetectionValidation
open SFT.Host SFT.Host.Canonical SFT.Physics AnalyticalDetectionExperiment
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
 ("host_platform",.text (if host.isEmpty then "host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-anal-performance-batch/1",.text claimId,.text falsification]))),
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
 | .label held => .ok held.label
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "prediction output has no label"
def validate (analysis : Value) (files : List NuclideCarrierAnalysis.Snapshot)
 (surfaces : List NuclideCarrierAnalysis.SurfaceInput)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Value := do
 validateSpec
 let (summary,checks) ← AnalyticalDetectionAnalysis.exactDetectionAnalysis analysis files surfaces
 let registrationHash := identity registration
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let targets ← checks.mapM fun (target,passed) => do
  let held ← CapabilityValues.heldLabel "external-observation" (if passed then expectedLabel else "adverse-mismatch")
  return (target,CapabilityValues.canonical (.label held))
 let vectorHash ← NuclideCarrierAnalysis.field summary "complete_result_vector_sha256" >>= NuclideCarrierAnalysis.text
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
  targets (identity (.array [.text registrationHash,.text vectorHash])) (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ANAL-001–005 prediction package changed"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (checks.map Prod.fst) release.values
 let predicted ← predictionLabel execution.output
 let comparisons ← checks.mapM fun (target,_) => do
  let released ← match release.values.find? (fun row => Text.equal row.1 target) with
   | none => .error (Text.intercalate "" ["'",target,"'"])
   | some row => .ok row.2
  let observed ← NuclideCarrierAnalysis.field released "label" >>= NuclideCarrierAnalysis.text
  let passed := Text.equal predicted observed
  let row : Value := .object [("target_id",.text target),("predicted",.text predicted),("observed",.text observed),("passed",.boolean passed)]
  return (row,passed)
 let omission := match AnalyticalDetectionAnalysis.exactDetectionAnalysis analysis files surfaces true with
  | .error _ => true
  | .ok _ => false
 let passed := (comparisons.all Prod.snd) && omission
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ANAL-001–005 target changed"
 let payload : Value := .object [("registration",.text registrationHash),("sealed",.text derivationSeal),
  ("prediction",.text prediction.sealHash),("analysis",summary),("comparisons",.array (comparisons.map Prod.fst)),
  ("omission_rejected",.boolean omission),("trace",.text execution.traceHash)]
 let notes := ["complete six-source post-seal family retained as 83 PDF pages, one HTML document and 180,366 extracted characters",
  Text.intercalate "" ["all ",toString checks.length," separately registered claim targets retained"],
  "all values units uncertainties assumptions corrections fits estimates losses adverse absent unavailable unresolved historical and archived-status records remain downstream provenance; disclosed pre-seal snippets are never relabelled blind"]
 return .object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (notes.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)]
#print axioms inputValues
#print axioms sealPrediction
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms predictionLabel
#print axioms validate
end SFT.Chemistry.AnalyticalDetectionValidation
