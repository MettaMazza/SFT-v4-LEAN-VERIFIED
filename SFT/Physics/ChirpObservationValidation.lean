import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.ChirpObservationExperiment
import SFT.Physics.ChirpObservationAnalysis
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.ChirpObservationValidation
open SFT.Host SFT.Host.Canonical ChirpObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-074"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-gravitational-wave-chirp-ringdown-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def labelMatches (v : CapabilityValues.Value) : Bool := match v with
 | .label held => Text.equal held.label expectedLabel
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
def changeSourceRow (target : Value) (index : Nat) (key fieldName : String) (value : Value) : Except String Value := do
 let sources ← RunningConvergenceMeasurement.array (← field target "withheld_postseal_sources")
 let source ← LeptonRatios.atIndex sources index
 let rows ← field source "rows"
 let row ← field rows key
 let changed := replaceField source "rows" (replaceField rows key (replaceField row fieldName value))
 .ok (replaceField target "withheld_postseal_sources" (.array (sources.take index ++ [changed] ++ sources.drop (index+1))))
def reversedFrequency (target : Value) : Except String Value := changeSourceRow target 0 "signal" "frequency_end_hz" (.text "30/1")
def erasedRemnant (target : Value) : Except String Value := changeSourceRow target 0 "source_and_remnant" "final_remnant_count" (.text "2/1")
def relabelledDevelopment (target : Value) : Except String Value := do
 let rows ← RunningConvergenceMeasurement.array (← field target "development_context")
 let row ← LeptonRatios.atIndex rows 0
 pure (replaceField target "development_context" (.array (replaceField row "blind_validation_role" (.text "blind") :: rows.drop 1)))
def erasedScope (target : Value) : Except String Value := changeSourceRow target 1 "scope" "interpretation_role" (.text "unconditional")
def formalPass : Bool := match ChirpRingdown.theoremCertificate with
 | .error _=>false
 | .ok c=>
  let yes := StellarCertificate.flag c
  yes "all_chirps_close" && yes "merger_closes" && yes "all_ringdowns_close"
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong gravitational-wave empirical seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (ChirpObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "sealed gravitational-wave prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← ChirpObservationAnalysis.exactAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := formalPass
 let allRows := yes "all_sources_retained"
 let val := fun key=>PostNewtonianRecords.getDefault analysis key
 let rat := fun n=>RunningConvergenceCertificate.rat (normalize n 1 (by decide))
 let empirical := sameValue (val "chirp_frequency_interval_hz") (.array [rat 35,rat 450]) && sameValue (val "chirp_cycle_count") (rat 55) && yes "development_source_not_blind" && yes "chirp_frequency_rises" && yes "chirp_amplitude_rises" && yes "positive_radiated_energy" && yes "chirp_two_to_one" && yes "chirp_model_role_retained" && yes "ring_frequency_rises" && yes "ring_two_to_one" && yes "ringdown_quadrupolar" && yes "ringdown_decays" && yes "half_One_not_directly_measured" && yes "conditional_role_retained" && yes "alternative_interpretations_retained" && yes "all_sources_retained"
 let reversedFrequencyAnalysis ← ChirpObservationAnalysis.exactAnalysis (← reversedFrequency target)
 let reversedFrequencyRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault reversedFrequencyAnalysis "chirp_frequency_rises")
 let erasedRemnantAnalysis ← ChirpObservationAnalysis.exactAnalysis (← erasedRemnant target)
 let erasedRemnantRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault erasedRemnantAnalysis "chirp_two_to_one")
 let relabelledDevelopmentAnalysis ← ChirpObservationAnalysis.exactAnalysis (← relabelledDevelopment target)
 let relabelledDevelopmentRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault relabelledDevelopmentAnalysis "development_source_not_blind")
 let erasedScopeAnalysis ← ChirpObservationAnalysis.exactAnalysis (← erasedScope target)
 let erasedScopeRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault erasedScopeAnalysis "conditional_role_retained")
 let passed := formal && empirical && reversedFrequencyRejected && erasedRemnantRejected && relabelledDevelopmentRejected && erasedScopeRejected
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("analysis",analysis),("formal",.boolean formal),("controls",.array [.boolean reversedFrequencyRejected,.boolean erasedRemnantRejected,.boolean relabelledDevelopmentRejected,.boolean erasedScopeRejected])]
 let measurements := ["GW150914 is retained as pre-seal observational context and is not counted as blind validation.", "GW151226 rises in frequency from 35 to 450 Hz and in amplitude over 55 cycles.", "GW151226 retains positive radiated energy and the two-component-to-one-remnant transition with full uncertainties and model role.", "GW190521 retains one remnant, a decaying least-damped quadrupolar mode and compatibility with the full waveform analysis.", "GW190521's conditional quasicircular interpretation, short-signal limit and alternative interpretations remain explicit.", "No dimensional frequency or exact half-One damping value is relabelled as a Fold proof scalar or direct universal measurement."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (ChirpObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.ChirpObservationValidation
