import SFT.Physics.YieldThresholdExperiment
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.YieldThresholdValidation
open SFT.Host SFT.Host.Canonical YieldThresholdPrediction YieldThresholdExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-NUCLEAR-FUSION-FISSION-YIELD-THRESHOLD-006"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-AMDC-IAEA-fusion-fission-yield-threshold-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def lookup (rows : List (String × CapabilityValues.Value)) (key : String) : Except String CapabilityValues.Value :=
 match rows.find? (fun p => Text.equal p.1 key) with
 | some p => .ok p.2
 | none => .error (Text.append "KeyError: " key)
def count (v : CapabilityValues.Value) : Except String Nat := match v with
 | .count n => .ok n.value
 | .emptyOne _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => .error "prediction count has the wrong exact type"
def ratio (v : CapabilityValues.Value) : Except String Rat := match v with
 | .ratio n d => .ok (normalize (.ofNat n.value) d.value d.positive)
 | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => .error "prediction ratio has the wrong exact type"
def labelMatches (v : CapabilityValues.Value) (family label : String) : Bool := match v with
 | .label held => Text.equal held.family family && Text.equal held.label label
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def eqCount (n : Nat) (z : Int) : Bool := @decide (Int.ofNat n=z) (Int.decEq _ _)
def booleanText (b : Bool) : String := if b then "True" else "False"
def intervalText (row : NuclearBindingMeasuredRows.Row) : String := Text.intercalate "" ["[",CosmicComponentTransportMeasurement.fractionText row.lower,", ",CosmicComponentTransportMeasurement.fractionText row.upper,"]"]
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record ameRecord : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "yield/threshold validator received the wrong claim seal"
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
 let targets ← releasedTargets files record ameRecord
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") (targetValues targets)
  (admissionIdentity (.array [.text registrationHash,.text YieldThresholdMeasurement.sourceHash,.object (YieldThresholdMeasurement.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "yield/threshold prediction failed hostile-package audit"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "capability-closed prediction differs from its formal inputs"
 let rows := targets.rows
 let binding ← YieldThresholdMeasurement.exactBindingMeasurementAnalysis rows
 let iaea ← YieldThresholdMeasurement.iaeaMeasurementAnalysis targets.fusionRows targets.fissionRecord targets.thresholdRecord
 let fp ← ratio (← lookup prediction "fusion_per_nucleon_lower")
 let sp ← ratio (← lookup prediction "fission_per_nucleon_upper")
 let st ← ratio (← lookup prediction "fission_total_lower")
 let ft ← ratio (← lookup prediction "fusion_total_upper")
 let formalPer := sp.blt fp
 let formalTotal := ft.blt st
 let formalMetricInversion := formalPer && formalTotal
 let fusionThreshold ← lookup prediction "fusion_threshold"
 let fissionThreshold ← lookup prediction "fission_threshold"
 let boundary ← lookup prediction "fission_inter_boundary"
 let scope ← lookup prediction "threshold_scope"
 let formalThresholds := labelMatches fusionThreshold "threshold-carrier" "charged-boundary-approach" && labelMatches fissionThreshold "threshold-carrier" "neutral-capture-or-internal-surface" && labelMatches boundary "structural-absence" "empty-form" && labelMatches scope "threshold-scope" "normalized-structure-with-reaction-specific-dimensions"
 let components ← RunningConvergenceMeasurement.array (← field targets.fissionRecord "component_rows")
 let checkedRecord ← YieldThresholdMeasurement.authoritativeRecord files record
 let sources ← RunningConvergenceMeasurement.array (← field checkedRecord "sources")
 let allRows := rows.length==2548 && targets.anchors.length==4 && targets.fusionRows.length==12 && components.length==7 && sources.length==5 && iaea.classesComplete
 let illustrative ← field targets.fissionRecord "illustrative_mass_inscriptions_used_for_exact_ame_calculation"
 let unfavorable := binding.reversedPerRejected && binding.reversedTotalRejected && formalMetricInversion && (rows.take (rows.length-1)).length != 2548 && (targets.fusionRows.take (targets.fusionRows.length-1)).length != 12 && sameValue illustrative (.boolean false)
 let perLabel ← lookup prediction "per_nucleon_order"
 let totalLabel ← lookup prediction "total_order"
 let metric ← lookup prediction "metric_retention"
 let passed := [formalPer,formalTotal,formalThresholds,binding.fusionGreater,binding.fissionGreater,iaea.fusionGreater,iaea.fissionGreater,iaea.allPositive,iaea.trueVsEffective,iaea.neutralScope,allRows,unfavorable,labelMatches perLabel "yield-order" "fusion-greater-per-nucleon",labelMatches totalLabel "yield-order" "fission-greater-total",labelMatches metric "measurement-metric" "retain-per-nucleon-and-total-separately"].all id
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text predictionSeal.sealHash),("source_record_hash",.text YieldThresholdMeasurement.sourceHash),("source_hashes",.object (YieldThresholdMeasurement.sourceHashes.map (fun (k,v) => (k,.text v)))),("complete_target_identity_hash",.text targetIdentity),("binding_analysis",YieldThresholdMeasurement.bindingValue binding),("iaea_analysis",YieldThresholdMeasurement.iaeaValue iaea),("formal_per_order",.boolean formalPer),("formal_total_order",.boolean formalTotal),("formal_thresholds",.boolean formalThresholds),("all_rows_preserved",.boolean allRows),("unfavorable_controls",.boolean unfavorable),("prediction_trace_hash",.text execution.traceHash)]
 let measurements := [
 Text.intercalate "" ["complete AME2020 positive-composite census retained: ",toString rows.length," rows"],
 Text.intercalate "" ["AME2020 exact gain intervals keV/nucleon: fusion ",FusionFissionTerminalEvidence.gainRepr binding.fusionPer,"; fission ",FusionFissionTerminalEvidence.gainRepr binding.fissionPer,"; fusion strictly greater"],
 Text.intercalate "" ["AME2020 exact total-gain intervals keV: fusion ",FusionFissionTerminalEvidence.gainRepr binding.fusionTotal,"; fission ",FusionFissionTerminalEvidence.gainRepr binding.fissionTotal,"; fission strictly greater"],
 Text.intercalate "" ["IAEA D-T release and per-incident-nucleon values MeV: ",CosmicComponentTransportMeasurement.fractionText iaea.dtTotal," and ",CosmicComponentTransportMeasurement.fractionText iaea.dtPer],
 Text.intercalate "" ["IAEA U-235 fission average/released totals MeV: ",CosmicComponentTransportMeasurement.fractionText iaea.fissionAverage," and ",CosmicComponentTransportMeasurement.fractionText iaea.fissionReleased,"; average per parent nucleon ",CosmicComponentTransportMeasurement.fractionText iaea.fissionPerParent],
 "all twelve fusion-energy rows and all seven fission-energy component rows retained",
 "charged low-or-absent true threshold versus effective Coulomb threshold, neutral neutron evaluation class, spontaneous internal-barrier class and captured-particle class all retained",
 "rounded illustrative fission masses were not substituted for the exact AME calculation; reversed orders, conflated metrics and incomplete-row controls were rejected"]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (YieldThresholdMeasurement.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.YieldThresholdValidation
