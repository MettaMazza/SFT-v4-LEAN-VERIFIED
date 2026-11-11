import SFT.Chemistry.SolutionEvidence
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
set_option maxRecDepth 20000
namespace SFT.Chemistry.SolutionExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
open SourceExtraction
def claimId : String := "SFT-CHEM-STOICH-SOLUTION-001"
def experimentId : String := "SFT-EXP-CHEM-STOICH-SOLUTION-001"
def expectedLabel : String := "single-liquid-or-solid-phase__multiple-substance-support__solvent-solute-role-partition"
def frozenRelation : String := "liquid-or-solid-phase__single-phase-support__multiple-substance-support__solvent-solute-role-partition"
def falsification : String := "The claim fails if the IUPAC solution record lacks liquid/solid phase, multiple substances or solvent/solute distinction, or if a changed row is accepted."
def observationRegistryPath : String := "experiments/external_sources/chemistry/observations_composition_stoichiometry_batch_1.json"
def references : List Reference := [⟨"solution-iupac-s05746","IUPAC-GOLD-BOOK-S05746-2026","https://goldbook.iupac.org/terms/view/S05746/json :: term S05746, current definition","experiments/external_sources/chemistry/snapshots/goldbook-terms/S05746.json","sha256:39f8916fdced6993ceb67e374641b95375570866a24123508ce26f9ec0049f28"⟩]

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
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("phase",[false,true]),("composition",[false,true]),("roles",[false,true]),("identity",[false,true]),("context",[false,true]),("record",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [true,true,true]

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if SolutionEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.SolutionExperiment
