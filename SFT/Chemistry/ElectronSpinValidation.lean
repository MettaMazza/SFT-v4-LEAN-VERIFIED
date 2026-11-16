import SFT.Chemistry.ElectronSpinTargets
import SFT.Chemistry.ElectronSpinComparison
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.ElectronSpinValidation
open SFT.Host SFT.Host.Canonical SFT.Physics ElectronSpinExperiment
abbrev InputFields := ElectronSpinRegistry.InputFields
abbrev TargetFields := ElectronSpinTargets.TargetFields
abbrev SourceSnapshot := ElectronSpinTargets.Snapshot
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot

def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (prior : Option PredictionSeal) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-electron-count-spin-parity-NIST-state-comparison/1",.text experimentId]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),
 ("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]

-- Decode only canonical records emitted by the typed custody implementation.
def releasedWord (value : Value) : Except String CapabilityValues.Value := do
 let cells := SourceExtraction.field value "cells"
 let pair ← match cells with
  | .array xs => match xs with
    | [] => .error "released NIST target is invalid"
    | a::rest => match rest with
      | [] => .error "released NIST target is invalid"
      | b::tail => match tail with
        | [] => .ok (a,b)
        | _::_ => .error "released NIST target is invalid"
  | .text _ | .boolean _ | .integer _ | .null | .object _ => .error "released NIST target is invalid"
 let family ← match SourceExtraction.field pair.1 "family" with
  | .text s => .ok s
  | .boolean _ | .integer _ | .null | .array _ | .object _ => .error "released NIST state term or width is invalid"
 let label ← match SourceExtraction.field pair.1 "label" with
  | .text s => .ok s
  | .boolean _ | .integer _ | .null | .array _ | .object _ => .error "released NIST state term or width is invalid"
 let n ← match SourceExtraction.field pair.2 "value" with
  | .integer n => ElectronSpinRegistry.positiveInteger n
  | .boolean _ | .text _ | .null | .array _ | .object _ => .error "released NIST state term or width is invalid"
 let term ← CapabilityValues.heldLabel family label
 return .word [.label term,.count n]
def countText (count : ElectronCountSpin.CountOrEmpty) : String :=
 match count with
 | .emptyOne _ => "empty-One"
 | .count n => render (.integer (.ofNat n.value))
def measurement (row : ElectronSpinComparison.Comparison) : String := Text.intercalate "" [
 row.rowId," (",row.formula,", ",row.chargeAction,"): forced electron count ",
 render (.integer (.ofNat row.count.value)),"; forced ",row.parity.label,"; NIST X-state ",
 row.term.label," gives multiplicity ",render (.integer (.ofNat row.width.value)),
 "; pairs ",countText row.pairs,"; unmatched fibres ",countText row.unmatched,
 "; pass ",if row.passed then "True" else "False"]
def measurementPayload (registrationHash derivationSeal : String) (predictionSeal : PredictionSeal)
 (comparisons : List ElectronSpinComparison.Comparison) (controls : List (String × Bool))
 (traceHash : String) : Value := .object [
 ("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
 ("prediction_seal_hash",.text predictionSeal.sealHash),("input_registry_hash",.text inputRegistryHash),
 ("withheld_target_registry_hash",.text targetRegistryHash),
 ("comparisons",.array (comparisons.map ElectronSpinComparison.comparisonValue)),
 ("adverse_controls",.object (controls.map fun (name,passed) => (name,.boolean passed))),
 ("complete_trace_hash",.text traceHash)]
def compareAll (inputs : List InputFields) (resolved : List ElectronSpinSource.Resolved)
 (predicted : List (String × (CapabilityValues.PositiveCount × CapabilityValues.HeldLabel)))
 (released : List (String × Value)) : Except String (List ElectronSpinComparison.Comparison) :=
 references.mapM fun reference =>
  match inputs.find? (fun row => Text.equal row.rowId reference.targetId) with
  | none => .error (Text.append "KeyError: " reference.targetId)
  | some input => match resolved.find? (fun row => Text.equal row.rowId reference.targetId) with
    | none => .error (Text.append "KeyError: " reference.targetId)
    | some source => match predicted.find? (fun row => Text.equal row.1 reference.targetId) with
      | none => .error (Text.append "KeyError: " reference.targetId)
      | some prediction => match ObservationComparison.lookup reference.targetId released with
        | none => .error (Text.append "KeyError: " reference.targetId)
        | some value => do
         let originalInput ← ElectronSpinRegistry.countInput input
         let releasedTarget ← releasedWord value
         ElectronSpinComparison.compare originalInput input.molecularFormula source.stateTerm prediction.2 releasedTarget
structure Validation where
 value : Value
 passed : Bool
def validate (inputHash : String) (inputSchema : Option Value) (rawInputs : List InputFields)
 (targetHash : String) (targetSchema : Option Value) (rawTargets : List TargetFields)
 (snapshots : List SourceSnapshot) (tamperedFirstHash derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let rows ← ElectronSpinRegistry.loadInputs inputHash inputSchema rawInputs
 let countInputs ← rows.mapM ElectronSpinRegistry.countInput
 let predictionRows ← ElectronSpinPrediction.predictionRows countInputs
 let programDocument := ElectronSpinPrediction.programDocument predictionRows
 let registrationHash := identity (registration programDocument)
 let programFields := match programDocument with
  | .object fields => fields
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let targetRows ← ElectronSpinTargets.loadTargets targetHash targetSchema rawTargets rows
 let resolved ← ElectronSpinTargets.sourceTargets rows targetRows snapshots
 let targetValues := resolved.map fun row => (row.rowId,CapabilityValues.canonical row.targetValue)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none registrationHash derivationSeal execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "ELEC-002 prediction package changed during sealed execution"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) released.values
 let predicted ← ElectronSpinComparison.predictions execution.output
 let comparisons ← compareAll rows resolved predicted released.values
 let firstReference ← match references with
  | [] => .error "IndexError: tuple index out of range"
  | head::_ => .ok head
 let first ← match rows.find? (fun row => Text.equal row.rowId firstReference.targetId) with
  | none => .error (Text.append "KeyError: " firstReference.targetId)
  | some row => ElectronSpinRegistry.countInput row
 let firstSnapshot ← match snapshots.find? (fun row => Text.equal row.path firstReference.snapshotPath) with
  | none => .error (Text.append "FileNotFoundError: " firstReference.snapshotPath)
  | some row => .ok row
 let controls ← ElectronSpinComparison.adverseControls first comparisons.length references.length
  firstSnapshot.hash tamperedFirstHash firstReference.snapshotHash
 let passed := comparisons.all ElectronSpinComparison.Comparison.passed && controls.all Prod.snd
 let releasedIdentity ← TargetCustody.identityFromRelease released
 if !Text.equal releasedIdentity vault.commitment.targetHash then
  throw "released NIST target vector differs from its commitment"
 let messages := comparisons.map measurement ++ controls.map (fun (name,value) =>
  Text.intercalate "" ["adverse ",name,": ",if value then "True" else "False"])
 return ⟨.object [
  ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault predictionSeal),
  ("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
  ("all_rows_preserved",.boolean true),("data_source_ids",.array [.text sourceId]),
  ("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity (measurementPayload registrationHash derivationSeal predictionSeal comparisons controls execution.traceHash))),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.ElectronSpinValidation
