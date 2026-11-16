import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.StellarObservationExperiment
import SFT.Physics.StellarObservationAnalysis
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.StellarObservationValidation
open SFT.Host SFT.Host.Canonical StellarObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-STELLAR-GALACTIC-TIDAL-068"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-stellar-galactic-tidal-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def erasedStellar (target : Value) : Except String Value := do
 let sources ← RunningConvergenceMeasurement.array (← field target "sources")
 let source ← LeptonRatios.atIndex sources 1
 let rows ← field (← field (← field source "rows") "piecewise_main_sequence_mass_luminosity") "complete_rows"
 let held ← RunningConvergenceMeasurement.array rows
 changeSourceRow target 1 "piecewise_main_sequence_mass_luminosity" "complete_rows" (.array (held.drop (held.length-2)))
def centralOnly (target : Value) : Except String Value := changeSourceRow target 3 "baryonic_tully_fisher" "reported_systematic_slope_interval" (.array [.text "7/2",.text "399/100"])
def falseLunarLock (target : Value) : Except String Value := changeSourceRow target 5 "lunar_synchronous_rotation" "rotation_duration_hours" (.text "654/1")
def erasedMercury (target : Value) : Except String Value := changeSourceRow target 6 "mercury_spin_orbit_resonance" "orbital_cycles" (.integer 3)
def formalPass : Bool := match StellarCertificate.theoremCertificate with
 | .error _=>false
 | .ok c=>
  let yes := StellarCertificate.flag c
  StellarCertificate.flag (PostNewtonianRecords.getDefault c "hydrostatic") "balanced" && yes "all_radial_restoring" && sameValue (PostNewtonianRecords.getDefault c "luminosity_exponents") (.array [.integer 3,.integer 4]) && sameValue (PostNewtonianRecords.getDefault c "lifetime_fall_exponents") (.array [.integer 2,.integer 3]) && yes "all_flat_rows_require_growth" && sameValue (PostNewtonianRecords.getDefault c "tully_fisher_exponent") (.integer 4) && yes "all_tidal_rows_lock"
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong stellar/galactic/tidal empirical seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (StellarObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
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
 if !labelMatches execution.output then throw "sealed stellar/galactic/tidal prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← StellarObservationAnalysis.exactAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := formalPass
 let allRows := yes "all_sources_retained"
 let empirical := yes "solar_reference_inside_observed_interval" && yes "solar_reference_not_sft_prediction" && yes "all_six_stellar_rows_retained" && yes "only_high_mass_row_contains_four" && yes "only_very_high_mass_row_contains_three" && sameValue (PostNewtonianRecords.getDefault analysis "sparc_galaxy_count") (.integer 175) && sameValue (PostNewtonianRecords.getDefault analysis "btfr_galaxy_count") (.integer 153) && !yes "btfr_central_contains_four" && yes "btfr_systematic_contains_four" && sameValue (PostNewtonianRecords.getDefault analysis "bullet_separation_significance") (RunningConvergenceCertificate.rat (normalize 8 1 (by decide))) && yes "bullet_mass_follows_galaxies" && yes "moon_one_to_one" && yes "mercury_is_three_to_two_boundary" && yes "mercury_is_not_one_to_one" && yes "all_sources_retained"
 let stellarAnalysis ← StellarObservationAnalysis.exactAnalysis (← erasedStellar target)
 let stellarRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault stellarAnalysis "all_six_stellar_rows_retained")
 let centralAnalysis ← StellarObservationAnalysis.exactAnalysis (← centralOnly target)
 let centralRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault centralAnalysis "btfr_systematic_contains_four")
 let lunarAnalysis ← StellarObservationAnalysis.exactAnalysis (← falseLunarLock target)
 let lunarRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault lunarAnalysis "moon_one_to_one")
 let mercuryAnalysis ← StellarObservationAnalysis.exactAnalysis (← erasedMercury target)
 let mercuryRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault mercuryAnalysis "mercury_is_three_to_two_boundary")
 let passed := formal && empirical && stellarRejected && centralRejected && lunarRejected && mercuryRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("erased_stellar_rejected",.boolean stellarRejected),("central_only_rejected",.boolean centralRejected),("false_lunar_lock_rejected",.boolean lunarRejected),("erased_mercury_rejected",.boolean mercuryRejected)]
 let measurements := ["Helioseismology reports stable solar structure at parts-per-ten-thousand sound-speed precision; its conventional reference value is not relabelled as an SFT prediction.", "All six piecewise stellar slopes remain; only the high and very-high mass rows contain terminal powers four and three.", "All 175 SPARC galaxies and all 153 Tully-Fisher galaxies remain in the registered population records.", "The Tully-Fisher central interval excludes four while the complete reported systematic interval reaches four; both are retained.", "The Bullet Cluster records an eight-sigma separation between the mass and dominant plasma peaks.", "The Moon records 1:1 synchronous rotation; Mercury records the separately declared 3:2 eccentric-resonance boundary.", "Erased-row, central-only, false-lunar-lock and erased-Mercury hostile controls reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (StellarObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.StellarObservationValidation
