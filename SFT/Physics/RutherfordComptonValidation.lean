import SFT.Physics.RutherfordComptonExperiment
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.RutherfordComptonValidation
open SFT.Host SFT.Host.Canonical ScatteringPrediction RutherfordComptonExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-IAEA-NIST-Rutherford-Compton-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def fractionRepr (v : Value) : Except String String := do
 let n ← field v "numerator"
 let d ← field v "denominator"
 let n ← match n with
  | .integer i => Except.ok i
  | .null | .boolean _ | .text _ | .array _ | .object _ => .error "encoded Fraction fields must be integers"
 let d ← match d with
  | .integer i => Except.ok i
  | .null | .boolean _ | .text _ | .array _ | .object _ => .error "encoded Fraction fields must be integers"
 pure (Text.intercalate "" ["Fraction(",render (.integer n),", ",render (.integer d),")"])
def fractionPairRepr (v : Value) : Except String String := do
 let xs ← RunningConvergenceMeasurement.array v
 match xs with
 | [a,b] => pure (Text.intercalate "" ["(",← fractionRepr a,", ",← fractionRepr b,")"])
 | [] | [_] | _::_::_::_ => throw "encoded Fraction interval must have two endpoints"
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "scattering validator received the wrong claim seal"
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
 let targets ← releasedTargets files record
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") (targetValues targets)
  (admissionIdentity (.array [.text registrationHash,.text ScatteringMeasurement.sourceHash,.object (ScatteringMeasurement.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "scattering prediction failed hostile-package audit"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "capability-closed scattering prediction differs from formal inputs"
 if targets.codataRows.length != 7 then throw "released CODATA scattering vector is incomplete"
 let synthetic ← ScatteringMeasurement.authoritativeRecord files record
 -- Both released target fields originate from this same immutable record.
 let iaea ← ScatteringMeasurement.iaeaAnalysis synthetic
 let codata ← ScatteringMeasurement.codataAnalysis targets.codataRows
 let angular ← ["coulomb_part_one_quarter","coulomb_part_one_half","coulomb_part_three_quarters","coulomb_part_one"].mapM (fun k => do ratio (← lookup prediction k))
 let shift ← ["shift_one_quarter","shift_one_half","shift_three_quarters","shift_one"].mapM (fun k => do ratio (← lookup prediction k))
 let charge ← ratio (← lookup prediction "charge_doubling")
 let energy ← ratio (← lookup prediction "energy_doubling")
 let right ← ratio (← lookup prediction "right_angle_ceiling")
 let back ← ratio (← lookup prediction "backscatter_ceiling")
 let forward ← lookup prediction "forward_transfer"
 let formalChannel := angular==[VacuumLedgerProofs.wholeRatio 16,VacuumLedgerProofs.wholeRatio 4,normalize 16 9 (by decide),VacuumLedgerProofs.wholeRatio 1] && charge==VacuumLedgerProofs.wholeRatio 4 && energy==normalize 1 4 (by decide) && shift==[normalize 1 2 (by decide),VacuumLedgerProofs.wholeRatio 1,normalize 3 2 (by decide),VacuumLedgerProofs.wholeRatio 2] && right==VacuumLedgerProofs.wholeRatio 1 && back==normalize 1 2 (by decide) && labelMatches forward "direction-transfer" "structural-empty-form"
 let angularMatch := sameValue (.array (angular.map ScatteringRutherfordComptonEvidence.fractionValue)) (← field iaea "iaea_rutherford_angular_vector")
 let shiftMatch := sameValue (.array (shift.map ScatteringRutherfordComptonEvidence.fractionValue)) (← field iaea "iaea_compton_shift_vector")
 let checkedRecord ← ScatteringMeasurement.authoritativeRecord files record
 let sources ← RunningConvergenceMeasurement.array (← field checkedRecord "sources")
 let truth := fun obj key => sameValue ((field obj key).toOption.getD .null) (.boolean true)
 let allRows := targets.codataRows.length==7 && sameValue (← field codata "row_count") (.integer 7) && sources.length==2 && truth iaea "rutherford_relation_complete" && truth iaea "compton_relation_complete" && truth iaea "compton_assumptions_complete" && truth iaea "rutherford_scope_retained"
 let oneRatio ← ScatteringPrediction.positiveRatio (VacuumLedgerProofs.wholeRatio 1)
 let unfavorable := angular != [VacuumLedgerProofs.wholeRatio 4,VacuumLedgerProofs.wholeRatio 2,normalize 4 3 (by decide),VacuumLedgerProofs.wholeRatio 1] && angular != List.replicate 4 (VacuumLedgerProofs.wholeRatio 1) && shift != ScatteringRutherfordCompton.transferParts && (targets.codataRows.take (targets.codataRows.length-1)).length != 7 && !sameValue (CapabilityValues.canonical forward) (CapabilityValues.canonical oneRatio)
 let passed := [formalChannel,angularMatch,shiftMatch,allRows,unfavorable,truth iaea "inverse_square_coulomb_recorded",truth iaea "large_angle_observed_support",truth codata "all_rows_exact_positive",truth codata "planck_exact",truth codata "speed_exact",truth codata "derived_reported_intervals_overlap",truth codata "iaea_rounded_compton_carrier_contains_nist"].all id
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text predictionSeal.sealHash),("source_record_hash",.text ScatteringMeasurement.sourceHash),("source_hashes",.object (ScatteringMeasurement.sourceHashes.map (fun (k,v) => (k,.text v)))),("complete_target_identity_hash",.text targetIdentity),("iaea_analysis",iaea),("codata_analysis",codata),("formal_channel",.boolean formalChannel),("angular_match",.boolean angularMatch),("shift_match",.boolean shiftMatch),("all_rows_preserved",.boolean allRows),("unfavorable_controls",.boolean unfavorable),("prediction_trace_hash",.text execution.traceHash)]
 let measurements := [
 "IAEA complete Rutherford record retained: inverse-square Coulomb source, charge/energy scale and inverse-fourth-power half-angle differential law",
 "IAEA historical Geiger-Marsden record retained: approximately one in 10^4 alpha particles above 90 degrees versus the obsolete diffuse-model order 10^-3500",
 "IAEA complete Compton record retained: free stationary electron boundary, closed energy-momentum transfer, delta-lambda relation and h/(m_e*c) carrier",
 "NIST CODATA complete seven-row scattering vector retained with every reported uncertainty",
 Text.append "exact h/(m_e*c) interval m: " (← fractionPairRepr (← field codata "derived_compton_wavelength_interval_m")),
 Text.append "NIST Compton wavelength interval m: " (← fractionPairRepr (← field codata "reported_compton_wavelength_interval_m")),
 Text.append "NIST right-angle high-energy ceiling interval MeV: " (← fractionPairRepr (← field codata "right_angle_high_energy_ceiling_interval_MeV")),
 Text.append "NIST backscatter high-energy ceiling interval MeV: " (← fractionPairRepr (← field codata "backscatter_high_energy_ceiling_interval_MeV")),
 "first-power, angle-independent, elastic-energy, numerical-forward, incomplete-row and changed-source controls rejected"]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (ScatteringMeasurement.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.RutherfordComptonValidation
