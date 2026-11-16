import SFT.Physics.SymmetricRecords
import SFT.Physics.TargetCustody
import SFT.Physics.HorizonObservationExperiment
import SFT.Physics.HorizonObservationAnalysis
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.HorizonObservationValidation
open SFT.Host SFT.Host.Canonical HorizonObservationExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-VALIDATION-COMPACT-HORIZON-THERMODYNAMICS-072"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-compact-horizon-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def reversedOrder (target : Value) : Except String Value := changeSourceRow target 1 "massive_neutron_star" "reported_mass_solar" (.text "13/10")
def collapsedUpper (target : Value) : Except String Value := changeSourceRow target 2 "conditional_hypermassive_maximum" "maximum_baryonic_mass_solar" (.text "2/1")
def erasedCondition (target : Value) : Except String Value := changeSourceRow target 2 "conditional_nonrotating_maximum" "use_boundary" (.text "direct measurement")
def formalPass : Bool := match CompactHorizon.theoremCertificate with
 | .error _=>false
 | .ok c=>
  let yes := StellarCertificate.flag c
  yes "all_exclusion_scalings_close" && yes "two_pre_horizon_families" && yes "reference_cross_closes" && yes "all_evaporation_traces_close"
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong compact-object empirical seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (HorizonObservationRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
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
 if !labelMatches execution.output then throw "sealed compact-object prediction label changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← HorizonObservationAnalysis.exactAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let formal := formalPass
 let allRows := yes "all_sources_retained"
 let val := fun key=>PostNewtonianRecords.getDefault analysis key
 let rat := fun n d=>RunningConvergenceCertificate.rat (normalize n (d+1) (Nat.zero_lt_succ d))
 let empirical := sameValue (val "white_dwarf_limit_solar") (rat 7 4) && sameValue (val "neutron_star_interval_solar") (.array [rat 201 99,rat 215 99]) && yes "neutron_star_interval_wholly_above_white_dwarf_limit" && !yes "neutron_star_mass_is_direct_maximum_measurement" && yes "both_conditional_uppers_above_neutron_interval" && yes "conditional_roles_retained" && sameValue (val "horizon_validation_receipt") (.text "sha256:8279f3140235ca46ae66bbf4ed0fbf28c804d3bb42b43ecdb0d12ce45dc807b8") && !yes "hawking_directly_measured" && !yes "hawking_nonobservation_rewarded_as_match" && yes "all_sources_retained"
 let orderAnalysis ← HorizonObservationAnalysis.exactAnalysis (← reversedOrder target)
 let orderRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault orderAnalysis "neutron_star_interval_wholly_above_white_dwarf_limit")
 let upperAnalysis ← HorizonObservationAnalysis.exactAnalysis (← collapsedUpper target)
 let upperRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault upperAnalysis "both_conditional_uppers_above_neutron_interval")
 let conditionAnalysis ← HorizonObservationAnalysis.exactAnalysis (← erasedCondition target)
 let conditionRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault conditionAnalysis "conditional_roles_retained")
 let passed := formal && empirical && orderRejected && upperRejected && conditionRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("sources",hashes),("target",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("controls",.array [.boolean orderRejected,.boolean upperRejected,.boolean conditionRejected])]
 let measurements := ["NASA records electron degeneracy and the 7/5-solar-mass white-dwarf limit.", "PSR J0740+6620 is measured at 52/25 +/- 7/100 solar masses; its complete interval lies above 7/5.", "Both LIGO-Virgo conditional remnant limits are retained with their model conditions and are not called direct TOV measurements.", "The prior horizon receipt is retained unchanged; direct Hawking radiation and temperature remain unmeasured standing tests.", "Hawking non-observation is explicitly not counted as confirmation of the formal mT=1/16 prediction.", "Reversed-order, collapsed-upper and erased-condition hostile controls all reject."]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (HorizonObservationRecords.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.HorizonObservationValidation
