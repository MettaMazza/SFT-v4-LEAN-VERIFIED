import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.HiggsObservationExperiment
import SFT.Physics.HiggsObservationAnalysis
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.HiggsObservationValidation
open SFT.Host SFT.Host.Canonical HiggsObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-HIGGS-SYMMETRY-TERMINAL-066"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-Higgs-terminal-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def outsideMass (target : Value) : Except String Value := changeSourceRow target 1 "higgs_mass_world_average" "reported_interval_from_listed_uncertainty_gev" (.array [.text "124/1",.text "125/1"])
def outsideCoupling (target : Value) : Except String Value := changeSourceRow target 4 "trilinear_self_coupling_constraint" "upper_coordinate" (.text "9/10")
def erasedOffset (target analysis : Value) : Except String Value := do
 let value ← field analysis "predicted_mass_gev"
 let numerator ← match (← field value "numerator") with | .integer n=>.ok n | .null | .boolean _ | .text _ | .array _ | .object _=>.error "TypeError"
 let denominator ← match (← field value "denominator") with | .integer n=>.ok n | .null | .boolean _ | .text _ | .array _ | .object _=>.error "TypeError"
 let rendered := if (@decide (denominator=1) (Int.decEq _ _)) then render (.integer numerator) else Text.append (render (.integer numerator)) (Text.append "/" (render (.integer denominator)))
 changeSourceRow target 2 "combined_higgs_mass" "reported_value_gev" (.text rendered)
def formalPass : Bool := match HiggsCertificate.theoremCertificate with
 | .error _=>false
 | .ok c=>c.terminalMassRatio==normalize 2563352914777 5038463954690 (by decide) && c.terminalSelfCoupling==normalize 6570778165695741824959729 50772238045420788745992200 (by decide) && c.routeCrossLock.routesEqual
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong Higgs terminal empirical seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (HiggsObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
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
 let analysis ← HiggsObservationAnalysis.exactAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := formalPass
 let allRows := yes "all_sources_retained"
 let empirical := sameValue (PostNewtonianRecords.getDefault analysis "predicted_mass_gev") (RunningConvergenceCertificate.rat (normalize 31557437733819647 251923197734500 (by decide))) && yes "pdg_aggregate_contains_prediction" && yes "individual_offsets_retained" && !yes "atlas_one_reported_uncertainty_contains_prediction" && !yes "cms_one_reported_uncertainty_contains_prediction" && yes "kappa_interval_contains_prediction" && !yes "direct_coupling_is_precision_measurement" && yes "all_sources_retained" && yes "all_measurement_rows_positive_where_unsigned"
 let massAnalysis ← HiggsObservationAnalysis.exactAnalysis (← outsideMass target)
 let massRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault massAnalysis "pdg_aggregate_contains_prediction")
 let couplingAnalysis ← HiggsObservationAnalysis.exactAnalysis (← outsideCoupling target)
 let couplingRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault couplingAnalysis "kappa_interval_contains_prediction")
 let offsetAnalysis ← HiggsObservationAnalysis.exactAnalysis (← erasedOffset target analysis)
 let offsetRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault offsetAnalysis "individual_offsets_retained")
 let passed := formal && empirical && massRejected && couplingRejected && offsetRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("outside_mass_rejected",.boolean massRejected),("outside_coupling_rejected",.boolean couplingRejected),("erased_offset_rejected",.boolean offsetRejected)]
 let measurements := ["The sealed exact ratio and post-seal PDG 246.22 GeV dimensional reference give 125.266104978... GeV.", "The prediction lies inside the PDG 2025 125.20 +/- 0.11 GeV listed-average interval.", "ATLAS and CMS individual offsets are retained exactly and are not falsely described as one-uncertainty agreements.", "The exact native coupling is 0.1294167525...; normalized unity lies inside the 2026 combined direct-search interval.", "The direct self-coupling constraint remains broad and is not called a precision measurement.", "Outside-mass, outside-coupling and erased-offset hostile controls all reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (HiggsObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.HiggsObservationValidation
