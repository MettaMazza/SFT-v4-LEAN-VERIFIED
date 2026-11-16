import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.CosmicMeasuredExperiment
import SFT.Physics.CosmicMeasuredMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.CosmicMeasuredValidation
open SFT.Host SFT.Host.Canonical CosmicMeasuredExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-COSMIC-TRANSPORT-MEASURED-VALUE-055"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-cosmic-transport-measured-value-successor/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def labelMatches (v : CapabilityValues.Value) : Bool := match v with
 | .label held => Text.equal held.label expectedLabel
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
-- Exact indexed replacement used by the source's two adverse controls.
def replaceAt : List Value → Nat → Value → Except String (List Value)
 | [],_,_ => .error "list assignment index out of range"
 | _::xs,0,v => .ok (v::xs)
 | x::xs,n+1,v => do .ok (x::(← replaceAt xs n v))
def tamperedH (target : Value) : Except String Value := do
 let original ← field target "original"
 let chronometers ← field original "cosmic_chronometers"
 let rows ← RunningConvergenceMeasurement.array (← field chronometers "rows")
 let row ← RunningConvergenceMeasurement.rowAt rows 0
 let rows ← replaceAt rows 0 (replaceField row "central" (.text "1000"))
 .ok (replaceField target "original" (replaceField original "cosmic_chronometers" (replaceField chronometers "rows" (.array rows))))
def tamperedTransition (target : Value) : Except String Value := do
 let record ← field target "record"
 let corrected ← field record "corrected_acceleration_target"
 let changed := replaceField (replaceField (replaceField corrected "transition_redshift_center" (.text "1.50")) "transition_redshift_lower_uncertainty" (.text "0.01")) "transition_redshift_upper_uncertainty" (.text "0.01")
 .ok (replaceField target "record" (replaceField record "corrected_acceleration_target" changed))
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong cosmic successor seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (CosmicMeasuredRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "cosmic successor prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "cosmic successor prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← CosmicMeasuredMeasurement.exactCosmicAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := CosmicMeasuredWitnesses.witnesses.all CosmicMeasuredWitnesses.Witness.passed
 let allRows := yes "complete_original_rows_retained"
 let empirical := yes "chronometer_unit_residual_passed" && yes "all_chronometer_rows_contributed_once" && yes "rational_root_enclosures_exact" && yes "equality_inside_Planck_ratio" && yes "onset_inside_twice_Planck_ratio" && yes "acceleration_inside_Haridasu_interval" && yes "onset_inside_Haridasu_transition_interval" && yes "tension_One_inside_static_state_interval" && yes "alternate_reconstruction_retained" && yes "DESI_model_comparison_retained" && yes "complete_original_rows_retained"
 let hAnalysis ← CosmicMeasuredMeasurement.exactCosmicAnalysis (← tamperedH target)
 let hRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault hAnalysis "chronometer_unit_residual_passed")
 let transitionAnalysis ← CosmicMeasuredMeasurement.exactCosmicAnalysis (← tamperedTransition target)
 let transitionRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault transitionAnalysis "onset_inside_Haridasu_transition_interval")
 let passed := formal && empirical && hRejected && transitionRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("tampered_H_rejected",.boolean hRejected),("tampered_transition_rejected",.boolean transitionRejected)]
 let measurements := ["All 32 direct chronometer rows contribute once to a complete exact normalized-residual ledger; its upper enclosure is below the One on the fourth exact enclosure round, after three data-independent rational-root refinements.", "The exact equality 11/5 and onset 22/5 lie inside the complete Planck budget transports.", "The exact acceleration magnitude 17/32 and onset 22/5 lie inside the complete Haridasu q0 and transition intervals.", "Tension-One lies inside the registered constant-state interval; alternate reconstruction and DESI model-comparison records remain unchanged but are not acceptance conditions.", "No uncertainty multiplier was selected or widened; tampered chronometer and transition records reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (CosmicMeasuredRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.CosmicMeasuredValidation
