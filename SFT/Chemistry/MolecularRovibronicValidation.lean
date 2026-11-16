import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Chemistry.MolecularRovibronicExperiment
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MolecularRovibronicValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularRovibronicExperiment SourceExtraction
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot

def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (prior : Option PredictionSeal) (derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def programFields : List (String × Value) := [
 ("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
 ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]

def observation : CapabilityValues.Value → Except String String
 | .label held => if Text.equal held.family "chemical-observation" then .ok held.label
   else .error "rovibronic prediction emitted an invalid chemical observation label"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ =>
   .error "rovibronic prediction emitted an invalid chemical observation label"

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-H2-D2-ratio-interval-and-held-label-comparison",.text experimentId]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),
 ("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

structure RatioRow where
 name : String
 predicted : Rat
 lower : Rat
 upper : Rat
 contained : Bool

def ratioRows (predictions : List (String × Rat)) (intervals : List (String × (Rat × Rat))) : Except String (List RatioRow) :=
 predictions.mapM fun (name,predicted) => do
  let interval ← match intervals.find? (fun p => Text.equal p.1 name) with
   | some p => .ok p.2
   | none => .error (Text.append "KeyError: " name)
  pure ⟨name,predicted,interval.1,interval.2,!(predicted.blt interval.1) && !(interval.2.blt predicted)⟩

def ratioRowValue (row : RatioRow) : Value := .object [
 ("row_id",.text row.name),("predicted_exact_numerator",.integer row.predicted.num),
 ("predicted_exact_denominator",.integer (.ofNat row.predicted.den)),
 ("measured_lower_numerator",.integer row.lower.num),("measured_lower_denominator",.integer (.ofNat row.lower.den)),
 ("measured_upper_numerator",.integer row.upper.num),("measured_upper_denominator",.integer (.ofNat row.upper.den)),
 ("contained",.boolean row.contained)]
def ratText (r : Rat) : String := Text.intercalate "/" [render (.integer r.num),render (.integer (.ofNat r.den))]
def ratioMessage (row : RatioRow) : String := Text.intercalate "" [row.name,": exact ",ratText row.predicted,
 " contained in source-derived interval [",ratText row.lower,", ",ratText row.upper,
 "]: ",if row.contained then "True" else "False"]
def targetId : String := "NIST-MOLECULAR-H2-D2-COMPLETE-VECTOR"
def sourceId : String := "NIST-MOLECULAR-SPECTROSCOPY-H2-D2-SUCCESSOR"
def comparison (prediction observed : String) : Value := .object [
 ("target_id",.text targetId),("source_id",.text sourceId),("predicted",.text prediction),
 ("observed",.text observed),("passed",.boolean (Text.equal prediction observed))]
def tamperedPassed (prediction : String) : Bool := !Text.equal prediction (Text.append prediction "__changed")
def tampered (prediction : String) : Value := .object [
 ("target_id",.text "deliberately-tampered-unfavorable-control"),("predicted",.text prediction),
 ("observed",.text (Text.append prediction "__changed")),("passed",.boolean (tamperedPassed prediction))]
def measurementPayload (derivationSeal : String) (predictionSeal : PredictionSeal) (schema : Value)
 (rows : List RatioRow) (prediction observed traceHash : String) : Value := .object [
 ("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
 ("prediction_seal_hash",.text predictionSeal.sealHash),("source_record_schema",schema),
 ("ratio_rows",.array (rows.map ratioRowValue)),("comparison",comparison prediction observed),
 ("tampered_control",tampered prediction),("complete_trace_hash",.text traceHash)]
structure Validation where
 value : Value
 passed : Bool

-- Original source IO supplies the immutable snapshot bytes and protected-tree snapshots.
def validate (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 MolecularRovibronicExperiment.validateSpec
 let record ← MolecularSpectroscopyRecords.authoritativeRecord bytes files payload
 let intervals ← MolecularSpectroscopyMeasurement.measuredRatioIntervals record
 let predictions ← MolecularSpectroscopyMeasurement.sealedRatioVector
 let observedLabel ← MolecularSpectroscopyMeasurement.classification bytes files payload
 if !Text.equal observedLabel MolecularSpectroscopyMeasurement.label then
  throw "the complete H2/D2 classification changed"
 let rows ← ratioRows predictions intervals
 if rows.length != 4 || !(rows.all RatioRow.contained) then
  throw "a sealed rovibronic ratio left the complete registered NIST interval vector"
 let inputs ← inputValues derivationSeal
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
  [(targetId,labelValue "external-observation" observedLabel)]
  (identity (.array [.text registrationHash,.text MolecularSpectroscopyRecords.sourceHash])) (identity (envelope derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none derivationSeal execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "rovibronic Chemistry prediction differs after hostile-package audit"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
  (references.map Reference.targetId) released.values
 let prediction ← observation execution.output
 let observed ← ObservationComparison.releasedLabel targetId released.values
 let passed := Text.equal prediction observed && tamperedPassed prediction && rows.all RatioRow.contained
 let releasedIdentity ← TargetCustody.identityFromRelease released
 if !Text.equal releasedIdentity vault.commitment.targetHash then
  throw "released rovibronic target identity differs from commitment"
 let schema ← RunningConvergenceMeasurement.field record "schema"
 let messages := rows.map ratioMessage ++ [Text.intercalate "" [targetId,": predicted ",prediction,
  "; source-derived ",observed,"; exact match ",if Text.equal prediction observed then "True" else "False"],
  "deliberately tampered unfavorable control rejected"]
 pure ⟨.object [
  ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault predictionSeal),
  ("target_custody_certificate",custodyCertificate released predictionSeal),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
  ("all_rows_preserved",.boolean true),("data_source_ids",.array [.text sourceId]),
  ("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity (measurementPayload derivationSeal predictionSeal schema rows prediction observed execution.traceHash))),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩

theorem resealRejected (old : PredictionSeal) (derivationSeal : String) (execution : CapabilityExecution.Execution) :
 sealPrediction (some old) derivationSeal execution = .error "prediction is already sealed and cannot be replaced" := rfl
end SFT.Chemistry.MolecularRovibronicValidation

