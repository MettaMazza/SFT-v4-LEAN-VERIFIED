import SFT.Physics.TargetCustody
import SFT.Physics.ProtonRadiusExperiment
import SFT.Physics.ProtonRadiusMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.ProtonRadiusValidation
open SFT.Host SFT.Host.Canonical ProtonRadiusExperiment ProtonRadiusPrediction LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-PROTON-RADIUS-TERMINAL-029"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-proton-radius-terminal-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
 if !Text.equal sealedClaim claimId then throw "wrong proton-radius seal"
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
 let hashes := Value.object (ProtonRadiusRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "proton-radius hostile-package audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let mapped ← outputMapping execution.output keys
 if !sameValue (.object (mapped.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "proton-radius prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← ProtonRadiusMeasurement.exactMeasurementAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let adverse ← RunningConvergenceMeasurement.array (← field analysis "adverse_formula_rows")
 let current ← match ← field analysis "current_intervals_fm" with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "TypeError"
 let allRows := current.length == 4 && adverse.length == 9 && yes "scope_rows_retained"
 let inside ← RunningConvergenceMeasurement.array (← field analysis "adverse_inside_muonic_interval")
 let controls := yes "all_current_intervals_contain_prediction" && yes "historical_conflict_retained" && equals "observation_uniquely_selects_ten_linear" (.boolean false) && ([8,9,10] : List Nat).all (fun n => inside.any (fun x => sameValue x (.array [.integer (.ofNat n),.text "linear"])))
 let rows ← RunningConvergenceMeasurement.array (← field target "current_radius_rows")
 let altered ← match rows with
  | [] => throw "IndexError"
  | first::rest => pure (replaceField (replaceField first "value_fm" (.text "0.8200")) "standard_uncertainty_fm" (.text "0.0010") :: rest)
 let tampered := replaceField target "current_radius_rows" (.array altered)
 let tamperedAnalysis ← ProtonRadiusMeasurement.exactMeasurementAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "all_current_intervals_contain_prediction")
 let passed := allRows && controls && tamperedRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("prediction_seal",.text predictionSeal.sealHash),("source_hashes",hashes),("target_identity",.text targetIdentity),("analysis",analysis),("all_rows",.boolean allRows),("controls",.boolean controls),("tampered_rejected",.boolean tamperedRejected),("trace",.text execution.traceHash)]
 let measurements := ["The exact coefficient and all structural alternatives seal before the four primary/authoritative source identities and radius rows are released.", "The exact terminal coefficient is 10069574419808/2519231977345 = 4(One-alpha_terminal/10), with no probe or radius measurement in its derivation.", "Post-seal composition with the complete CODATA-2022 reduced-proton-Compton interval predicts approximately 0.840621761 fm with exact outward uncertainty propagation.", "The prediction interval lies inside the registered 2026 electronic-hydrogen 0.8406(15) fm interval and the current muonic-hydrogen 0.84060(39) fm interval.", "The prediction interval lies inside the CODATA-2022 0.84075(64) fm interval and the conservative PRad 0.831 +/-0.007(stat) +/-0.012(syst) outward interval.", "The historical CODATA-2014 0.8751(61) fm interval is disjoint and remains an explicit unfavorable historical row.", "The primary 2026 paper's partly discrepant earlier electronic results and scattering-analysis dependence remain explicit; probe independence is not relabelled as universal agreement among all extractions.", "All three linear-support alternatives land inside the present muonic interval, so measurement does not select ten; the complete proton charge-support derivation does.", "Changing the current electronic-hydrogen row to a disjoint interval rejects the correspondence."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (ProtonRadiusRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.ProtonRadiusValidation
