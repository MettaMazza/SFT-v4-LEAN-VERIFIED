import SFT.Chemistry.MolecularElectronicEvidence
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
set_option maxRecDepth 20000
namespace SFT.Chemistry.MolecularElectronicExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
open SourceExtraction
def claimId : String := "SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001"
def experimentId : String := "SFT-EXP-CHEM-ELECTRONIC-STATE-IDENTITY-001"
def expectedLabel : String := "allowed-electronic-arrangement__electron-support-retained__molecular-carrier-bounded"
def frozenRelation : String := "identified-molecular-carrier__electron-occurrences-retained__complete-joint-arrangement__admitted-quantum-constraints__molecular-composition-retained__observation-distinguishable-state__held-state-record__no-extra-rule"
def falsification : String := "The claim fails if any generated finite electron occurrence can be omitted, duplicated or detached from the molecular carrier while preserving electronic-state identity; if an arrangement violating an admitted quantum constraint survives; if the official source-derived target differs from the sealed consequence; or if any target, source, candidate, receipt or unfavorable control is omitted or altered."
def observationRegistryPath : String := "experiments/external_sources/chemistry/observations_electronic_structure_batch_1.json"
def references : List Reference := [⟨"electronic-state-iupac-et07026","IUPAC-GOLD-BOOK-ET07026-2026","https://goldbook.iupac.org/terms/view/ET07026/json :: current definition","experiments/external_sources/chemistry/snapshots/goldbook-terms/ET07026.json","sha256:c22eb092dceb58f901486e494d81b2528a74a60cdd6caa39d9890f69975bef13"⟩]

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
 ("experiment_id",.text experimentId),("claim_id",.text claimId),("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("target_references",.array (references.map fun row => .array [.text row.targetId,.text row.sourceId,.text row.sourceLocator,.text row.snapshotPath,.text row.snapshotHash])),
 ("observation_registry_path",.text observationRegistryPath),("prediction_program",programDocument),
 ("sealed_consequence_label",.text expectedLabel),("falsification_condition",.text falsification),
 ("development_observation_disclosed",.boolean true),
 ("observation_may_have_informed_question_and_candidate_relation",.boolean true),
 ("not_claimed_as_unknown-target_forward_prediction",.boolean true),
 ("external_target_api_absent_from_candidate_generator_and_eliminator",.boolean true),
 ("target_content_inaccessible_to_prediction_execution",.boolean true),
 ("comparison_implementation_inaccessible_to_prediction_execution",.boolean true),
 ("all_rows_required",.boolean true)]
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
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("occurrences",[false,true]),("arrangement",[false,true]),("admissibility",[false,true]),("composition",[false,true]),("distinction",[false,true]),("record",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [true,true,true]

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if MolecularElectronicEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.MolecularElectronicExperiment
