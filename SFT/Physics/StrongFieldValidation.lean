import SFT.Physics.TargetCustody
import SFT.Physics.StrongFieldExperiment
import SFT.Physics.StrongFieldMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.StrongFieldValidation
open SFT.Host SFT.Host.Canonical StrongFieldPrediction StrongFieldExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-strong-field-nonlinear-fixed-point-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
open StrongFieldMeasurement
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record v1 v2 : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong D10e seal"
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
  (admissionIdentity (.array [.text registrationHash,.text StrongFieldRecords.sourceHash,.object (StrongFieldRecords.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "D10e hostile audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "D10e prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← StrongFieldMeasurement.exactMeasurementAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let ratio := fun n d => Value.object [("numerator",.integer n),("denominator",.integer d)]
 let formalChannel := yes "formal_neutral_hold" && equals "formal_neutral_correction" (.array []) && equals "formal_gravity_fixed_point" (.array [ratio 1 4]) && yes "formal_gravity_contracts" && equals "formal_strong_initial_source" (ratio 1 1) && equals "formal_strong_correction" (ratio 2 1) && yes "formal_strong_persists" && equals "formal_strong_finite_fixed_point_record" (.array []) && yes "formal_strong_no_positive_finite_fixed_point" && yes "formal_strong_registered_bounds_exceeded" && equals "formal_completed_infinity_used" (.boolean false)
 let lattice ← RunningConvergenceMeasurement.array (← field analysis "lattice_values_retained")
 let allRows := yes "all_target_rows_retained" && lattice.length==5
 let controls := yes "historical_discriminator_retained" && yes "pdg_self_interaction_correspondence" && yes "pdg_free_quark_boundary_retained" && yes "lattice_unbroken_branch_correspondence" && yes "lattice_full_ground_state_limit_retained" && yes "lattice_limits_retained" && equals "external_values_select_formal_survivor" (.boolean false) && equals "external_distances_used_as_formal_proof" (.boolean false) && equals "fitted_value_used" (.boolean false) && equals "free_correction_used" (.boolean false)
 let passed := formalChannel && allRows && controls
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("formal_commit",.text StrongFieldRecords.formalCommit),("prediction_seal",.text predictionSeal.sealHash),("sources",.object (StrongFieldRecords.sourceHashes.map (fun (k,v) => (k,.text v)))),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formalChannel),("rows",.boolean allRows),("controls",.boolean controls)]
 let measurements := ["The complete V1 D10e row, nine admitted prerequisites, the complete current PDG QCD review and complete primary lattice-QCD paper are hash-locked and released only after the frozen V3 commit and in-run prediction seal.", "V3 independently forces an empty chargeless correction with held One source, the admitted gravity quarter-One fixed point with shrinking corrections, and a colour self-source successor F plus two with the exact binary correction retained at every successor.", "For every positive exact finite F, F plus two is strictly above F, so the strong positive finite fixed-point record is empty; for every positive exact finite bound, the same law constructs a finite source witness above it without a completed infinity.", "The PDG QCD review independently retains non-abelian colour, colour-bearing gluons, three- and four-gluon self-interactions and the absence of observed free quarks.", "The lattice study independently reports that the gluons-only static energy grows linearly at asymptotically large separation with string tension sigma and models the unbroken string state as V-hat(r)=V-hat-0+sigma*r in the breaking region.", "The same study observes the required adverse boundary: dynamical light-quark pair creation mixes the string with broken-string states, and the full-QCD ground state tends to two noninteracting static-light mesons rather than growing without bound.", "The reported light and strange breaking distances, 1.224(15) fm and 1.293(16) fm, are retained with lattice spacing 0.06426(76) fm and the 280 MeV pion and 460 MeV kaon masses.", "Those distances come from one ensemble with nonphysical quark masses and are not promoted to universal physical constants; they neither select the Fold survivor nor enter its formal arithmetic.", "The exact correspondence is therefore branchwise: persistent Fold colour self-source matches the unbroken string branch, while pair-created state mixing supplies a distinct full-QCD saturation channel that the validation retains explicitly.", "No external value fits a parameter, supplies a free correction or changes the frozen generated grammar."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array ([StrongFieldRecords.sourceId].map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.StrongFieldValidation
