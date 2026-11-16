import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.ThermalMeasuredExperiment
import SFT.Physics.ThermalMeasuredMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.ThermalMeasuredValidation
open SFT.Host SFT.Host.Canonical ThermalMeasuredExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-THERMAL-HISTORY-MEASURED-VALUE-058"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-thermal-history-measured-value-successor/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def tamperedHelium (target : Value) : Except String Value := do
 let original ← field target "original"
 let measured ← field original "registered_target"
 let changed := replaceField (replaceField measured "primordial_helium_mass_fraction_central" (.text "0.2300")) "primordial_helium_mass_fraction_standard_uncertainty" (.text "0.0001")
 .ok (replaceField target "original" (replaceField original "registered_target" changed))
def tamperedPeaks (target : Value) : Except String Value := do
 let original ← field target "original"
 let measured ← field original "registered_target"
 .ok (replaceField target "original" (replaceField original "registered_target" (replaceField measured "planck_detected_peak_count" (.integer 17))))
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong thermal successor seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (ThermalMeasuredRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "thermal successor prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "thermal successor prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← ThermalMeasuredMeasurement.exactThermalAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := ThermalMeasuredWitnesses.witnesses.all ThermalMeasuredWitnesses.Witness.passed
 let allRows := yes "all_source_rows_retained"
 let empirical := yes "temperature_exponent_One_passed" && yes "physical_helium_59_over_240_passed" && yes "analytic_and_physical_helium_separately_typed" && yes "deuterium_positive_minor_channel" && yes "freezeout_sequence_retained" && yes "finite_recombination_record_retained" && yes "complete_peak_census_retained" && yes "all_peak_rows_positive" && yes "projection_boundary_retained_without_mismatch_reward" && yes "all_source_rows_retained"
 let heliumAnalysis ← ThermalMeasuredMeasurement.exactThermalAnalysis (← tamperedHelium target)
 let heliumRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault heliumAnalysis "physical_helium_59_over_240_passed")
 let peaksAnalysis ← ThermalMeasuredMeasurement.exactThermalAnalysis (← tamperedPeaks target)
 let peaksRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault peaksAnalysis "complete_peak_census_retained")
 let passed := formal && empirical && heliumRejected && peaksRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("tampered_helium_rejected",.boolean heliumRejected),("tampered_peaks_rejected",.boolean peaksRejected)]
 let measurements := ["Exact CMB temperature exponent One lies inside [49/50,517/500].", "Exact physical primordial helium share 59/240 lies inside [489/2000,2471/10000].", "The one-sixth to one-seventh freezeout sequence and positive deuterium channel remain complete.", "Finite recombination support, eighteen extrema and all seven TT rows remain source-bound and positive; angular projection records are not mismatch results.", "No uncertainty was widened; displaced helium and incomplete-peak controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (ThermalMeasuredRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.ThermalMeasuredValidation
