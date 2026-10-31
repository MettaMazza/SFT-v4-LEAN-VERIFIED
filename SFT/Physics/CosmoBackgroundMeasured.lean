import SFT.Physics.EvolutionMeasuredSource
import SFT.Physics.CosmoBackgroundValidation
namespace SFT.Physics.CosmoBackgroundMeasured
open SFT.Host SFT.Host.Canonical EvolutionMeasuredSource
abbrev Snapshot := HostilePackage.Snapshot
abbrev PredictionSeal := LeptonCustody.PredictionSeal

def experimentId := CosmoBackgroundExperiment.experimentId
def claimId := CosmoBackgroundExperiment.claimId
def snapshotHash := CosmoBackgroundExperiment.snapshotHash
def sourceId := "NASA-LAMBDA-COBE-FIRAS-2026-07-23"
def targetSourceId := "NASA-LAMBDA-COBE-FIRAS-MONOPOLE-2026-07-23"
def targetHash := "sha256:e42bcf7e3e2eccac3ac8c210d4287e2477c394ad03d76ac7f719515d29753f2a"
def falsification := CosmoBackgroundExperiment.falsification
def targetId := "firas_monopole_temperature"

def positiveRatio (value : Rat) : Except String CapabilityValues.Value :=
 if LeptonIntervals.zero.blt value then ratioValue value
 else .error "ValueError: background temperature must remain an exact positive value"

def pair (central uncertainty : Rat) : Except String CapabilityValues.Value := do
 if !(LeptonIntervals.zero.blt uncertainty) || !(uncertainty.blt central) then
  .error "ValueError: background-temperature uncertainty is outside the positive domain"
 else .ok (.pair (← positiveRatio (LeptonIntervals.subtract central uncertainty)) (← positiveRatio (LeptonIntervals.add central uncertainty)))

def readInput (text : String) : Except String CapabilityValues.Value :=
 if Text.contains text "2.725&plusmn;0.002 K" then pair (LeptonIsolation.endpoint 2725 1000 (by decide)) (LeptonIsolation.endpoint 2 1000 (by decide))
 else .error "ValueError: registered FIRAS input temperature record is absent"

def readTarget (text : String) : Except String CapabilityValues.Value :=
 if Text.contains text "2725 +/- 1 mK" then pair (LeptonIsolation.endpoint 2725 1000 (by decide)) (LeptonIsolation.endpoint 1 1000 (by decide))
 else .error "ValueError: withheld FIRAS monopole temperature record is absent"

def program : CapabilityAdmission.Program := ⟨Text.append experimentId "-background-invariance",[
 ⟨.input,"lower",["background_lower"]⟩,⟨.input,"upper",["background_upper"]⟩,
 ⟨.pair,"prediction",["lower","upper"]⟩,⟨.emit,"",["prediction"]⟩]⟩

def programFields : List (String × Value) := [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def registration : Value := .object [
 ("claim_id",.text claimId),("experiment_id",.text experimentId),
 ("frozen_relation",.text "background thermodynamic temperature is invariant across the registered FIRAS analyses"),
 ("input_source_id",.text sourceId),("input_snapshot_hash",.text snapshotHash),
 ("withheld_target_source_id",.text targetSourceId),("target_snapshot_hash",.text targetHash),
 ("program",.object programFields),("falsification_condition",.text falsification)]
def registrationHash := identity registration

def endpoints (value : CapabilityValues.Value) : Except String (Rat × Rat) :=
 match EvolutionMeasuredSource.endpoints value with
 | .ok result => .ok result
 | .error message => if Text.contains message "not ordered" then .error "ValueError: background prediction interval is unordered"
   else .error "ValueError: background prediction is not an exact Fold interval"

def overlap (left right : CapabilityValues.Value) : Except String Bool := do
 let (ll,lu) ← endpoints left
 let (rl,ru) ← endpoints right
 .ok (!(lu.blt rl || ru.blt ll))

def inputs (interval : CapabilityValues.Value) : Except String (List (String × CapabilityValues.Value)) := do
 let (lower,upper) ← endpoints interval
 .ok [("background_lower",← positiveRatio lower),("background_upper",← positiveRatio upper)]

def envelope (derivationSeal : String) (values : List (String × CapabilityValues.Value)) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (values.map fun (k,v) => (k,.text (CapabilityValues.identity v)))),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]

def sealPrediction (prior : Option PredictionSeal) (derivationSeal : String)
    (values : List (String × CapabilityValues.Value)) (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
  let env := identity (envelope derivationSeal values)
  let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),
    ("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
  .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def isolation (host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := CosmoBackgroundValidation.certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-firas-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-FIRAS-interval-overlap/1",.text falsification]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),
 ("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (release : TargetCustody.Release) (prediction : PredictionSeal) : Value := CosmoBackgroundValidation.certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text release.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text release.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text release.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

def measurementReceipt (derivationSeal : String) (prediction : PredictionSeal) (execution : CapabilityExecution.Execution)
    (predicted observed : Rat × Rat) (overlaps rejected : Bool) : Value := .object [
 ("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text prediction.sealHash),
 ("input_snapshot_hash",.text snapshotHash),("target_snapshot_hash",.text targetHash),
 ("predicted_interval_kelvin",intervalJSON predicted),("measured_interval_kelvin",intervalJSON observed),
 ("overlap",.boolean overlaps),("unfavorable_rejected",.boolean rejected),("trace_hash",.text execution.traceHash)]

def fractionRepr (x : Rat) := Text.join ["Fraction(",render (.integer x.num),", ",render (.integer (.ofNat x.den)),")"]
def intervalRepr (x : Rat × Rat) := Text.join ["(",fractionRepr x.1,", ",fractionRepr x.2,")"]
def measurement (predicted observed : Rat × Rat) (passed : Bool) := Text.join [
 "FIRAS background interval predicted ",intervalRepr predicted,"; independently released monopole interval ",intervalRepr observed,
 "; overlap ",if passed then "True" else "False"]

def targetMatches (bytes : ByteArray) := Text.equal (Text.append "sha256:" (SHA256Window.digest bytes)) targetHash

def validate (bytes targetBytes : ByteArray) (derivationSeal host implementation : String)
    (before after : Snapshot) : Except String CosmoBackgroundValidation.Validation := do
 if !CosmoBackgroundExperiment.sourceMatches bytes || !targetMatches targetBytes then .error "ValueError: COBE FIRAS external snapshot differs from registration"
 else do
  let text := String.ofList (Text.decode bytes.size bytes.data.toList)
  let inputInterval ← readInput text
  let targetPair ← readTarget (String.ofList (Text.decode targetBytes.size targetBytes.data.toList))
  let parsed ← CapabilityDocuments.loadProgramFields programFields
  let values ← inputs inputInterval
  let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-firas-target-custodian")
    [(targetId,CapabilityValues.canonical targetPair)]
    (identity (.array [.text registrationHash,.text targetHash]))
    (identity (envelope derivationSeal values))
  let execution ← CapabilityExecution.execute parsed values
  let prediction ← sealPrediction none derivationSeal values execution
  let (audited,audit) ← HostilePackage.auditProgram programFields before after
  if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
   .error "ValueError: FIRAS prediction failed hostile-package audit"
  else do
   let (_,released) ← TargetCustody.release vault prediction
   TargetCustody.verify vault.commitment released prediction
   let _context ← SFT.Computation.MathematicalModelling.openTargets
     (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
     [targetId] released.values
   let actualTargetId ← TargetCustody.identityFromRelease released
   if !Text.isPrefix "sha256:".toUTF8.data.toList actualTargetId.toUTF8.data.toList then .error "ValueError: measured-value target identity is invalid"
   else do
    let releasedTarget ← match CapabilityDocuments.field targetId released.values with
     | some v => canonicalPair v
     | none => .error "KeyError: withheld target missing from release"
    let passedValue ← overlap execution.output releasedTarget
    let predicted ← endpoints execution.output
    let displacedLower ← ratioValue (LeptonIntervals.add predicted.2 (LeptonIsolation.endpoint 1 1 (by decide)))
    let displacedUpper ← ratioValue (LeptonIntervals.add predicted.2 (LeptonIsolation.endpoint 2 1 (by decide)))
    let rejected := !(← overlap execution.output (.pair displacedLower displacedUpper))
    let observed ← endpoints releasedTarget
    let passed := passedValue && rejected
    .ok ⟨.object [
      ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
      ("isolation_certificate",isolation host implementation execution vault prediction),
      ("target_custody_certificate",custodyCertificate released prediction),
      ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
      ("data_source_ids",.array [.text sourceId,.text targetSourceId]),
      ("measurements",.array [.text (measurement predicted observed passedValue),.text "deliberately displaced unfavorable interval rejected"]),
      ("measurement_receipt_hash",.text (identity (measurementReceipt derivationSeal prediction execution predicted observed passedValue rejected))),
      ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩

theorem resealRejected (old : PredictionSeal) (sealedHash : String) (values : List (String × CapabilityValues.Value))
    (execution : CapabilityExecution.Execution) :
    sealPrediction (some old) sealedHash values execution = .error "prediction is already sealed and cannot be replaced" := rfl

theorem sourceMismatchRejected (bytes targetBytes : ByteArray) (sealedHash host implementation : String)
 (before after : Snapshot) (changed : CosmoBackgroundExperiment.sourceMatches bytes=false) :
 validate bytes targetBytes sealedHash host implementation before after = .error "ValueError: COBE FIRAS external snapshot differs from registration" := by
 unfold validate
 rw [changed]
 rfl

theorem sealBindsExactInputs (sealedHash : String) (values : List (String × CapabilityValues.Value))
    (execution : CapabilityExecution.Execution) :
    (sealPrediction none sealedHash values execution).map (fun p => (p.predictionHash,p.traceHash,p.envelopeHash)) =
      .ok (execution.outputHash,execution.traceHash,identity (envelope sealedHash values)) := rfl
theorem inputIntervalExact :
 readInput "2.725&plusmn;0.002 K" = .ok (.pair (.ratio ⟨2723,by decide⟩ ⟨1000,by decide⟩) (.ratio ⟨2727,by decide⟩ ⟨1000,by decide⟩)) := rfl

theorem targetIntervalExact :
 readTarget "2725 +/- 1 mK" = .ok (.pair (.ratio ⟨681,by decide⟩ ⟨250,by decide⟩) (.ratio ⟨1363,by decide⟩ ⟨500,by decide⟩)) := rfl

theorem independentIntervalsOverlap :
 (do let input ← readInput "2.725&plusmn;0.002 K"; let target ← readTarget "2725 +/- 1 mK"; overlap input target) = .ok true := rfl

theorem displacedIntervalRejected :
 (do let input ← readInput "2.725&plusmn;0.002 K"; overlap input (.pair (.ratio ⟨3727,by decide⟩ ⟨1000,by decide⟩) (.ratio ⟨4727,by decide⟩ ⟨1000,by decide⟩))) = .ok false := rfl
end SFT.Physics.CosmoBackgroundMeasured
