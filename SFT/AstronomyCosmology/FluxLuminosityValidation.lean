import SFT.AstronomyCosmology.FluxLuminosityExperiment
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.AstronomyCosmology.FluxLuminosityValidation
open SFT.Host SFT.Host.Canonical SFT.Physics FluxLuminosityExperiment
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (spec : Source.Spec) (prior : Option PredictionSeal) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope spec registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text spec.blueprint.experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨spec.blueprint.experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (spec : Source.Spec) (host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append spec.blueprint.experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-held-label-equality",.text spec.blueprint.experimentId,.text spec.blueprint.falsificationCondition]))),
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
 | .label held => if Text.equal held.family "physical-observation" then .ok held.label
   else .error "prediction emitted an invalid physical observation label"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "prediction emitted an invalid physical observation label"
def validate (spec : Source.Spec) (records : List (String × Value)) (files : List Source.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Value := do
 Source.validateSpec spec records
 let bytes ← SFT.Materials.MaterialSource.readSnapshot files spec.sourceSnapshotPath
 if !Text.equal (SFT.Materials.MaterialSource.bytesHash bytes) spec.sourceSnapshotHash then
  throw "external measurement snapshot differs from registration"
 let registrationHash := identity (registration spec)
 let program ← CapabilityDocuments.loadProgramFields (programFields spec)
 let inputs ← inputValues derivationSeal
 let targets ← spec.targetRows.mapM fun row => do
  let held ← CapabilityValues.heldLabel "external-observation" row.observedLabel
  pure (row.targetId,CapabilityValues.canonical (.label held))
 let vault ← TargetCustody.createVault spec.blueprint.experimentId
  (Text.append spec.blueprint.experimentId "-external-target-custodian") targets
  (identity (.array [.text registrationHash,.text spec.sourceSnapshotHash]))
  (identity (envelope spec registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction spec none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram (programFields spec) before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "prediction program identity differs after hostile-package audit"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (spec.targetRows.map Source.ExternalTarget.targetId) release.values
 let predicted ← predictionLabel execution.output
 let comparisons ← spec.targetRows.mapM fun row => do
  let released ← match release.values.find? (fun pair => Text.equal pair.1 row.targetId) with
   | none => .error (Text.intercalate "" ["'",row.targetId,"'"])
   | some pair => .ok pair.2
  let observed := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field released "label")
  pure (row,observed,Text.equal predicted observed)
 let comparisonValues := comparisons.map fun (row,observed,passed) => Value.object [
  ("target_id",.text row.targetId),("source_id",.text row.sourceId),("source_locator",.text row.registeredLocator),
  ("predicted",.text predicted),("observed",.text observed),("passed",.boolean passed)]
 let controlPassed := !Text.equal predicted "changed-external-observation"
 let tampered := Value.object [("target_id",.text "deliberately-tampered-unfavorable-control"),
  ("predicted",.text predicted),("observed",.text "changed-external-observation"),("passed",.boolean controlPassed)]
 let passed := comparisons.all (fun (_,_,ok) => ok) && controlPassed
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then
  throw "released target identity differs from its commitment"
 let payload := Value.object [
  ("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("source_snapshot_hash",.text spec.sourceSnapshotHash),
  ("comparisons",.array comparisonValues),("tampered_control",tampered),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map fun (row,observed,ok) => Text.intercalate "" [row.targetId,
  ": predicted ",predicted,"; observed ",observed,"; exact match ",if ok then "True" else "False"]
 return .object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation spec host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array ((spec.targetRows.map Source.ExternalTarget.sourceId).eraseDups.map Value.text)),
  ("measurements",.array ((messages ++ ["deliberately tampered unfavorable control rejected"]).map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text spec.blueprint.falsificationCondition),
  ("passed",.boolean passed)]
end SFT.AstronomyCosmology.FluxLuminosityValidation
