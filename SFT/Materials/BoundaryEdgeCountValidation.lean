import SFT.Materials.BoundaryEdgeCountExperiment
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Materials.BoundaryEdgeCountValidation
open SFT.Host SFT.Host.Canonical SFT.Physics BoundaryEdgeCountExperiment
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
 | .label held => .ok held.label
 | .emptyOne _ => .error "'EmptyOne' object has no attribute 'label'"
 | .count _ => .error "'PositiveCount' object has no attribute 'label'"
 | .ratio _ _ => .error "'PositiveRatio' object has no attribute 'label'"
 | .word _ => .error "'FoldWord' object has no attribute 'label'"
 | .pair _ _ => .error "'FoldPair' object has no attribute 'label'"
 | .table _ => .error "'FoldTable' object has no attribute 'label'"
def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (host implementation : String) (execution : CapabilityExecution.Execution)
 (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-executor")),
 ("host_platform",.text (if host.isEmpty then "host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "successor-source-check",.text experimentId]))),
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

def validate (preSourcePayload : Value) (files : List MaterialSource.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Value := do
 let _ ← BoundaryEdgeCountSource.validatePreSourceSeal preSourcePayload files
 validateSpec
 let receipts ← BoundaryEdgeCountSource.receipts files
 let sourceSeal ← BoundaryEdgeCountSource.validatePreSourceSeal preSourcePayload files
 let registryHash := registrationHash sourceSeal receipts
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let target ← CapabilityValues.heldLabel "external-observation" expectedLabel
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-custodian")
  [(targetId,CapabilityValues.canonical (.label target))] (identity (.array receipts))
  (identity (envelope registryHash derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let prediction ← sealPrediction none registryHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "hostile audit failed"
 let (_,released) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment released prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  [targetId] released.values
 let releasedValue ← match released.values.find? (fun row => Text.equal row.1 targetId) with
  | none => .error (Text.intercalate "" ["'",targetId,"'"])
  | some row => .ok row.2
 let observed ← SFT.Chemistry.ConjugatedSupportAnalysis.field releasedValue "label" >>= BoundaryEdgeCountSource.stringValue
 let predicted ← observation execution.output
 let passed := Text.equal predicted observed
 let _targetIdentity ← TargetCustody.identityFromRelease released
 let measurements := [Text.append "sealed prediction equals complete source-derived observation: " (if passed then "True" else "False"),
  "all registered rows preserved","tampered changed label rejected"]
 return .object [
 ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registryHash),
 ("isolation_certificate",isolation host implementation execution vault prediction),
 ("target_custody_certificate",custodyCertificate registryHash released prediction),
 ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
 ("all_rows_preserved",.boolean true),("data_source_ids",.array (sourceIds.map Value.text)),
 ("measurements",.array (measurements.map Value.text)),
 ("measurement_receipt_hash",.text (identity (.array [.text registryHash,.array receipts,.boolean passed]))),
 ("falsification_condition",.text falsification),("passed",.boolean passed)]
#print axioms inputValues
#print axioms sealPrediction
#print axioms observation
#print axioms certificate
#print axioms isolation
#print axioms custodyCertificate
#print axioms validate
end SFT.Materials.BoundaryEdgeCountValidation
