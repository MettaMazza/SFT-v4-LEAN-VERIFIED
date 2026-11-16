import SFT.Chemistry.MolecularRovibronicEvidence
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
set_option maxRecDepth 20000
namespace SFT.Chemistry.MolecularRovibronicExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
open SourceExtraction
def claimId : String := "SFT-CHEM-ROVIBRONIC-COMPOSITION-001"
def experimentId : String := "SFT-EXP-CHEM-ROVIBRONIC-COMPOSITION-001"
def expectedLabel : String := "terminal-molecular-JJplusOne-anharmonic-and-isotope-relations-contained-in-complete-NIST-H2-D2-displayed-resolution-vector__observational-prediction-protocol-passed"
def frozenRelation : String := "identified-molecular-state-carrier__nuclear-electronic-joint-support__admitted-electronic-vibrational-rotational-order__positive-odd-vibrational-recurrence__positive-counted-rotational-recurrence__held-spin-state__retained-rovibronic-observation__no-extra-rule"
def falsification : String := "The claim fails if any retained nucleus, isotope, electronic, vibrational, rotational, spin or observation coordinate can be erased without merging a registered state; if the exact admitted H2/D2 ladder or isotope relations leave the complete NIST displayed-resolution vector; if a source is opened before the prediction seal; or if any favorable, unfavorable, predecessor or tampered row is omitted."
def observationRegistryPath : String := "experiments/external_sources/physics/snapshots/molecular-spectroscopy-successor-source-record.json"
def references : List Reference := [⟨"NIST-MOLECULAR-H2-D2-COMPLETE-VECTOR","NIST-MOLECULAR-SPECTROSCOPY-H2-D2-SUCCESSOR","NIST Chemistry WebBook SRD 69 H2 and D2 X 1Sigma_g+ ground-state omega_e, omega_e*x_e, B_e and r_e rows","experiments/external_sources/physics/snapshots/molecular-spectroscopy-successor-source-record.json","sha256:211fb30414204bcc61f9fb4a69a451db24cb5d5aaaacb2bb3b85fc83429388a9"⟩]

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
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("composition",[false,true]),("scale",[false,true]),("vibration",[false,true]),("rotation",[false,true]),("spin",[false,true]),("observation",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [MolecularRovibronicWitnesses.witness0,MolecularRovibronicWitnesses.witness1,MolecularRovibronicWitnesses.witness2]

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if MolecularRovibronicEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.MolecularRovibronicExperiment
