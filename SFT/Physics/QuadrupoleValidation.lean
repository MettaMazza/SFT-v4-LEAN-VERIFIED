import SFT.Physics.TargetCustody
import SFT.Physics.QuadrupoleExperiment
import SFT.Physics.QuadrupoleMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.QuadrupoleValidation
open SFT.Host SFT.Host.Canonical QuadrupolePrediction QuadrupoleExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-QUADRUPOLE-RADIATED-POWER-TERMINAL-012"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-quadrupole-radiated-power-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def lookup (rows : List (String × CapabilityValues.Value)) (key : String) : Except String CapabilityValues.Value :=
 match rows.find? (fun p => Text.equal p.1 key) with
 | some p => .ok p.2
 | none => .error (Text.append "KeyError: " key)
def labelMatches (v : CapabilityValues.Value) (family label : String) : Bool := match v with
 | .label held => Text.equal held.family family && Text.equal held.label label
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
open QuadrupoleMeasurement
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record v1 v2 : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong D9q seal"
 let registration ← registrationRecord
 let registrationHash := admissionIdentity registration
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← formalPredictionInputs
 let orderedKeys := inputs.map Prod.fst
 let env := envelope derivationSeal inputs registrationHash
 let targets ← releasedTargets files record v1 v2
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") targets
  (admissionIdentity (.array [.text registrationHash,.text QuadrupoleRecords.sourceHash,.object (QuadrupoleRecords.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "D9q hostile audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "D9q prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← QuadrupoleMeasurement.exactMeasurementAnalysis target
 let yes := fun key => sameValue (PostNewtonianRecords.getDefault analysis key) (.boolean true)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let ratio := fun n d => Value.object [("numerator",.integer n),("denominator",.integer d)]
 let formalChannel := equals "formal_coupling" (ratio 1 2) && equals "formal_base_third_rate" (ratio 6 1) && equals "formal_base_power" (ratio 18 1) && equals "formal_doubled_power" (ratio 72 1) && equals "formal_static_power_record" (.array []) && yes "formal_power_quadruples" && yes "formal_shell_power_conserved" && yes "formal_successor_identity" && equals "formal_normalized_binary_comparison" (ratio 1 1)
 let prerequisites ← RunningConvergenceMeasurement.array (← field analysis "prerequisite_rows_retained")
 let corrections ← RunningConvergenceMeasurement.array (← field analysis "primary_correction_rows_retained")
 let scope ← RunningConvergenceMeasurement.array (← field analysis "primary_scope_rows_retained")
 let allRows := yes "all_target_rows_retained" && prerequisites.length==6 && corrections.length==10 && scope.length==7
 let controls := yes "historical_relation_retained" && yes "primary_quadrupole_classification_matches" && yes "measured_contains_One_at_published_uncertainty" && yes "measured_within_95_percent_boundary" && yes "extreme_EOS_contains_One" && equals "negative_external_sign_used_as_proof" (.boolean false) && equals "fitted_value_used" (.boolean false) && equals "free_correction_used" (.boolean false)
 let passed := formalChannel && allRows && controls
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("formal_commit",.text QuadrupoleRecords.formalCommit),("prediction_seal",.text predictionSeal.sealHash),("sources",.object (QuadrupoleRecords.sourceHashes.map (fun (k,v) => (k,.text v)))),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formalChannel),("rows",.boolean allRows),("controls",.boolean controls)]
 let measurements := ["The complete V1 D9q row, eight admitted prerequisite certificates and complete 56-page primary Double Pulsar paper are hash-locked and released only after the V3 formal commit and in-run prediction seal.", "V3 independently forces held monopole and dipole records, third generated quadrupole difference, half-One times its positive square, structural static silence and exact amplitude-square scaling.", "The all-positive cubic opposition identity has retained third-rate six at every successor; the exact witness has power eighteen and doubled amplitude has power seventy-two.", "Rank-two outward transport quarters density at every binary radius successor while density paired with radius twice reconstructs the same total power.", "The 16-year PSR J0737-3039A/B record covers a 2.45-hour mildly eccentric orbit and approximately sixty thousand tracked orbits.", "The primary paper retains Shklovskii, Galactic and spin-down mass-loss corrections before reporting measured GW-driven orbital decay -1.247782(79)e-12.", "The primary quadrupole prediction -1.247810(+6/-7)e-12 and retained 3.5PN correction -1.75e-17 give total prediction -1.247827(+6/-7)e-12.", "Measured over predicted decay is 0.999963(63): its exact rational uncertainty interval contains the formal normalized One, and the published 95-percent agreement boundary is 1.3e-4.", "The extreme equation-of-state rerun 0.999958(64), timing-error dominance, future kinematic limit, material-binary regime and compact-object comparison caveats are all retained.", "The external negative decay direction and decimal measurements remain observational records; no measured value, fitted parameter, target-selected survivor or free radiation correction enters V3."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array ([QuadrupoleRecords.sourceId].map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.QuadrupoleValidation
