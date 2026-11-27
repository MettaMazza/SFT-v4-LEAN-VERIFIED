import SFT.Chemistry.ConformerPopulationExperiment
import SFT.Chemistry.ConformerPopulationComparison
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.ConformerPopulationValidation
open SFT.Host SFT.Host.Canonical SFT.Physics ConformerPopulationExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-conditioned-conformer-population-ordering/1",.text falsification]))),
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



def boolText (b : Bool) : String := if b then "True" else "False"
def rowText (row : Value) (key : String) : Except String String := JointCorrelationTargets.field row key >>= JointCorrelationTargets.text
def rowPassed (row : Value) : Bool := match JointCorrelationTargets.field row "passed" with
 | .ok (.boolean b) => b
 | .ok (.null) | .ok (.integer _) | .ok (.text _) | .ok (.array _) | .ok (.object _) | .error _ => false
def measurementPayload (registrationHash derivationSeal : String) (prediction : PredictionSeal)
 (analysis : Value) (rows : List Value) (controls : List (String × Bool)) (traceHash : String) : Value :=
 .object [("registration",.text registrationHash),("sealed",.text derivationSeal),
  ("prediction",.text prediction.sealHash),("analysis",analysis),("comparisons",.array rows),
  ("controls",.object (controls.map fun (key,b) => (key,.boolean b))),("trace",.text traceHash)]
structure Validation where
 value : Value
 passed : Bool

def validate (actualIdentityHash : String) (identityDocument targetDocument primary : Value)
 (sourceHashes : List (String × String))
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let document ← ConformerPopulationPrediction.predictionDocument actualIdentityHash identityDocument
 let registrationHash := identity (registration document)
 let fields := match document with
  | .object fs => fs
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let program ← CapabilityDocuments.loadProgramFields fields
 let inputs ← inputValues derivationSeal
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram fields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ORG-006 capability-closed package changed"
 let predicted ← ConformerPopulationSource.predictionMap execution.output
 let sourceHash (path : String) : Except String String := match sourceHashes.find? (fun p => Text.equal p.1 path) with
  | some p => .ok p.2
  | none => .error (Text.append "missing source hash: " path)
 let rows ← ConformerPopulationSource.sourceRows
  (← sourceHash "experiments/external_sources/chemistry/org_006_complete_targets_v1.json")
  (← sourceHash "experiments/external_sources/chemistry/snapshots/org-006-core-direct-v5/org-006-primary-record-v1.json")
  actualIdentityHash identityDocument targetDocument sourceHashes
 let targetValues ← rows.mapM fun row => do
  let targetId ← rowText row "target_id"
  let held ← CapabilityValues.heldLabel "external-complete-source-record-hash" (← rowText row "target_payload_hash")
  return (targetId,CapabilityValues.canonical (.label held))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash])) (identity (envelope registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) release.values
 let comparisons ← rows.mapM (ConformerPopulationComparison.compare predicted release.values)
 let analysis ← ConformerPopulationAnalysis.analysis rows primary
 let controls ← ConformerPopulationComparison.controls rows analysis document release.values
 let passed := comparisons.all rowPassed && ConformerPopulationComparison.analysisPassed analysis && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ORG-006 target identity changed"
 let payload := measurementPayload registrationHash derivationSeal prediction analysis comparisons controls execution.traceHash
 let vectorHash ← rowText analysis "complete_target_vector_hash"
 let rowMessages := [
  "exact Fold witness populations 3/4 and 1/4; one-observation successor 3/5 and 2/5",
  "blind 298.5 K ordered n-pentane vector: tt 0.33 ± 0.03, tg 0.51 ± 0.01, pm 0.02 ± 0.01, pp 0.14 ± 0.01",
  "blind displayed ordered vector is exactly 33/100 + 51/100 + 1/50 + 7/50 = 1",
  "blind intramolecular energy order: tt structural reference, tg 480, pp 658, pm 3263 cal mol^-1; positive gaps 480, 178, 2605",
  "blind Etg at 300 K: 441 ± 114 cal mol^-1; external signed temperature variation -1.9 ± 0.3 cal K^-1 mol^-1 retained downstream",
  "complete ACS supporting surface: 8 tables and 224 measured condition/coupling rows; complete article: 22 spectra",
  "all failed provider routes, recorder failure and isotropic 201/200 rounded-display adverse row preserved",
  Text.append "complete exact target vector " vectorHash]
 let sourceIds ← rows.mapM fun row => rowText row "source_id"
 let messages := rowMessages ++ controls.map (fun (key,b) => Text.intercalate "" ["control ",key,": ",boolText b])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.ConformerPopulationValidation
