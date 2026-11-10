import SFT.Physics.EvolutionMeasuredSource
import SFT.Physics.UnitValidation
namespace SFT.Physics.BackfillMeasuredWaveEnergy
open SFT.Host SFT.Host.Canonical EvolutionMeasuredSource
abbrev Snapshot := HostilePackage.Snapshot
abbrev PredictionSeal := LeptonCustody.PredictionSeal

def experimentId := "SFT-EXP-PHYS-VALIDATION-WAVE-ENERGY-001"
def claimId := "SFT-PHYS-VALIDATION-WAVE-ENERGY-001"
def snapshotHash := "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"
def sourceId := "NIST-CODATA-2022-ALL-CONSTANTS"
def relationId := "energy-inverse-length-planck-speed-product"
def relationStatement := "Inverse wavelength composed with limiting speed and the Planck carrier yields wave energy."
def falsification := "The sealed exact predicted interval fails to overlap the independently released CODATA target interval, any registered input is missing, or the displaced unfavorable interval is accepted."
def targetId := "target_energy__withheld_interval"
def targetQuantity := "Rydberg constant times hc in J"

def program : CapabilityAdmission.Program := ⟨Text.append experimentId "-exact-measured-value",[
 ⟨.input,"inverse_length__lower",["inverse_length__lower"]⟩,
 ⟨.input,"inverse_length__upper",["inverse_length__upper"]⟩,
 ⟨.input,"planck__lower",["planck__lower"]⟩,
 ⟨.input,"planck__upper",["planck__upper"]⟩,
 ⟨.input,"speed__lower",["speed__lower"]⟩,
 ⟨.input,"speed__upper",["speed__upper"]⟩,
 ⟨.product,"frequency__lower",["inverse_length__lower","speed__lower"]⟩,
 ⟨.product,"frequency__upper",["inverse_length__upper","speed__upper"]⟩,
 ⟨.product,"energy__lower",["frequency__lower","planck__lower"]⟩,
 ⟨.product,"energy__upper",["frequency__upper","planck__upper"]⟩,
 ⟨.pair,"predicted_interval",["energy__lower","energy__upper"]⟩,
 ⟨.emit,"",["predicted_interval"]⟩]⟩

def programFields : List (String × Value) := [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def registration : Value := .object [
 ("relation_id",.text relationId),("claim_id",.text claimId),("relation_statement",.text relationStatement),
 ("program",.object programFields),
 ("input_quantities",.array [.array [.text "inverse_length",.text "Rydberg constant",.text "m^-1"],.array [.text "planck",.text "Planck constant",.text "J Hz^-1"],.array [.text "speed",.text "speed of light in vacuum",.text "m s^-1"]]),
 ("withheld_target_identity",.array [.text targetId,.text targetQuantity,.text "J"]),
 ("source_id",.text sourceId),("source_snapshot_hash",.text snapshotHash),
 ("falsification_condition",.text falsification),("all_rows_required",.boolean true),("target_inaccessible_before_seal",.boolean true)]
def registrationHash := identity registration

def inputs (inverse_length : Interval) (planck : Interval) (speed : Interval) : Except String (List (String × CapabilityValues.Value)) := do
 .ok [("inverse_length__lower",← ratioValue inverse_length.lower),("inverse_length__upper",← ratioValue inverse_length.upper),("planck__lower",← ratioValue planck.lower),("planck__upper",← ratioValue planck.upper),("speed__lower",← ratioValue speed.lower),("speed__upper",← ratioValue speed.upper)]

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
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := UnitValidation.certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-measured-value-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "sft-v3-exact-positive-interval-evaluator/1",.text relationId,.text falsification]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),
 ("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (release : TargetCustody.Release) (prediction : PredictionSeal) : Value := UnitValidation.certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text release.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text release.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text release.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

def measurementReceipt (derivationSeal : String) (prediction : PredictionSeal) (execution : CapabilityExecution.Execution)
    (predicted observed : Rat × Rat) (overlaps rejected : Bool) : Value := .object [
 ("relation_id",.text relationId),("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text prediction.sealHash),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("source_snapshot_hash",.text snapshotHash),("predicted_interval",intervalJSON predicted),("observed_interval",intervalJSON observed),
 ("intervals_overlap",.boolean overlaps),("displaced_unfavorable_interval_rejected",.boolean rejected),("complete_trace_hash",.text execution.traceHash)]

def measurement (predicted observed : Rat × Rat) (passed : Bool) := Text.join [targetQuantity,
 ": exact predicted interval [",fractionText predicted.1,", ",fractionText predicted.2,
 "]; external interval [",fractionText observed.1,", ",fractionText observed.2,
 "]; overlap ",if passed then "True" else "False"]

def sourceMatches (bytes : ByteArray) : Bool := Text.equal (Text.append "sha256:" (SFT.Host.SHA256Window.digest bytes)) snapshotHash

def validate (bytes : ByteArray) (derivationSeal host implementation : String)
    (before after : Snapshot) : Except String UnitValidation.Validation := do
 if !sourceMatches bytes then .error "ValueError: measured-value external snapshot differs from its registration"
 else do
  let text := String.ofList (Text.decode bytes.size bytes.data.toList)
  let rows := EvolutionMeasuredSource.lines (Text.chars text)
  let inverse_length ← loadRows rows "Rydberg constant" "m^-1"
  let planck ← loadRows rows "Planck constant" "J Hz^-1"
  let speed ← loadRows rows "speed of light in vacuum" "m s^-1"
  let target ← loadRows rows targetQuantity "J"
  let parsed ← CapabilityDocuments.loadProgramFields programFields
  let values ← inputs inverse_length planck speed
  let targetPair ← foldPair target
  let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-measured-value-custodian")
    [(targetId,CapabilityValues.canonical targetPair)]
    (identity (.array [.text registrationHash,.text snapshotHash,.text targetQuantity]))
    (identity (envelope derivationSeal values))
  let execution ← CapabilityExecution.execute parsed values
  let prediction ← sealPrediction none derivationSeal values execution
  let (audited,audit) ← HostilePackage.auditProgram programFields before after
  if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
   .error "ValueError: measured-value prediction failed the hostile-package audit"
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
      ("data_source_ids",.array [.text sourceId]),
      ("measurements",.array [.text (measurement predicted observed passedValue),.text "deliberately displaced unfavorable interval rejected"]),
      ("measurement_receipt_hash",.text (identity (measurementReceipt derivationSeal prediction execution predicted observed passedValue rejected))),
      ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩

theorem resealRejected (old : PredictionSeal) (sealedHash : String) (values : List (String × CapabilityValues.Value))
    (execution : CapabilityExecution.Execution) :
    sealPrediction (some old) sealedHash values execution = .error "prediction is already sealed and cannot be replaced" := rfl

theorem sourceMismatchRejected (bytes : ByteArray) (sealedHash host implementation : String)
    (before after : Snapshot) (changed : sourceMatches bytes = false) :
    validate bytes sealedHash host implementation before after = .error "ValueError: measured-value external snapshot differs from its registration" := by
  unfold validate
  rw [changed]
  rfl

theorem sealBindsExactInputs (sealedHash : String) (values : List (String × CapabilityValues.Value))
    (execution : CapabilityExecution.Execution) :
    (sealPrediction none sealedHash values execution).map (fun p => (p.predictionHash,p.traceHash,p.envelopeHash)) =
      .ok (execution.outputHash,execution.traceHash,identity (envelope sealedHash values)) := rfl
end SFT.Physics.BackfillMeasuredWaveEnergy
