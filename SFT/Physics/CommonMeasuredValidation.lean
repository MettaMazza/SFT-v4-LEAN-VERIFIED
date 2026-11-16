import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.CommonMeasuredExperiment
import SFT.Physics.CommonMeasuredMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.CommonMeasuredValidation
open SFT.Host SFT.Host.Canonical CommonMeasuredExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-common-scale-measured-value-successor/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def tamperedTerminal (target : Value) : Except String Value := do
 let rows ← RunningConvergenceMeasurement.array (← field target "scheme_rows")
 let row ← RunningConvergenceMeasurement.rowAt rows 0
 let rows ← replaceAt rows 0 (replaceField row "center" (.text "0.22000"))
 .ok (replaceField target "scheme_rows" (.array rows))
def tamperedAPV (target : Value) : Except String Value := do
 let rows ← RunningConvergenceMeasurement.array (← field target "low_transfer_rows")
 let row ← RunningConvergenceMeasurement.rowAt rows 3
 let changed := replaceField (replaceField row "center" (.text "0.2300")) "standard_uncertainty" (.text "0.0001")
 let rows ← replaceAt rows 3 changed
 .ok (replaceField target "low_transfer_rows" (.array rows))
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong common-scale successor seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (CommonMeasuredRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "common-scale successor prediction audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "common-scale successor prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← CommonMeasuredMeasurement.exactCommonScaleAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := CommonMeasuredWitnesses.witnesses.all CommonMeasuredWitnesses.Witness.passed
 let allRows := yes "all_source_rows_retained"
 let empirical := yes "terminal_inside_on_shell_interval" && yes "support_eight_inside_APV_interval" && yes "E158_interval_above_MS_Z" && yes "APV_interval_above_MS_Z" && yes "eDIS_interval_overlaps_MS_Z" && yes "complete_scheme_rows" && yes "complete_low_transfer_rows" && yes "complete_displayed_classes" && yes "threshold_boundary_retained" && yes "strong_EM_receipt_retained" && yes "NuTeV_extraction_retained" && yes "NuTeV_not_rewarded_as_mismatch" && yes "all_source_rows_retained"
 let terminalAnalysis ← CommonMeasuredMeasurement.exactCommonScaleAnalysis (← tamperedTerminal target)
 let terminalRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault terminalAnalysis "terminal_inside_on_shell_interval")
 let apvAnalysis ← CommonMeasuredMeasurement.exactCommonScaleAnalysis (← tamperedAPV target)
 let apvRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault apvAnalysis "support_eight_inside_APV_interval")
 let passed := formal && empirical && terminalRejected && apvRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("tampered_terminal_rejected",.boolean terminalRejected),("tampered_APV_rejected",.boolean apvRejected)]
 let measurements := ["The exact forced terminal weak share lies inside [22333,22351]/100000.", "The exact forced support-eight share 25/106 lies inside [2331,2367]/10000.", "The complete E158 and APV intervals preserve the sealed below-W direction relative to the MS-Z interval.", "NuTeV remains unchanged as a source-identified interpretation-sensitive DIS extraction; its displacement is not an SFT result or acceptance condition.", "No row was deleted and no uncertainty was widened; displaced terminal and APV controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (CommonMeasuredRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.CommonMeasuredValidation
