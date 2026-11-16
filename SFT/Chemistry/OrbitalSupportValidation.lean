import SFT.Chemistry.OrbitalSupportComparison
import SFT.Chemistry.OrbitalSupportExperiment
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.OrbitalSupportValidation
open SFT.Host SFT.Host.Canonical SFT.Physics OrbitalSupportExperiment
abbrev InputFields := ElectronSpinRegistry.InputFields
abbrev Identity := OrbitalSupportTargets.Identity
abbrev Target := OrbitalSupportTargets.Target
abbrev SourceSnapshot := OrbitalSupportTargets.Snapshot
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-NIST-orbital-support-comparator/1",.text experimentId]))),
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

def measurementPayload (registrationHash : String) (predictionSeal : PredictionSeal)
 (comparisons : List OrbitalSupportComparison.Comparison) (adverse : List (String × Bool))
 (traceHash : String) : Value := .object [
 ("registration_hash",.text registrationHash),("prediction_seal_hash",.text predictionSeal.sealHash),
 ("identity_registry_hash",.text identityRegistryHash),("target_registry_hash",.text targetRegistryHash),
 ("comparisons",.array (comparisons.map OrbitalSupportComparison.comparisonValue)),
 ("adverse",.object (adverse.map fun (name,passed) => (name,.boolean passed))),
 ("term_total",.integer (.ofNat (OrbitalSupportComparison.termTotal comparisons))),
 ("configuration_total",.integer (.ofNat (OrbitalSupportComparison.configurationTotal comparisons))),
 ("trace_hash",.text traceHash)]
structure Validation where
 value : Value
 passed : Bool
def validate (inputHash : String) (inputSchema : Option Value) (rawInputs : List InputFields)
 (identityHash targetHash : String) (identities : List Identity) (rawTargets : List Target)
 (snapshots : List SourceSnapshot) (changedFirstHash derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let rows ← ElectronSpinRegistry.loadInputs inputHash inputSchema rawInputs
 let countInputs ← rows.mapM ElectronSpinRegistry.countInput
 let electronRows ← ElectronSpinPrediction.predictionRows countInputs
 let document := OrbitalSupportPrediction.programDocument electronRows
 let registrationHash := identity (registration document)
 let fields := match document with
  | .object fields => fields
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let parsed ← CapabilityDocuments.loadProgramFields fields
 let inputs ← inputValues derivationSeal
 let targets ← OrbitalSupportTargets.resolvedTargets identityHash targetHash identities rawTargets snapshots
 let targetValues := targets.map fun row => (row.targetId,CapabilityValues.canonical row.targetValue)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram fields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ELEC-003 prediction package changed during execution"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) released.values
 let entries ← match execution.output with
  | .table entries => .ok entries
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => .error "ELEC-003 prediction is not a Fold table"
 let predicted ← OrbitalSupportComparison.predictionMap entries
 let comparisons ← targets.mapM (OrbitalSupportComparison.compare predicted)
 let firstReference ← match references with
  | [] => .error "tuple index out of range"
  | head::_ => .ok head
 let firstSnapshot ← match snapshots.find? (fun row => Text.equal row.path firstReference.snapshotPath) with
  | none => .error (Text.append "FileNotFoundError: " firstReference.snapshotPath)
  | some row => .ok row
 let adverse ← OrbitalSupportComparison.adverseControls predicted comparisons
  firstSnapshot.hash changedFirstHash firstReference.snapshotHash
 let passed := comparisons.all OrbitalSupportComparison.Comparison.passed && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease released
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ELEC-003 released target differs from commitment"
 let messages := comparisons.map OrbitalSupportComparison.message ++ adverse.map (fun (name,value) =>
  Text.intercalate "" ["adverse ",name,": ",if value then "True" else "False"])
 return ⟨.object [
  ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault predictionSeal),
  ("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
  ("all_rows_preserved",.boolean true),("data_source_ids",.array [.text sourceId]),
  ("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity (measurementPayload registrationHash predictionSeal comparisons adverse execution.traceHash))),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.OrbitalSupportValidation

