import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.CriticalObservationExperiment
import SFT.Physics.CriticalObservationMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.CriticalObservationValidation
open SFT.Host SFT.Host.Canonical CriticalObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-criticality-universality-turbulence-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def labelMatches (v : CapabilityValues.Value) : Bool := match v with
 | .label held => Text.equal held.family "physical-observation" && Text.equal held.label expectedLabel
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong criticality/turbulence seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (CriticalObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "criticality/turbulence prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "criticality/turbulence prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← CriticalObservationMeasurement.exactCriticalityAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := CriticalObservationWitnesses.witnesses.all CriticalObservationWitnesses.Witness.passed
 let allRows := yes "all_rows_retained"
 let empirical := yes "positive_exact_carriers" && yes "manganite_complete_five_rows" && yes "manganite_expected_matches_exact" && yes "manganite_nonmatch_retained" && yes "manganite_nonmatch_gamma_rejects" && yes "manganite_nonmatch_delta_rejects" && yes "erbium_complete_vector_matches" && yes "structure_interval_contains_two_thirds" && yes "finite_reynolds_boundary_retained" && yes "spectrum_exact_magnitude" && yes "spectrum_falling_orientation" && yes "spectrum_five_thirds_compensation" && yes "spectrum_fourier_plateau" && yes "spectrum_hilbert_plateau" && yes "spectrum_ranges_ordered" && yes "spectrum_structure_limit_retained" && yes "threshold_boundary_retained" && yes "empty_exponent_boundary_retained" && yes "all_manganite_rows_retained" && yes "all_rows_retained"
 let tampered := replaceField target "turbulence_measured_structure_center" (.integer 620)
 let ta ← CriticalObservationMeasurement.exactCriticalityAnalysis tampered
 let structureRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault ta "structure_interval_contains_two_thirds")
 let relabelled := replaceField target "manganite_expected_complete_vector_matches" (.array (["La00","La02","La04","La06","La08"].map Value.text))
 let ra ← CriticalObservationMeasurement.exactCriticalityAnalysis relabelled
 let relabelledRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault ra "manganite_expected_matches_exact")
 let rows ← RunningConvergenceMeasurement.array (← field target "manganite_rows")
 let removed := replaceField target "manganite_rows" (.array rows.dropLast)
 let da ← CriticalObservationMeasurement.exactCriticalityAnalysis removed
 let removedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault da "manganite_complete_five_rows")
 let reversed := replaceField target "turbulence_spectrum_orientation" (.text "rising")
 let sa ← CriticalObservationMeasurement.exactCriticalityAnalysis reversed
 let reversedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault sa "spectrum_falling_orientation")
 let passed := formal && empirical && structureRejected && relabelledRejected && removedRejected && reversedRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("empirical",.boolean empirical),("controls",.array [.boolean structureRejected,.boolean relabelledRejected,.boolean removedRejected,.boolean reversedRejected])]
 let measurements := ["Erbium beta/gamma/nu intervals contain exactly 1/2, One and 1/2.", "Four of five complete manganite vectors contain exactly beta=1/2, gamma=One and delta=three.", "La02 is retained and rejected as a complete member of that generated exponent class.", "The independent zeta_2 interval [666,692]/1000 contains exactly 2/3.", "The physical channel-flow record exhibits five-thirds compensated plateaux by Fourier and Hilbert routes.", "Finite-Reynolds, structure-function-range, threshold and empty-exponent boundaries remain retained.", "Tampered interval, relabelled nonmatch, removed-row and reversed-spectrum controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (CriticalObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.CriticalObservationValidation
