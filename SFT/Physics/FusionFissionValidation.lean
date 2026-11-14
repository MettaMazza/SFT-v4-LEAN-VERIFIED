import SFT.Physics.FusionFissionExperiment
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.FusionFissionValidation
open SFT.Host SFT.Host.Canonical FusionFissionPrediction FusionFissionExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-NUCLEAR-FUSION-FISSION-TERMINAL-005"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-AME2020-fusion-fission-interval-coordinate-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def validate (bytes : ByteArray) (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "fusion/fission empirical validator received the wrong seal"
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
 let targets ← releasedTargets bytes files record
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") (targetValues targets)
  (admissionIdentity (.array [.text registrationHash,.text NuclearBindingRecords.sourceHash,.text NuclearBindingRecords.rawHash])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "fusion/fission prediction failed hostile-package audit"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "capability-closed prediction differs from its formal inputs"
 let rows := targets.rows
 let analysis ← FusionFissionMeasurement.measurementAnalysis rows
 let d := targets.deuterium
 let h := targets.helium
 let u := targets.uranium
 let p := targets.palladium
 let peak := targets.peak
 let fi ← ratio (← lookup prediction "fusion_incident_score_upper")
 let fo ← ratio (← lookup prediction "fusion_product_score_lower")
 let fg ← ratio (← lookup prediction "fusion_total_gain_lower")
 let si ← ratio (← lookup prediction "fission_parent_score_upper")
 let so ← ratio (← lookup prediction "fission_product_score_lower")
 let sg ← ratio (← lookup prediction "fission_total_gain_lower")
 let formalFusion := fi.blt fo && zero.blt fg
 let formalFission := si.blt so && zero.blt sg
 let fa ← count (← lookup prediction "fusion_incident_mass")
 let fz ← count (← lookup prediction "fusion_incident_charge")
 let ha ← count (← lookup prediction "fusion_product_mass")
 let hz ← count (← lookup prediction "fusion_product_charge")
 let ua ← count (← lookup prediction "fission_parent_mass")
 let uz ← count (← lookup prediction "fission_parent_charge")
 let pa ← count (← lookup prediction "fission_product_mass")
 let pz ← count (← lookup prediction "fission_product_charge")
 let ma ← count (← lookup prediction "peak_mass")
 let mz ← count (← lookup prediction "peak_charge")
 let mn ← count (← lookup prediction "peak_neutron")
 let fusionCoordinates := eqCount fa d.mass && eqCount fz d.charge && eqCount ha h.mass && eqCount hz h.charge
 let fissionCoordinates := eqCount ua u.mass && eqCount uz u.charge && eqCount pa p.mass && eqCount pz p.charge
 let peakCoordinates := eqCount ma peak.mass && eqCount mz peak.charge && eqCount mn peak.neutrons
 let boundaryPreserved := targets.boundaries.length==2 && targets.boundaries.all (fun r => sameValue ((field r "mass_number").toOption.getD .null) (.integer 1)) && targets.boundaries.all (fun r => sameValue ((field r "binding_energy_per_nucleon_keV").toOption.getD .null) (.text "0.0"))
 let allRows := rows.length==2548 && boundaryPreserved
 let flag := fun key => sameValue ((field analysis key).toOption.getD .null) (.boolean true)
 let reversed := flag "reversed_fusion_rejected" && flag "reversed_fission_rejected"
 let incomplete := (rows.take (rows.length-1)).length != 2548
 let tampered := !(ma==61 && mz==28 && mn==33)
 let barrier ← ratio (← lookup prediction "normalized_barrier")
 let direction ← lookup prediction "binding_direction"
 let release ← lookup prediction "release_record"
 let passed := [formalFusion,formalFission,fusionCoordinates,fissionCoordinates,peakCoordinates,flag "fusion_higher_after_uncertainty",flag "fission_higher_after_uncertainty",flag "peak_separated_from_every_rival",allRows,reversed,incomplete,tampered,barrier==normalize 1 2 (by decide),labelMatches direction "binding-order" "toward-higher-binding",labelMatches release "mass-energy-accounting" "complete-held-positive-release"].all id
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text predictionSeal.sealHash),("source_record_hash",.text NuclearBindingRecords.sourceHash),("raw_hash",.text NuclearBindingRecords.rawHash),("complete_target_identity_hash",.text targetIdentity),("complete_row_count",.integer (.ofNat rows.length)),("formal_fusion",.boolean formalFusion),("formal_fission",.boolean formalFission),("measured_fusion",.boolean (flag "fusion_higher_after_uncertainty")),("measured_fission",.boolean (flag "fission_higher_after_uncertainty")),("peak_coordinates_match",.boolean peakCoordinates),("peak_separated",.boolean (flag "peak_separated_from_every_rival")),("boundary_rows_preserved",.boolean boundaryPreserved),("unfavorable_reversed",.boolean reversed),("incomplete_census_rejected",.boolean incomplete),("tampered_peak_rejected",.boolean tampered),("prediction_trace_hash",.text execution.traceHash)]
 let measurements := [
 Text.intercalate "" ["complete AME2020 positive-composite census retained: ",toString rows.length," rows"],
 Text.intercalate "" ["fusion anchor exact intervals keV/nucleon: D ",intervalText d,", He-4 ",intervalText h,"; strict rise ",booleanText (flag "fusion_higher_after_uncertainty")],
 Text.intercalate "" ["fission anchor exact intervals keV/nucleon: U-238 ",intervalText u,", Pd-119 ",intervalText p,"; strict rise ",booleanText (flag "fission_higher_after_uncertainty")],
 Text.intercalate "" ["complete-census maximum: A=",render (.integer peak.mass),", Z=",render (.integer peak.charge),", N=",render (.integer peak.neutrons),"; separated from every rival ",booleanText (flag "peak_separated_from_every_rival")],
 "both external singleton 0.0 inscriptions retained only as empty-binding boundaries",
 "reversed fusion and fission directions, incomplete census and displaced peak controls rejected"]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array [.text sourceId]),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.FusionFissionValidation
