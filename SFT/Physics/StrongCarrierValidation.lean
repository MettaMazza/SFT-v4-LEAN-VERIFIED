import SFT.Physics.TargetCustody
import SFT.Physics.StrongCarrierExperiment
import SFT.Physics.StrongCarrierMeasurement
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.StrongCarrierValidation
open SFT.Host SFT.Host.Canonical StrongCarrierPrediction StrongCarrierExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-strong-carrier-massless-confined-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
open StrongCarrierMeasurement
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record v1 v2 : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong D10f seal"
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
  (admissionIdentity (.array [.text registrationHash,.text StrongCarrierRecords.sourceHash,.object (StrongCarrierRecords.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "D10f hostile audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "D10f prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← StrongCarrierMeasurement.exactMeasurementAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let ratio := fun n d => Value.object [("numerator",.integer n),("denominator",.integer d)]
 let formalChannel := equals "formal_colour_labels" (.integer 3) && equals "formal_carrier_count" (.integer 8) && equals "formal_coupling" (ratio 2 3) && equals "formal_mass_record" (.array []) && equals "formal_One_speed" (ratio 1 1) && yes "formal_phase_retained" && equals "formal_tube_width" (ratio 1 2) && equals "formal_work_successor" (ratio 2 3) && yes "formal_arbitrary_bounds_exceeded" && equals "formal_isolated_colour_record" (.array []) && yes "formal_joint_law"
 let prerequisites ← RunningConvergenceMeasurement.array (← field analysis "prerequisite_rows_retained")
 let scope ← RunningConvergenceMeasurement.array (← field analysis "scope_rows_retained")
 let allRows := yes "all_target_rows_retained" && prerequisites.length==7 && scope.length==5
 let controls := yes "historical_joint_relation_retained" && yes "pdg_three_eight_correspondence" && yes "pdg_massless_classification_correspondence" && yes "pdg_mass_value_is_theoretical_not_direct_measurement" && yes "pdg_mass_caveat_retained" && yes "pdg_self_source_correspondence" && yes "pdg_confinement_correspondence" && yes "pdg_gluon_jet_evidence_retained" && yes "measured_CA_contains_expected" && yes "measured_CF_contains_expected" && equals "colour_factor_values_used_as_formal_proof" (.boolean false) && equals "direct_free_gluon_time_of_flight_available" (.boolean false) && equals "external_values_select_formal_survivor" (.boolean false) && equals "external_mass_value_used_as_formal_proof" (.boolean false) && equals "fitted_value_used" (.boolean false) && equals "free_correction_used" (.boolean false)
 let passed := formalChannel && allRows && controls
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("formal_commit",.text StrongCarrierRecords.formalCommit),("prediction_seal",.text predictionSeal.sealHash),("sources",.object (StrongCarrierRecords.sourceHashes.map (fun (k,v) => (k,.text v)))),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formalChannel),("rows",.boolean allRows),("controls",.boolean controls)]
 let measurements := ["The complete V1 D10f row, ten admitted prerequisite certificates and three complete current PDG sources are hash-locked and released only after the V3 formal commit and in-run prediction seal.", "V3 independently forces three colour labels, eight non-singlet carriers, empty mass and rest-capture records, retained phase advancing one support cell per tick, and no fitted propagation value.", "The same colour-bearing carrier self-sources a fixed half-One tube whose exact separation work increases by two-thirds at every successor and exceeds every positive exact bound at a finite witness.", "The PDG gluon listing records an SU(3) colour octet and m=0, matching the frozen structural classification after release.", "The PDG explicitly classifies m=0 as a theoretical value and says a mass as large as a few MeV may not be precluded; this qualification is retained and no direct free-gluon time-of-flight measurement is claimed.", "The PDG QCD review records Nc=3, Nc-squared-minus-One=8, the adjoint gluon representation, nonlinear field term, three-gluon vertex and four-gluon vertex.", "The same review states that neither quarks nor gluons are observed as free particles and that hadrons are colour-singlet combinations, matching the frozen asymptotic observation boundary.", "Collider colour-factor measurements CA=2.89+/-0.03(stat)+/-0.21(syst) and CF=1.30+/-0.01(stat)+/-0.09(syst) contain the published SU(3) expectations 3 and 4/3 within exact conservative summed uncertainty boundaries.", "The PDG also records clear experimental evidence that gluon jets are softer and broader than light-quark jets; the quark-model review describes physical states as colour singlets and colour as believed permanently confined.", "External measurements and classifications test only the already sealed result: they do not select its survivor, enter its proof arithmetic, fit a parameter or add a carrier correction."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array ([StrongCarrierRecords.sourceId].map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.StrongCarrierValidation
