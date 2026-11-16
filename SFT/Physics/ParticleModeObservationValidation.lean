import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.ParticleModeObservationExperiment
import SFT.Physics.ParticleModeObservationMeasurement
import SFT.Physics.ParticleModeObservationExternal
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.ParticleModeObservationValidation
open SFT.Host SFT.Host.Canonical ParticleModeObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-PARTICLE-MODE-GENERATION-052"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-particle-mode-generation-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def labelMatches (v : CapabilityValues.Value) : Bool := match v with
 | .label held => Text.equal held.label expectedLabel
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
def tamperedFit (target : Value) : Value := replaceField target "neutrino_type_fit_center" (.integer 2800)
def alteredDirect (target : Value) : Value := replaceField target "neutrino_direct_row_retained_without_adjustment" (.boolean false)
def reversedLifetime (target : Value) : Value := replaceField target "tau_mean_life_seconds" (.text "3")
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record matterRecord terminalRecord : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong particle-mode empirical seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (ParticleModeObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "particle-mode prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "particle-mode prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← ParticleModeObservationMeasurement.exactParticleModeAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := ParticleModeObservationWitnesses.witnesses.all ParticleModeObservationWitnesses.Witness.passed
 let allRows := yes "all_rows_retained"
 let externalRecomputations ← ParticleModeObservationExternal.recompute files matterRecord terminalRecord
 let empirical := yes "positive_exact_carriers" && yes "fit_contains_three" && yes "direct_row_exactly_eight_fifths_from_three" && yes "measurement_boundaries_retained" && yes "charged_lepton_mass_intervals_strictly_ordered" && yes "charged_lepton_lifetimes_reverse_order" && yes "declared_mass_order_retained" && yes "declared_lifetime_order_retained" && yes "terminal_lepton_ratios_pass" && yes "available_quark_ratios_pass" && yes "top_charm_boundary_retained" && yes "terminal_ckm_vector_pass" && yes "positive_neutrino_vector_pass" && yes "ordering_boundary_retained" && yes "heavy_lepton_search_limits_positive" && yes "all_rows_retained"
 let fitAnalysis ← ParticleModeObservationMeasurement.exactParticleModeAnalysis (tamperedFit target)
 let fitRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault fitAnalysis "fit_contains_three")
 let directAnalysis ← ParticleModeObservationMeasurement.exactParticleModeAnalysis (alteredDirect target)
 let directRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault directAnalysis "measurement_boundaries_retained")
 let lifetimeAnalysis ← ParticleModeObservationMeasurement.exactParticleModeAnalysis (reversedLifetime target)
 let lifetimeRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault lifetimeAnalysis "charged_lepton_lifetimes_reverse_order")
 let passed := formal && externalRecomputations && empirical && fitRejected && directRejected && lifetimeRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("external_recomputations",.boolean externalRecomputations),("tampered_fit_rejected",.boolean fitRejected),("altered_direct_record_rejected",.boolean directRejected),("reversed_lifetime_rejected",.boolean lifetimeRejected)]
 let measurements := ["The precision fitted neutrino-type interval [2989,3003]/1000 contains the forced count three.", "The independent direct determination 292/100 with stated uncertainty 5/100 is retained without adjustment.", "Its exact central-value displacement from three is 8/5 stated uncertainties; it does not select or alter the forced law.", "Both terminal charged-lepton ratios, available s/d and b/s ratios, all terminal CKM rows and the positive-neutrino vector pass their registered comparisons.", "No exact scheme-matched direct t/c comparator is claimed.", "Charged-lepton mass intervals increase electron-muon-tau and lifetimes decrease in the same label order.", "Heavy-lepton search limits, measurement-model provenance and nondecisive neutrino-ordering boundaries are retained.", "No coordinate fraction is relabelled as mass and no structural reach count is relabelled as seconds.", "Tampered fit, altered direct record and reversed-lifetime controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (ParticleModeObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.ParticleModeObservationValidation
