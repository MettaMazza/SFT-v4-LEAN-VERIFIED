import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.StrongCPObservationExperiment
import SFT.Physics.StrongCPObservationMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.StrongCPObservationValidation
open SFT.Host SFT.Host.Canonical StrongCPObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-STRONG-CP-BARYON-STABILITY-064"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-strong-cp-baryon-stability-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
 let sources ← RunningConvergenceMeasurement.array (← field target "sources")
 let source ← LeptonRatios.atIndex sources index
 let rows ← field source "rows"
 let row ← field rows key
 let changed := replaceField source "rows" (replaceField rows key (replaceField row fieldName value))
 .ok (replaceField target "sources" (.array (sources.take index ++ [changed] ++ sources.drop (index+1))))
def confirmedEDM (target : Value) : Except String Value := changeSourceRow target 0 "neutron_electric_dipole_moment" "reported_central_status" (.text "confirmed-nonempty-displacement")
def confirmedDecay (target : Value) : Except String Value := changeSourceRow target 1 "p_to_e_plus_pi0" "interpretation" (.text "confirmed-proton-decay")
def formalPass : Bool := match StrongCPCertificate.theoremCertificate with
 | .error _=>false
 | .ok c=>StrongCPCertificate.samePhase c.alignment.strongPhase ("aligned-One",SFT.Foundation.ExactOperations.one) && StrongCPHands.sameHands c.alignment.electricDipoleCarrier ["empty-One"] && c.actions.generatedCrossFibreActions.isEmpty && c.baryonOneInvariant
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong strong-CP/baryon empirical seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (StrongCPObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
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
 if !labelMatches execution.output then throw "sealed formal prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← StrongCPObservationMeasurement.exactAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := formalPass
 let allRows := yes "all_sources_retained"
 let empirical := yes "nedm_direct_record_consistent" && sameValue (PostNewtonianRecords.getDefault analysis "proton_mode_count") (.integer 6) && yes "all_proton_limits_positive" && yes "no_significant_decay_signal" && yes "background_candidates_retained" && yes "all_confidence_rows_retained" && yes "finite_limits_not_infinity" && yes "null_not_proof_zero" && yes "all_sources_retained"
 let edmAnalysis ← StrongCPObservationMeasurement.exactAnalysis (← confirmedEDM target)
 let edmRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault edmAnalysis "nedm_direct_record_consistent")
 let decayAnalysis ← StrongCPObservationMeasurement.exactAnalysis (← confirmedDecay target)
 let decayRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault decayAnalysis "no_significant_decay_signal")
 let passed := formal && empirical && edmRejected && decayRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("confirmed_edm_rejected",.boolean edmRejected),("confirmed_decay_rejected",.boolean decayRejected)]
 let measurements := ["PSI reports a null neutron-EDM central displacement with both positive uncertainty magnitudes and a finite 90-percent upper limit of 1.8e-26 e cm.", "The neutron-EDM row is consistent with the sealed empty-One strong-dipole prediction; it is not relabelled as numerical proof zero.", "All six registered Super-Kamiokande proton modes retain their finite 90-percent partial-lifetime lower limits.", "No registered mode reports a statistically significant proton-decay signal; every candidate interpretation, including background-compatible events, is retained.", "Finite lifetime limits are not called infinity and do not select the already sealed proton-stability law.", "Confirmed-EDM and confirmed-proton-decay hostile controls both reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (StrongCPObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.StrongCPObservationValidation
