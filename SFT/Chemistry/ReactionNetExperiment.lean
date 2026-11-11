import SFT.Chemistry.ReactionNetEvidence
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
set_option maxRecDepth 20000
namespace SFT.Chemistry.ReactionNetExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
open SourceExtraction
def claimId : String := "SFT-CHEM-NET-REACTION-001"
def experimentId : String := "SFT-EXP-CHEM-NET-REACTION-001"
def expectedLabel : String := "chemical-species-nodes__reaction-steps-connect-species__combined-network-paths__complete-source-product-boundary"
def frozenRelation : String := "chemical-species-nodes__reaction-steps-connect-species__shared-species-compose-paths__source-product-boundary-held__all-generated-paths-retained"
def falsification : String := "The claim fails if authority evidence lacks species, reaction connections, composed network paths or a complete boundary, or if a tampered row is accepted."
def observationRegistryPath : String := "experiments/external_sources/chemistry/observations_catalysis_interfaces_batch_1.json"
def references : List Reference := [⟨"reaction-network-iupac-composite","IUPAC-GOLD-BOOK-REACTION-NETWORK-COMPOSITE-2026","authority source set anchored at C01210","experiments/external_sources/chemistry/snapshots/goldbook-terms/C01210.json","sha256:f7949843026a8fe090e71f1d952633b8c63eb8277ad6b067b4bcaf5babf3598d"⟩]

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
def specDimensions : List (String × List Bool) := [("species",[false,true]),("reactions",[false,true]),("composition",[false,true]),("boundary",[false,true]),("branching",[false,true]),("cycles",[false,true]),("record",[false,true]),("extra",[false,true])]
def specWitnesses : List Bool := [true,true,true]

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if ReactionNetEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.ReactionNetExperiment
