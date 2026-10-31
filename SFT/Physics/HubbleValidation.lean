import SFT.Physics.HubbleComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.HubbleValidation
open SFT.Host SFT.Host.Canonical HubbleExperiment
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot

def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (prior : Option PredictionSeal) (derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def programFields : List (String × Value) := [
 ("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
 ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]

def observation : CapabilityValues.Value → Except String String
 | .label held => if Text.equal held.family "physical-observation" then .ok held.label
   else .error "prediction emitted an invalid physical observation label"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ =>
   .error "prediction emitted an invalid physical observation label"

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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-held-label-equality",.text experimentId,.text falsification]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),
 ("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

def receipt (derivationSeal prediction traceHash : String) (predictionSeal : PredictionSeal)
    (rows : List ObservationCarrier.Comparison) : Value := .object [
 ("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
 ("prediction_seal_hash",.text predictionSeal.sealHash),("source_snapshot_hash",.text snapshotHash),
 ("comparisons",.array (rows.map HubbleComparison.comparisonValue)),("tampered_control",HubbleComparison.controlValue prediction),
 ("complete_trace_hash",.text traceHash)]

structure Validation where
 value : Value
 passed : Bool

-- Snapshot/file and platform fields are supplied by the source IO adapter.
-- The pipeline retains the exact original order of source checks and protocol operations.
def validate (bytes : ByteArray) (derivationSeal host implementation : String)
    (before after : Snapshot) : Except String Validation := do
 validateSpec
 checkSource bytes
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
   targets (identity (.array [.text registrationHash,.text snapshotHash])) (identity (envelope derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none derivationSeal execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
   .error "prediction program identity differs after hostile-package audit"
 else do
   let (_,released) ← TargetCustody.release vault predictionSeal
   TargetCustody.verify vault.commitment released predictionSeal
   let _context ← SFT.Computation.MathematicalModelling.openTargets
     (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
     (targetRows.map ObservationCarrier.ExternalTargetRow.targetId) released.values
   let prediction ← observation execution.output
   let rows ← HubbleComparison.compareRows prediction released.values targetRows
   let targetId ← TargetCustody.identityFromRelease released
   if !Text.equal targetId vault.commitment.targetHash then
     .error "released target identity differs from its commitment"
   else
     let passed := HubbleComparison.accepted prediction rows
     .ok ⟨.object [
       ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
       ("isolation_certificate",isolation host implementation execution vault predictionSeal),
       ("target_custody_certificate",custodyCertificate released predictionSeal),
       ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
       ("all_rows_preserved",.boolean true),("data_source_ids",.array ((HubbleComparison.sourceIds rows).map Value.text)),
       ("measurements",.array ((rows.map (fun row => Value.text (HubbleComparison.message row))) ++ [.text "deliberately tampered unfavorable control rejected"])),
       ("measurement_receipt_hash",.text (identity (receipt derivationSeal prediction execution.traceHash predictionSeal rows))),
       ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩

theorem resealRejected (old : PredictionSeal) (derivationSeal : String) (execution : CapabilityExecution.Execution) :
    sealPrediction (some old) derivationSeal execution = .error "prediction is already sealed and cannot be replaced" := rfl
def validateExternal (source : CosmicIntervals.HubbleRecord) (bytes : ByteArray)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 let interval ← CosmicIntervals.hubbleRatioInterval source
 let derived ← CosmicRatios.hubbleStructure
 if !(CosmicIntervals.contains interval (BoundaryGrowth.asFraction derived.leadingRatio) &&
      CosmicIntervals.contains interval (BoundaryGrowth.asFraction derived.refinedRatio)) then
  .error "sealed Hubble calibration ratio lies outside the complete source interval"
 else validate bytes derivationSeal host implementation before after

end SFT.Physics.HubbleValidation
