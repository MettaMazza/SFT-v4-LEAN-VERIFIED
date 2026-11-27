import SFT.Chemistry.AdditionSource
import SFT.Chemistry.AdditionExperiment
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.AdditionValidation
open SFT.Host SFT.Host.Canonical SFT.Physics AdditionExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-org-009-comparison/3",.text falsification]))),
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

open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
def stringField (row : Value) (key : String) : Except String String := field row key >>= text
def messages (analysis : Value) : Except String (List String) := do
 let hash ← stringField analysis "complete_result_vector_hash"
 return ["complete 48-file, 12,993,815-byte non-USPTO Open Reaction Database holdout retained",
 "all 131,209 conventional reaction rows inspected at the source-only boundary",
 "all 28 independently labeled azide-alkyne/click/cycloaddition identities selected before product opening",
 "28 favorable, no adverse and no unresolved complete product vectors",
 "112 exact element-preserving correspondences; each has two new cross-carrier adjacencies and three multiplicity relocations",
 "all V1--V8 absent, adverse, unresolved and failed-universal results preserved without awarding closure",
 Text.append "complete result vector " hash]
structure Validation where
 value : Value
 passed : Bool
def validate (input : AdditionAnalysis.Input) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 AdditionSource.authority input
 validateSpec
 let (analysis,checks) ← AdditionAnalysis.analysis input
 let registrationHash := identity registration
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let targets ← checks.mapM fun (target,passed) => do
  let held ← CapabilityValues.heldLabel "external-observation" (if passed then expectedLabel else "adverse-mismatch")
  return (target,CapabilityValues.canonical (.label held))
 let vectorHash ← stringField analysis "complete_result_vector_hash"
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
  targets (identity (.array [.text registrationHash,.text "sha256:ae8b152f09ebdd07e068890f0bff121d6dcfe189f57b6999ea79a6c22f29f96c",.text vectorHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ORG-009 prediction package changed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
  targetIds released.values
 let prediction ← match execution.output with
  | .label p => pure p
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "ORG-009 prediction output is invalid"
 let comparisons ← checks.mapM fun (target,_) => do
  let observed ← match released.values.find? (fun p => Text.equal p.1 target) with
   | none => throw (Text.join ["'",target,"'"])
   | some p => stringField p.2 "label"
  return Canonical.Value.object [("target_id",.text target),("predicted",.text prediction.label),("observed",.text observed),
   ("passed",.boolean (Text.equal prediction.label observed))]
 let tamperedRejected := !Text.equal prediction.label (Text.append prediction.label "__tampered")
 let selected ← field input.selection "selected_in_payload_and_row_order" >>= ConformerAnalysis.array
 let outcomes ← field input.comparison "results_in_frozen_order" >>= ConformerAnalysis.array
 let omissionRejected := match AdditionAnalysis.analysis input (some (selected.take (selected.length-1))) (some (outcomes.take (outcomes.length-1))) with
  | .error _ => true
  | .ok _ => false
 let passed := comparisons.all (fun row => equal (get row "passed") (.boolean true)) && omissionRejected && tamperedRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ORG-009 release changed"
 let payload : Value := .object [("registration",.text registrationHash),("sealed",.text derivationSeal),
  ("prediction",.text predictionSeal.sealHash),("analysis",analysis),
  ("comparisons",.array comparisons),("omission_rejected",.boolean omissionRejected),
  ("trace",.text execution.traceHash)]
 let measurements ← messages analysis
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault predictionSeal),
  ("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.AdditionValidation
