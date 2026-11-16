import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.CollapseObservationExperiment
import SFT.Physics.CollapseObservationAnalysis
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.CollapseObservationValidation
open SFT.Host SFT.Host.Canonical CollapseObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-STELLAR-NUCLEAR-COLLAPSE-070"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-stellar-nuclear-collapse-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def erasedStage (target : Value) : Except String Value := do
 let sources ← RunningConvergenceMeasurement.array (← field target "sources")
 let source ← LeptonRatios.atIndex sources 0
 let held ← RunningConvergenceMeasurement.array (← field (← field (← field source "rows") "massive_star_burning_stages") "complete_rows")
 changeSourceRow target 0 "massive_star_burning_stages" "complete_rows" (.array (held.take (held.length-1)))
def hiddenIrregularity (target : Value) : Except String Value := do
 let sources ← RunningConvergenceMeasurement.array (← field target "sources")
 let source ← LeptonRatios.atIndex sources 0
 let held ← RunningConvergenceMeasurement.array (← field (← field (← field source "rows") "massive_star_burning_stages") "complete_rows")
 let row ← LeptonRatios.atIndex held 4
 changeSourceRow target 0 "massive_star_burning_stages" "complete_rows" (.array (held.take 4 ++ [replaceField row "duration_years" (.text "1/1000")] ++ held.drop 5))
def erasedDetector (target : Value) : Except String Value := do
 let sources ← RunningConvergenceMeasurement.array (← field target "sources")
 let source ← LeptonRatios.atIndex sources 2
 let held ← RunningConvergenceMeasurement.array (← field (← field (← field source "rows") "sn1987a_neutrino_reanalysis") "detectors")
 changeSourceRow target 2 "sn1987a_neutrino_reanalysis" "detectors" (.array (held.take (held.length-1)))
def outsideRatio (target : Value) : Except String Value := changeSourceRow target 3 "sn2014j_nickel_cobalt_gamma_lines" "measured_line_ratio_uncertainty" (.text "1/100")
def erasedCapture (target : Value) : Except String Value := changeSourceRow target 4 "gw170817_strontium_identification" "identified_element" (.text "unidentified")
def formalPass : Bool := match StellarCollapseCertificate.theoremCertificate with
 | .error _=>false
 | .ok c=>
  let yes := StellarCertificate.flag c
  yes "all_chains_strict" && StellarCertificate.flag (PostNewtonianRecords.getDefault c "binding_terminal") "unique" && StellarCertificate.flag (PostNewtonianRecords.getDefault c "binding_terminal") "tail_closed" && StellarCertificate.flag (PostNewtonianRecords.getDefault c "support_loss") "collapse_forced_when_no_other_support" && yes "all_thermonuclear_finite" && yes "all_neutral_capture_closed"
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong stellar nuclear/collapse empirical seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (CollapseObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
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
 if !labelMatches execution.output then throw "sealed stellar nuclear/collapse prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← CollapseObservationAnalysis.exactAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := formalPass
 let allRows := yes "all_sources_retained"
 let val := fun key=>PostNewtonianRecords.getDefault analysis key
 let rat := fun n d=>RunningConvergenceCertificate.rat (normalize n (d+1) (Nat.zero_lt_succ d))
 let empirical := sameValue (val "stage_row_count") (val "declared_stage_row_count") && sameValue (val "stage_row_count") (.integer 6) && yes "stage_temperatures_strict" && yes "all_stage_durations_retained" && !yes "durations_strictly_decreasing" && yes "oxygen_neon_duration_irregularity_retained" && yes "onion_support_reported" && sameValue (val "cno_rate") (rat 36 4) && yes "collapse_model_assisted_retained" && sameValue (val "collapse_detector_count") (.integer 3) && sameValue (val "gamma_line_energies_kev") (.array [rat 847 0,rat 1238 0]) && yes "gamma_interval_contains_branch_ratio" && sameValue (val "gamma_spectrum_significance") (rat 113 9) && yes "gamma_model_assisted_retained" && sameValue (val "capture_identified_element") (.text "strontium") && sameValue (val "capture_feature_nm") (rat 810 0) && yes "capture_model_assisted_retained" && yes "all_sources_retained"
 let sourceRows ← RunningConvergenceMeasurement.array (← field target "sources")
 let cnoRow ← field (← field (← LeptonRatios.atIndex sourceRows 1) "rows") "solar_cno_neutrino_detection"
 let collapseRow ← field (← field (← LeptonRatios.atIndex sourceRows 2) "rows") "sn1987a_neutrino_reanalysis"
 let significance ← YangMillsSpectrumMeasurement.exactInput (← field cnoRow "minimum_significance_sigma")
 let probability ← YangMillsSpectrumMeasurement.exactInput (← field collapseRow "minimum_two_to_one_component_probability_ratio")
 let empirical := empirical && !significance.blt (normalize 5 1 (by decide)) && !probability.blt (normalize 100 1 (by decide))
 let stageAnalysis ← CollapseObservationAnalysis.exactAnalysis (← erasedStage target)
 let stageRejected := !sameValue (PostNewtonianRecords.getDefault stageAnalysis "stage_row_count") (.integer 6)
 let irregularAnalysis ← CollapseObservationAnalysis.exactAnalysis (← hiddenIrregularity target)
 let irregularRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault irregularAnalysis "oxygen_neon_duration_irregularity_retained")
 let detectorAnalysis ← CollapseObservationAnalysis.exactAnalysis (← erasedDetector target)
 let detectorRejected := !sameValue (PostNewtonianRecords.getDefault detectorAnalysis "collapse_detector_count") (.integer 3)
 let ratioAnalysis ← CollapseObservationAnalysis.exactAnalysis (← outsideRatio target)
 let ratioRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault ratioAnalysis "gamma_interval_contains_branch_ratio")
 let captureAnalysis ← CollapseObservationAnalysis.exactAnalysis (← erasedCapture target)
 let captureRejected := !sameValue (PostNewtonianRecords.getDefault captureAnalysis "capture_identified_element") (.text "strontium")
 let passed := formal && empirical && stageRejected && irregularRejected && detectorRejected && ratioRejected && captureRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("controls",.array [.boolean stageRejected,.boolean irregularRejected,.boolean detectorRejected,.boolean ratioRejected,.boolean captureRejected])]
 let measurements := ["All six stellar stages have strictly increasing measured temperatures; every duration, including the nonmonotonic neon/oxygen pair, is retained.", "Borexino directly records CNO fusion neutrinos at 36/5 +3 -17/10 cpd per 100 tonnes and at least five-sigma significance.", "The complete three-detector SN1987A neutrino record is retained, with model preference explicitly identified as model-assisted.", "Both SN2014J cobalt lines, flux errors and ratio are retained; the measured ratio interval contains 17/25.", "GW170817 spectroscopy identifies strontium while retaining every spectral-modelling boundary.", "Erased-stage, hidden-irregularity, erased-detector, outside-ratio and erased-capture controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (CollapseObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.CollapseObservationValidation
