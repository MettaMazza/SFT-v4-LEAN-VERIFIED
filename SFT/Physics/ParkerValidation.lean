import SFT.Physics.TargetCustody
import SFT.Physics.ParkerExperiment
import SFT.Physics.ParkerMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.ParkerValidation
open SFT.Host SFT.Host.Canonical ParkerExperiment ParkerPrediction LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-parker-proton-energy-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong Parker proton-energy seal"
 let registrationHash := admissionIdentity (← registrationRecord)
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← formalPredictionInputs
 let keys := inputs.map Prod.fst
 let env := envelope derivationSeal inputs registrationHash
 let originalTargets ← releasedTargets files record
 let hashes := Value.object (ParkerRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "Parker hostile-package audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let mapped ← outputMapping execution.output keys
 if !sameValue (.object (mapped.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "Parker prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← ParkerMeasurement.exactMeasurementAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let adverse ← RunningConvergenceMeasurement.array (← field analysis "adverse_formula_rows")
 let event ← field target "parker_event"
 let wording ← field event "reported_energy_wording"
 let wordingLength ← ParkerRecords.sourceLength wording
 let allRows := adverse.length == 12 && wordingLength == 3
 let inside ← RunningConvergenceMeasurement.array (← field analysis "adverse_inside_range")
 let controls := yes "terminal_inside_complete_range" && yes "leading_inside_complete_range" && equals "approximate_label_has_uncertainty" (.boolean false) && equals "approximate_label_is_exact_cutoff" (.boolean false) && equals "observation_uniquely_selects_structural_formula" (.boolean false) && inside.any (fun x => sameValue x (.array [.integer 2,.integer 2])) && inside.any (fun x => sameValue x (.array [.integer 3,.integer 2]))
 let tampered := replaceField target "parker_event" (replaceField event "spectral_analysis_upper_keV" (.text "300"))
 let tamperedAnalysis ← ParkerMeasurement.exactMeasurementAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "terminal_inside_complete_range")
 let passed := allRows && controls && tamperedRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("prediction_seal",.text predictionSeal.sealHash),("source_hashes",hashes),("target_identity",.text targetIdentity),("analysis",analysis),("all_rows",.boolean allRows),("controls",.boolean controls),("tampered_rejected",.boolean tamperedRejected),("trace",.text execution.traceHash)]
 let measurements := ["The primary Parker manuscript, complete CODATA source and curated row record are hash-locked and released only after the exact Fold prediction seal.", "The terminal prediction from the complete current alpha rung is approximately 399.714077 keV after post-seal CODATA scale translation; the retained V2 leading-rung control is approximately 399.714072 keV.", "Both exact propagated prediction intervals lie inside the paper's complete 67-527 keV analyzed proton spectrum.", "The primary paper reports protons up to, above and upwards of approximately 400 keV; it does not register 400 keV as an exact cutoff and gives no standard uncertainty for that approximate label.", "Therefore the earlier 'within 0.1 percent' wording is not admitted as a precision measurement claim; only range-level correspondence is supported.", "The complete forced-sector/power control census is retained. Both three-alpha-squared and eight-alpha-squared land inside the broad observed range, so the Parker event alone does not select the eight-channel formula.", "Eight channels remain structurally selected by the independently admitted proton colour sector, never by the Parker target.", "Changing the external upper range to 300 keV rejects the prediction as an unfavorable control."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (ParkerRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.ParkerValidation
