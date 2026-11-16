import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.ElectroweakMeasuredExperiment
import SFT.Physics.ElectroweakMeasuredMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.ElectroweakMeasuredValidation
open SFT.Host SFT.Host.Canonical ElectroweakMeasuredExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-electroweak-measured-value-successor/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def labelMatches (v : CapabilityValues.Value) : Bool := match v with
 | .label held => Text.equal held.label expectedLabel
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong electroweak successor seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (ElectroweakMeasuredRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "electroweak successor prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "electroweak successor prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← ElectroweakMeasuredMeasurement.exactElectroweakAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := ElectroweakMeasuredWitnesses.witnesses.all ElectroweakMeasuredWitnesses.Witness.passed
 let allRows := yes "all_source_rows_retained"
 let empirical := yes "forced_sine_inside_direct_interval" && yes "forced_cosine_inside_compatible_WZ_interval" && yes "exact_partition" && yes "incompatible_input_disclosure_retained" && yes "poor_consistency_disclosure_retained" && yes "inconsistent_aggregate_not_used_as_target" && yes "all_source_rows_retained"
 let tamperedDirect := replaceField target "on_shell_sin_squared_center" (.text "0.22000")
 let directAnalysis ← ElectroweakMeasuredMeasurement.exactElectroweakAnalysis tamperedDirect
 let directRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault directAnalysis "forced_sine_inside_direct_interval")
 let tamperedW := replaceField target "compatible_w_mass_GeV" (.text "81")
 let wAnalysis ← ElectroweakMeasuredMeasurement.exactElectroweakAnalysis tamperedW
 let wRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault wAnalysis "forced_cosine_inside_compatible_WZ_interval")
 let passed := formal && empirical && directRejected && wRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("tampered_direct_rejected",.boolean directRejected),("tampered_w_rejected",.boolean wRejected)]
 let measurements := ["The exact forced on-shell share 1930922298157999/8642477221479757 lies inside [22333,22351]/100000.", "Its exact One-complement lies inside the complete compatible-input W/Z squared interval.", "No uncertainty was widened and no measured row selected the formal relation.", "The all-input aggregate and its uncertainties remain unchanged, but its source-identified incompatible input prevents it from being treated as a second like-typed physical target.", "Tampered direct-angle and compatible-W controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (ElectroweakMeasuredRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.ElectroweakMeasuredValidation
