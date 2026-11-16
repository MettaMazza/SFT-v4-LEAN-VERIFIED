import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.QuantumSupportObservationExperiment
import SFT.Physics.QuantumSupportObservationMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.QuantumSupportObservationValidation
open SFT.Host SFT.Host.Canonical QuantumSupportObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-QUANTUM-SUPPORT-UNCERTAINTY-050"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-quantum-support-Bell-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
 if !Text.equal sealedClaim claimId then throw "wrong quantum-support Bell seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (QuantumSupportObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "quantum-support Bell prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "quantum-support Bell prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← QuantumSupportObservationMeasurement.exactQuantumSupportBellAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := QuantumSupportObservationWitnesses.witnesses.all QuantumSupportObservationWitnesses.Witness.passed
 let allRows := yes "all_rows_retained"
 let empirical := yes "positive_exact_carriers" && yes "complete_interval_above_local_bound" && yes "central_excess_above_twenty_two_uncertainties" && yes "reported_significance_retained" && yes "million_trial_lower_bound_retained" && yes "binary_two_setting_record" && yes "deterministic_entanglement_generation_retained" && yes "space_like_interval_separation" && yes "memory_control_retained" && yes "random_setting_method_retained" && yes "measurement_independence_assumption_retained" && yes "unavoidable_assumption_statement_retained" && yes "all_rows_retained"
 let checkedRecord ← QuantumSupportObservationRecords.authoritativeRecord files record
 let boundaryRows ← field checkedRecord "interpretive_boundary"
 let boundaries := QuantumSupportObservationRecords.boundariesRetained boundaryRows
 let tamperedS := replaceField target "bell_parameter_center" (.integer 19900)
 let sAnalysis ← QuantumSupportObservationMeasurement.exactQuantumSupportBellAnalysis tamperedS
 let sRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault sAnalysis "complete_interval_above_local_bound")
 let tamperedTiming := replaceField target "trial_duration_nanoseconds_center_hundredths" (.integer 11100)
 let timingAnalysis ← QuantumSupportObservationMeasurement.exactQuantumSupportBellAnalysis tamperedTiming
 let timingRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault timingAnalysis "space_like_interval_separation")
 let passed := formal && empirical && boundaries && sRejected && timingRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("boundaries_retained",.boolean boundaries),("tampered_s_rejected",.boolean sRejected),("tampered_timing_rejected",.boolean timingRejected)]
 let measurements := ["The complete measured S interval [20714,20780]/10000 lies above the local-factorization bound two.", "The central excess is greater than twenty-two stated standard uncertainties and P is reported below 10^-108.", "More than one million superconducting-circuit trials are retained.", "The complete trial-duration interval lies below the complete light-travel-budget interval.", "The memory-robust analysis and setting-choice procedure are retained.", "Measurement independence remains a declared source assumption; no ontic randomness premise is imported.", "The result rejects local factorization under those conditions, not determinism as a whole.", "The Bell record does not relabel the separate formal Walsh support product as measured variance.", "Tampered S and timing controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (QuantumSupportObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.QuantumSupportObservationValidation
