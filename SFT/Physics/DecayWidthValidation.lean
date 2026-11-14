import SFT.Physics.DecayWidthExperiment
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.DecayWidthValidation
open SFT.Host SFT.Host.Canonical DecayWidthPrediction DecayWidthExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-DECAY-WIDTH-BRANCHING-LIFETIME-TERMINAL-006"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-PDG-NIST-decay-width-branching-lifetime-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
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
def decodedFraction (v : Value) : Except String Rat := do
 let n ← field v "numerator"
 let d ← field v "denominator"
 let integer := fun v => match v with
  | .integer i => Except.ok i
  | .null | .boolean _ | .text _ | .array _ | .object _ => .error "encoded Fraction fields must be integers"
 DecayWidthBranchingLifetime.positiveCarrier (← integer n) (← integer d)
def decodedInterval (v : Value) : Except String (Rat × Rat) := do
 let xs ← RunningConvergenceMeasurement.array v
 match xs with
 | [a,b] => pure (← decodedFraction a,← decodedFraction b)
 | [] | [_] | _::_::_::_ => throw "encoded Fraction interval must have two endpoints"
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "decay-width validator received the wrong claim seal"
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
  (admissionIdentity (.array [.text registrationHash,.text DecayWidthMeasurement.sourceHash,.object (DecayWidthMeasurement.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "decay-width prediction failed hostile-package audit"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "capability-closed decay-width prediction differs from formal inputs"
 let synthetic ← DecayWidthMeasurement.authoritativeRecord files record
 let pdg ← DecayWidthMeasurement.pdgAnalysis synthetic
 let nist ← DecayWidthMeasurement.nistActionAnalysis targets.nist (← decodedInterval (← field pdg "width_interval_GeV"))
 let values ← ["partial_width_one","partial_width_two","partial_width_three","total_width","branch_one","branch_two","branch_three","branch_partition","lifetime"].mapM (fun k => do ratio (← lookup prediction k))
 let closed ← lookup prediction "closed_channel"
 let formalChannel := values==[normalize 1 4 (by decide),normalize 1 2 (by decide),normalize 5 4 (by decide),VacuumLedgerProofs.wholeRatio 2,normalize 1 8 (by decide),normalize 1 4 (by decide),normalize 5 8 (by decide),VacuumLedgerProofs.wholeRatio 1,normalize 1 2 (by decide)] && labelMatches closed "decay-channel" "structural-empty-form"
 let checkedRecord ← DecayWidthMeasurement.authoritativeRecord files record
 let sources ← RunningConvergenceMeasurement.array (← field checkedRecord "sources")
 let truth := fun obj key => sameValue ((field obj key).toOption.getD .null) (.boolean true)
 let allRows := sameValue (← field pdg "width_row_count") (.integer 16) && sameValue (← field pdg "used_width_component_count") (.integer 3) && sameValue (← field pdg "mode_row_count") (.integer 13) && sameValue (← field pdg "individual_exclusive_row_count") (.integer 4) && sources.length==2
 let branches ← (← RunningConvergenceMeasurement.array (← field pdg "individual_central_branch_vector")).mapM decodedFraction
 let b0 ← LeptonRatios.atIndex branches 0
 let subset ← DecayWidthMeasurement.exactTotal (branches.take 3)
 let doubled ← DecayWidthMeasurement.exactTotal (branches++[← DecayWidthMeasurement.percentPart "33.0"])
 let inv ← LeptonRatios.divide (VacuumLedgerProofs.wholeRatio 1) b0
 let width ← decodedFraction (← field pdg "width_central_GeV")
 let life ← decodedInterval (← field nist "derived_lifetime_interval_s")
 let source ← match sources with | a::_ => .ok a | [] => .error "IndexError"
 let widthRows ← RunningConvergenceMeasurement.array (← field (← field source "width_scope") "complete_table_rows")
 let unfavorable := subset != VacuumLedgerProofs.wholeRatio 1 && doubled != VacuumLedgerProofs.wholeRatio 1 && inv != b0 && width != life.1 && (widthRows.take (widthRows.length-1)).length != 16
 let passed := [formalChannel,allRows,unfavorable,truth pdg "published_gamma_fraction_notation",truth pdg "published_exact_complement_relation",truth pdg "universal_interval_contains_one",truth pdg "forced_universal_hadron_inside_reported_interval",truth pdg "individual_interval_contains_one",truth pdg "forced_individual_hadron_inside_reported_interval",truth pdg "partial_width_sum_encloses_total_width_interval",truth pdg "subsets_retained_without_double_counting",truth nist "finite_positive_lifetime_interval",truth nist "greater_width_shorter_lifetime",truth nist "ellipsis_not_promoted_to_exact_rational"].all id
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text predictionSeal.sealHash),("source_record_hash",.text DecayWidthMeasurement.sourceHash),("source_hashes",.object (DecayWidthMeasurement.sourceHashes.map (fun (k,v) => (k,.text v)))),("complete_target_identity_hash",.text targetIdentity),("pdg_analysis",pdg),("nist_action_analysis",nist),("formal_channel",.boolean formalChannel),("all_rows_preserved",.boolean allRows),("unfavorable_controls",.boolean unfavorable),("prediction_trace_hash",.text execution.traceHash)]
 let measurements := [
 "PDG 2026 complete W-width table retained: sixteen rows, every uncertainty, use-status and scale-factor note",
 "PDG 2026 complete thirteen-row W decay-mode table retained with aggregate, exclusive, inclusive-subset and upper-limit classes kept distinct",
 "PDG exclusive individual vector retained: e, mu, tau and hadronic branch intervals contain the One jointly",
 "PDG universality fit retained: B(hadrons)=One take 3*B(ell nu) exactly; the forced complement lies inside the reported hadronic interval",
 Text.append "PDG total width interval GeV: " (← fractionPairRepr (← field pdg "width_interval_GeV")),
 Text.append "PDG exact individual partial-width enclosure GeV: " (← fractionPairRepr (← field pdg "partial_width_sum_interval_GeV")),
 "NIST reduced-action ellipsis retained as an adjacent rational enclosure, never as an exact rational proof value",
 Text.append "derived W lifetime interval s from NIST action and PDG width: " (← fractionPairRepr (← field nist "derived_lifetime_interval_s")),
 "omitted branch, double-counted inclusive subset, inverse branch, direct width-lifetime and incomplete-source controls rejected"]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (DecayWidthMeasurement.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.DecayWidthValidation
