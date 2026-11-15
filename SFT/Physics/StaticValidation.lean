import SFT.Physics.TargetCustody
import SFT.Physics.StaticExperiment
import SFT.Physics.StaticMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.StaticValidation
open SFT.Host SFT.Host.Canonical StaticPrediction StaticExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-STATIC-EXTERIOR-CLOCK-TERMINAL-011"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-static-exterior-clock-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
open StaticMeasurement
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record v1 v2 : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong D9o seal"
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
  (admissionIdentity (.array [.text registrationHash,.text StaticRecords.sourceHash,.object (StaticRecords.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "D9o hostile audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "D9o prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← StaticMeasurement.exactMeasurementAnalysis target
 let yes := fun key => sameValue (PostNewtonianRecords.getDefault analysis key) (.boolean true)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let formalChannel := equals "formal_horizon" (.object [("numerator",.integer 1),("denominator",.integer 2)]) && yes "formal_boundary_empty" && yes "formal_fluxes_conserved" && yes "formal_well_relation" && yes "formal_coefficients_complete_One" && yes "formal_well_halves" && yes "formal_field_quarters" && yes "formal_coefficients_increase" && equals "formal_far_over_near_rate" (.object [("numerator",.integer 16),("denominator",.integer 15)]) && yes "formal_far_clock_faster"
 let prerequisites ← RunningConvergenceMeasurement.array (← field analysis "prerequisite_rows_retained")
 let theory ← RunningConvergenceMeasurement.array (← field analysis "external_theory_rows_retained")
 let nist ← RunningConvergenceMeasurement.array (← field analysis "nist_rows_retained")
 let allRows := yes "all_target_rows_retained" && prerequisites.length==5 && theory.length==9 && nist.length==9
 let controls := yes "historical_relation_retained" && yes "external_unit_conversion_matches" && yes "nist_direction_matches" && yes "nist_scope_preserved" && yes "no_completed_infinity" && yes "no_irrational_clock" && equals "fitted_value_used" (.boolean false)
 let passed := formalChannel && allRows && controls
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("prediction_seal",.text predictionSeal.sealHash),("sources",.object (StaticRecords.sourceHashes.map (fun (k,v) => (k,.text v)))),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formalChannel),("rows",.boolean allRows),("controls",.boolean controls)]
 let measurements := ["The V1 D9o row, five admitted V3 certificates, complete primary exterior-theory paper, complete NIST/JILA paper and earlier gravity vector are hash-locked and open only after the V3 prediction seal.", "V3 independently forces normalized horizon half-One from mass quarter-One, coefficient equal to the positive complement of horizon-over-radius, and empty clock record at the boundary.", "Across twelve exact outward successors, well share halves, field quarters, coefficient increases and field times radius squared remains the identical horizon carrier.", "Exact-square near and far coefficients nine-sixteenths and sixteen-twenty-fifths force clock rates three-quarters and four-fifths and far-over-near rate sixteen-fifteenths without an irrational proof value.", "The primary exterior treatment retains spherical-vacuum uniqueness, staticity, source-free equation, the One-take-two-GM-over-radius coefficient, reciprocal radial coefficient, mass/horizon unit restoration, asymptotic flatness and absent spherical radiation.", "The NIST/JILA paper retains predicted gradient -1.09e-19 per millimetre, corrected full-cloud result -9.8(2.3)e-20, corrected split-cloud result -1.28(27)e-19 and fractional uncertainty 7.6e-21.", "NIST/JILA observes the higher region ticking faster and reports agreement with gravitational redshift after its full systematic treatment.", "The NIST result does not measure universal Fold fractions, and the external coordinate solution does not select the V3 law.", "No completed infinity, numerical boundary zero, negative or irrational proof scalar, measured fit or free correction enters V3."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array ([StaticRecords.sourceId].map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.StaticValidation
