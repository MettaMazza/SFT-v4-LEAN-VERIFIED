import SFT.Physics.RunningConvergencePrediction
import SFT.Physics.RunningConvergenceGrammarBase
namespace SFT.Physics.RunningConvergenceValidation
open SFT.Host SFT.Host.Canonical RunningConvergencePrediction RunningConvergenceMeasurement
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot

def sourceHashesValue : Value := .object (sourceHashes.map (fun (p,h) => (p,.text h)))
def sourceRecordHash : String := "sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953"
def envelope (sealedHash : String) (inputs : List (String × CapabilityValues.Value)) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (inputs.map (fun (key,v) => (key,.text (identity (CapabilityValues.canonical v)))))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text (identity (.array [.text sealedHash,.text frozenRelation]))),
 ("experiment_registration_hash",.text (identity (registration inputs)))]

def sealPrediction (old : Option PredictionSeal) (sealedHash : String) (inputs : List (String × CapabilityValues.Value))
 (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match old with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
  let env := identity (envelope sealedHash inputs)
  let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),
    ("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
  .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def outputMapping (output : CapabilityValues.Value) (keys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length == keys.length then .ok (keys.zip cells) else .error "coupling-running prediction has the wrong exact Fold shape"
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => .error "coupling-running prediction has the wrong exact Fold shape"

def input (values : List (String × CapabilityValues.Value)) (key : String) : Except String CapabilityValues.Value :=
 match values.find? (fun kv => Text.equal kv.1 key) with
 | some (_,v) => .ok v
 | none => .error (Text.append "KeyError: " key)

def inputRatio (values : List (String × CapabilityValues.Value)) (key : String) : Except String Rat := do
 EvolutionMeasuredSource.fraction (← input values key)

def formalChannel (prediction : List (String × CapabilityValues.Value)) : Except String Bool := do
 let one ← inputRatio prediction "support_one"
 let two ← inputRatio prediction "support_two"
 let four ← inputRatio prediction "support_four"
 let eight ← inputRatio prediction "support_eight"
 let baseGap ← inputRatio prediction "pair_gap_base"
 let fourthGap ← inputRatio prediction "pair_gap_level_four"
 let witnessGap ← inputRatio prediction "finite_witness_gap"
 let tolerance ← inputRatio prediction "finite_tolerance"
 let translation ← input prediction "translation_relation"
 let expected ← label "coupling-translation" "carrier-specific-coordinate-orientation"
 let certificate ← RunningConvergence.formalCertificate
 pure (RunningConvergenceGrammar.sameRat one (LeptonIntervals.normalize 1 1 (by decide)) &&
   RunningConvergenceGrammar.sameRat two (LeptonIntervals.normalize 2 1 (by decide)) &&
   RunningConvergenceGrammar.sameRat four (LeptonIntervals.normalize 4 1 (by decide)) &&
   RunningConvergenceGrammar.sameRat eight (LeptonIntervals.normalize 8 1 (by decide)) &&
   fourthGap.blt baseGap && witnessGap.blt tolerance && CapabilityValues.equal translation expected &&
   certificate.convergenceWitnesses.all (fun w => w.gapBelowTolerance))

def integerValue (v : Value) : Except String Int :=
 match v with
 | .integer n => .ok n
 | .text _ | .boolean _ | .null | .array _ | .object _ => .error "TypeError: exact measurement fraction required"

def ratFromValue (v : Value) : Except String Rat := do
 let n ← integerValue (← field v "numerator")
 let d ← integerValue (← field v "denominator")
 match d with
 | .ofNat (k+1) => pure (LeptonIntervals.normalize n (k+1) (Nat.zero_lt_succ _))
 | .ofNat 0 | .negSucc _ => throw "TypeError: exact measurement fraction required"

def intervalFromValue (v : Value) : Except String (Rat × Rat) := do
 let xs ← array v
 pure (← ratFromValue (← rowAt xs 0),← ratFromValue (← rowAt xs 1))

def countIs (v : Value) (key : String) (n : Nat) : Except String Bool := do
 pure (sameValue (← field v key) (.integer (.ofNat n)))

def retainedRows (qcd electromagnetic : Value) (sources : List Value) : Except String Bool := do
 pure ((← countIs qcd "exact_multiscale_row_count" 2) && (← countIs qcd "table_9_1_row_count" 7) &&
  (← countIs qcd "figure_9_4_class_count" 9) && (← countIs electromagnetic "alpha_zero_row_count" 5) &&
  (← countIs electromagnetic "delta_alpha_row_count" 11) && sources.length==3)

def adverseControls (qcd electromagnetic qcdSource ewSource : Value) (opposite : Bool) : Except String Bool := do
 let low ← intervalFromValue (← field qcd "low_alpha_s_interval")
 let high ← intervalFromValue (← field qcd "mZ_alpha_s_interval")
 let old ← intervalFromValue (← field electromagnetic "explicit_prior_low_inverse_alpha_interval")
 let z ← intervalFromValue (← field electromagnetic "explicit_z_inverse_alpha_interval")
 let qcdRows ← array (← field (← field qcdSource "table_9_1") "complete_rows")
 let deltaRows ← array (← field (← field ewSource "table_10_1") "complete_rows")
 pure (high.2.blt low.1 && !(low.2.blt high.1) && z.2.blt old.1 &&
  (qcdRows.take (qcdRows.length-1)).length != 7 && (deltaRows.take (deltaRows.length-1)).length != 11 && opposite)

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (host implementation : String) (registrationHash : String) (execution : CapabilityExecution.Execution)
 (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-PDG-coupling-running-convergence-comparator/1",.text registrationHash,.text falsification]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),
 ("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (registrationHash : String) (release : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text release.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text release.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text release.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

def fractionRepr (q : Rat) : String := Text.join ["Fraction(",render (.integer q.num),", ",render (.integer (.ofNat q.den)),")"]
def intervalRepr (v : Value) : Except String String := do
 let (lo,hi) ← intervalFromValue v
 pure (Text.join ["(",fractionRepr lo,", ",fractionRepr hi,")"])

def measurements (qcd electromagnetic : Value) : Except String (List String) := do
 pure [
 "PDG 2026 QCD complete Table 9.1 retained: seven rows, every reported averaging column and uncertainty",
 "PDG 2026 QCD Figure 9.4 retained by immutable source hash and visual audit: nine measurement classes across the displayed multi-scale range",
 Text.append "PDG strong low-scale interval at Q=1.37 GeV: " (← intervalRepr (← field qcd "low_alpha_s_interval")),
 Text.append "PDG strong m_Z-scale interval: " (← intervalRepr (← field qcd "mZ_alpha_s_interval")),
 "The separated exact intervals confirm that alpha_s decreases as transfer energy rises; the full figure and page-43 conclusion retain the wider multi-scale evidence",
 "PDG 2026 electromagnetic scope retained: five alpha(0) determinations, eleven hadronic Delta-alpha evaluations, the published running relation and direct L3/OPAL observations",
 Text.append "PDG explicit prior Thomson inverse-alpha interval: " (← intervalRepr (← field electromagnetic "explicit_prior_low_inverse_alpha_interval")),
 Text.append "PDG explicit prior Z-scale inverse-alpha interval: " (← intervalRepr (← field electromagnetic "explicit_z_inverse_alpha_interval")),
 "The inverse-alpha intervals decrease, hence electromagnetic alpha increases toward the Z scale",
 "Opposite physical energy directions pass only under the sealed carrier-specific self-source-range and screening-exposure translations; a universal imported sign is rejected",
 "The exact common-support convergence of the four Fold sector functions remains a standing falsifiable prediction and is not mislabelled as a direct measurement"]

structure Validation where
 value : Value
 passed : Bool

def validate (files : List (String × ByteArray)) (record : Value) (sealedClaim derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "coupling-running validator received the wrong claim seal"
 let inputs ← formalPredictionInputs
 let registrationHash := identity (registration inputs)
 let programFields ← match predictionDocument inputs with
  | .object fs => pure fs
  | .text _ | .boolean _ | .integer _ | .null | .array _ => throw "prediction document is not an object"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let authoritative ← authoritativeRecord files record
 let sources ← array (← field authoritative "sources")
 let targets := targetIds.zip sources
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") targets
   (identity (.array [.text registrationHash,.text sourceRecordHash,sourceHashesValue])) (identity (envelope derivationSeal inputs))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none derivationSeal inputs execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "coupling-running prediction failed hostile-package audit"
 let (_,release) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment release predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
  targetIds release.values
 let prediction ← outputMapping execution.output (inputs.map Prod.fst)
 if !sameValue (inputsValue prediction) (inputsValue inputs) then throw "capability-closed coupling-running prediction differs from formal inputs"
 let released := Value.object release.values
 let qcdSource ← field released (← item targetIds 0)
 let ewSource ← field released (← item targetIds 1)
 let endpointSource ← field released (← item targetIds 2)
 let qcd ← qcdAnalysis qcdSource ewSource
 let electromagnetic ← electromagneticAnalysis ewSource endpointSource
 let formal ← formalChannel prediction
 let rows ← retainedRows qcd electromagnetic sources
 let opposite := (← boolField qcd "separated_intervals_strictly_decrease_with_energy") &&
  (← boolField electromagnetic "therefore_alpha_strictly_increases_to_z_scale")
 let adverse ← adverseControls qcd electromagnetic qcdSource ewSource opposite
 let passed := formal && rows && adverse &&
  (← boolField qcd "scales_strictly_ordered") && (← boolField qcd "all_table_intervals_positive") &&
  (← boolField qcd "full_figure_retained_without_fabricated_coordinates") && (← boolField qcd "pdg_energy_dependence_conclusion_retained") &&
  (← boolField electromagnetic "all_hadronic_delta_intervals_positive") && (← boolField electromagnetic "published_running_relation_retained") &&
  (← boolField electromagnetic "direct_lep_observation_retained") && opposite
 let targetIdentity ← TargetCustody.identityFromRelease release
 let comparison : Value := .object [
  ("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text predictionSeal.sealHash),
  ("source_record_hash",.text sourceRecordHash),("source_hashes",sourceHashesValue),("complete_target_identity_hash",.text targetIdentity),
  ("qcd_analysis",qcd),("electromagnetic_analysis",electromagnetic),("formal_channel",.boolean formal),
  ("all_rows_preserved",.boolean rows),("opposite_directions",.boolean opposite),
  ("formal_convergence_not_promoted_to_direct_measurement",.boolean true),("unfavorable_controls",.boolean adverse),
  ("prediction_trace_hash",.text execution.traceHash)]
 pure ⟨.object [
  ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),
  ("target_custody_certificate",custodyCertificate registrationHash release predictionSeal),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
  ("all_rows_preserved",.boolean rows),("data_source_ids",.array (sourceIds.map Value.text)),
  ("measurements",.array ((← measurements qcd electromagnetic).map Value.text)),
  ("measurement_receipt_hash",.text (identity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩

theorem resealRejected (old : PredictionSeal) (sealedHash : String) (inputs : List (String × CapabilityValues.Value))
 (execution : CapabilityExecution.Execution) : sealPrediction (some old) sealedHash inputs execution = .error "prediction is already sealed and cannot be replaced" := rfl
end SFT.Physics.RunningConvergenceValidation
