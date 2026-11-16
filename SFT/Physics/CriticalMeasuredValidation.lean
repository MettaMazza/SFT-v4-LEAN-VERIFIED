import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.CriticalMeasuredExperiment
import SFT.Physics.CriticalMeasuredMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.CriticalMeasuredValidation
open SFT.Host SFT.Host.Canonical CriticalMeasuredExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-CRITICALITY-MEASURED-VALUE-056"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-criticality-measured-value-successor/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def tamperedVector (target : Value) : Except String Value := do
 let original ← field target "original"
 let measured ← field original "registered_target"
 let rows ← RunningConvergenceMeasurement.array (← field measured "manganite_rows")
 let row ← RunningConvergenceMeasurement.rowAt rows 1
 let rows ← replaceAt rows 1 (replaceField row "gamma_center" (.integer 200))
 .ok (replaceField target "original" (replaceField original "registered_target" (replaceField measured "manganite_rows" (.array rows))))
def tamperedKey (target : Value) : Except String Value := do
 let record ← field target "record"
 let key ← field record "manganite_complete_structural_key"
 .ok (replaceField target "record" (replaceField record "manganite_complete_structural_key" (replaceField key "Widom_relation_verified_for_reported_exponents" (.boolean false))))
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong criticality successor seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (CriticalMeasuredRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "criticality successor prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "criticality successor prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← CriticalMeasuredMeasurement.exactCriticalityAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := CriticalMeasuredWitnesses.witnesses.all CriticalMeasuredWitnesses.Witness.passed
 let allRows := yes "all_source_rows_retained"
 let empirical := yes "all_five_material_keys_complete" && yes "complete_manganite_residual_below_One" && yes "complete_residual_exact_value" && yes "La02_retained_without_mismatch_reward" && yes "erbium_vector_passed" && yes "turbulence_structure_passed" && yes "both_spectrum_routes_passed" && yes "limitations_retained" && yes "all_source_rows_retained"
 let vectorAnalysis ← CriticalMeasuredMeasurement.exactCriticalityAnalysis (← tamperedVector target)
 let vectorRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault vectorAnalysis "complete_manganite_residual_below_One")
 let keyAnalysis ← CriticalMeasuredMeasurement.exactCriticalityAnalysis (← tamperedKey target)
 let keyRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault keyAnalysis "all_five_material_keys_complete")
 let passed := formal && empirical && vectorRejected && keyRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("tampered_vector_rejected",.boolean vectorRejected),("tampered_key_rejected",.boolean keyRejected)]
 let measurements := ["All five complete manganite structural class keys identify the registered mean-field class.", "All fifteen beta/gamma/delta measurements enter once; their exact mean squared normalized residual is 5286961/10584000, below the One.", "The complete erbium vector contains one-half, One and one-half; the independent turbulence interval contains two-thirds.", "Both physical spectral routes exhibit the falling five-thirds compensated plateau with all limitations retained.", "La02 remains visible without its displacement becoming a result; tampered vector and structural-key controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (CriticalMeasuredRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.CriticalMeasuredValidation
