import SFT.Chemistry.AnalyticalRecordEvidence
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
set_option maxRecDepth 20000
namespace SFT.Chemistry.AnalyticalRecordExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
open SourceExtraction
def claimId : String := "SFT-CHEM-ANALYTICAL-COMPLETE-RECORD-001"
def experimentId : String := "SFT-EXP-CHEM-ANALYTICAL-COMPLETE-RECORD-001"
def expectedLabel : String := "analytical-result-identifies-measurand-sample-and-method__traceability-and-uncertainty-retained__all-results-and-controls-preserved__falsification-condition-explicit"
def frozenRelation : String := "measurand-and-purpose-held__sample-analyte-matrix-record__method-and-condition-record__calibration-and-reference-chain__all-raw-and-derived-rows-held__uncertainty-and-resolution-held__failed-tampered-and-falsification-record"
def falsification : String := "The claim fails if authority evidence lacks result identity, traceability/uncertainty, retained controls or explicit falsification boundary, or if a tampered row is accepted."
def observationRegistryPath : String := "experiments/external_sources/chemistry/observations_analytical_spectroscopic_batch_1.json"
def references : List Reference := [⟨"complete-analytical-record-authority-composite","IUPAC-NIST-COMPLETE-ANALYTICAL-RECORD-COMPOSITE-2026","authority source set anchored at M03796","experiments/external_sources/chemistry/snapshots/goldbook-terms/M03796.json","sha256:f27104514cc2af6ad31064e74244121a076fc3c795f3f636e4f7f8face60e9a1"⟩]

def predictionSteps : List CapabilityAdmission.Instruction := [
 ⟨.input,"premise",["registered-premise"]⟩,
 ⟨.label,"prediction",["chemical-observation",expectedLabel]⟩,
 ⟨.pair,"bound-result",["premise","prediction"]⟩,
 ⟨.emit,"",["prediction"]⟩]
def program : CapabilityAdmission.Program := ⟨Text.append experimentId "-prediction",predictionSteps⟩
def programFields : List (String × Value) := [
 ("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
 ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def programDocument : Value := .object programFields
def registration : Value := .object [
 ("experiment_id",.text experimentId),("claim_id",.text claimId),("frozen_relation",.text frozenRelation),
 ("target_references",.array (references.map fun row => .array [.text row.targetId,.text row.sourceId,.text row.sourceLocator,.text row.snapshotPath,.text row.snapshotHash])),
 ("observation_registry_path",.text observationRegistryPath),("prediction_program",programDocument),
 ("expected_observation_label",.text expectedLabel),("falsification_condition",.text falsification),
 ("all_rows_required",.boolean true),("target_content_absent_from_derivation_specification",.boolean true),
 ("target_inaccessible_before_seal",.boolean true)]
def registrationHash := identity registration
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (rows : List Resolved) : List (String × Value) := rows.map fun row =>
 (row.reference.targetId,labelValue "external-observation" row.label)

theorem completeReferenceCount : references.length = 1 := rfl
theorem targetContentAbsent :
 (predictionSteps.filter (fun i => ObservationPrediction.isInput i.opcode)).map CapabilityAdmission.Instruction.arguments =
 [["registered-premise"]] := rfl
-- The fixed specification is the pinned catalog record; validate its original
-- branch, dimensions, target identities, hashes and witnesses before IO.
def specDimensions : List (String × List Bool) := [("question",[false,true]),("sample",[false,true]),("method",[false,true]),("reference",[false,true]),("observation",[false,true]),("uncertainty",[false,true]),("falsification",[false,true]),("extra",[false,true])]
def specWitnesses : List Bool := [true,true,true]

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if AnalyticalRecordEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
  .error "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 else if !SourceExtraction.unique (specDimensions.map Prod.fst) then
  .error "empirical Chemistry law contains duplicate dimensions"
 else if !(specDimensions.all (fun d => d.2.length == 2)) then
  .error "each Chemistry dimension must exhaust two registered forms"
 else if !(specDimensions.all (fun d => (d.2.filter id).length == 1)) then
  .error "dimension requires one preserving form"
 else if !SourceText.nonblank expectedLabel || !SourceText.nonblank falsification then
  .error "Chemistry prediction or falsification condition is missing"
 else if !SourceExtraction.unique (references.map Reference.targetId) then
  .error "Chemistry target identities are duplicated"
 else if references.any (fun row => !(Text.chars "sha256:").isPrefixOf (Text.chars row.snapshotHash)) then
  .error "Chemistry target snapshot identity is invalid"
 else if !(specWitnesses.all id) then
  .error "Chemistry operational witness failed"
 else .ok ()

theorem fixedSpecAdmitted : validateSpec = .ok () := rfl

end SFT.Chemistry.AnalyticalRecordExperiment
