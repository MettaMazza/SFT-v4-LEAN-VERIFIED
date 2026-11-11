import SFT.Materials.MaterialSource
import SFT.Physics.ObservationPrediction
namespace SFT.Materials.MaterialExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def claimId : String := "SFT-MAT-MEAS-MATERIAL-001"
def experimentId : String := "SFT-EXP-MAT-MEAS-MATERIAL-001"
def expectedLabel : String := "complete-constituent-carrier__composition-and-bonding-retained__material-boundary-held__declared-scale-identity__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
def frozenRelation : String := "complete-constituent-carrier__composition-and-bonding-retained__material-boundary-held__declared-scale-identity__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
def falsification : String := "The claim fails if a complete registered material system and retained identity observation lacks any sealed carrier, relation, organization or boundary feature, any required row is omitted, or a tampered row is accepted."
def targetId : String := "sft-mat-meas-material-001-authority-correspondence"
def sourceIds : List String := ["NIST-REFERENCE-MATERIALS-2026-07-24"]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def program : CapabilityAdmission.Program :=
 ⟨Text.append experimentId "-prediction",[
  ⟨.input,"premise",["registered-premise"]⟩,
  ⟨.label,"prediction",["materials-observation",expectedLabel]⟩,
  ⟨.pair,"bound-result",["premise","prediction"]⟩,
  ⟨.emit,"",["prediction"]⟩]⟩
def programFields : List (String × Value) := [
 ("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
 ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def programDocument : Value := .object programFields
def registration (sealHash : String) : Value := .object [("experiment_id",.text "SFT-EXP-MAT-MEAS-MATERIAL-001"),("claim_id",.text "SFT-MAT-MEAS-MATERIAL-001"),("frozen_relation",.text "complete-constituent-carrier__composition-and-bonding-retained__material-boundary-held__declared-scale-identity__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"),("target_id",.text "sft-mat-meas-material-001-authority-correspondence"),("source_references",.array [.array [.text "NIST-REFERENCE-MATERIALS-2026-07-24",.text "https://www.nist.gov/reference-materials",.text "experiments/external_sources/materials/snapshots/nist-reference-materials.html",.text "sha256:2ff393988c4880068ca103e365b0f1e6aed5a02a493b33507f6684a2d9271db9"]]),("required_fragments",.array [.array [.text "NIST-REFERENCE-MATERIALS-2026-07-24",.text "material is thoroughly measured and characterized"],.array [.text "NIST-REFERENCE-MATERIALS-2026-07-24",.text "values of material’s properties"]]),("pre_source_seal_path",.text "experiments/sealed_predictions/materials_complete_branch_pre_source.json"),("pre_source_seal_hash",.text sealHash),("prediction_program",programDocument),("expected_observation_label",.text "complete-constituent-carrier__composition-and-bonding-retained__material-boundary-held__declared-scale-identity__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"),("falsification_condition",.text "The claim fails if a complete registered material system and retained identity observation lacks any sealed carrier, relation, organization or boundary feature, any required row is omitted, or a tampered row is accepted."),("all_source_rows_required",.boolean true),("source_content_absent_until_after_complete_branch_seal",.boolean true),("target_inaccessible_before_prediction_seal",.boolean true)]
def envelope (registryHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registryHash)]

def validateSpec : Except String Unit :=
 if !(Text.chars "SFT-MAT-").isPrefixOf (Text.chars claimId) then .error "Materials blueprint claim identity is invalid"
 else if !(Text.chars "SFT-EXP-MAT-").isPrefixOf (Text.chars experimentId) then .error "Materials blueprint experiment identity is invalid"
 else if !(MaterialEvidence.witness0 && MaterialEvidence.witness1 && MaterialEvidence.witness2) then
   .error "Materials operational witness failed"
 else .ok ()

theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Materials.MaterialExperiment
