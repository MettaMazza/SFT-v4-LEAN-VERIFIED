import SFT.Materials.DualitySource
import SFT.Materials.DualityEvidence
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
namespace SFT.Materials.DualityExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def claimId : String := "SFT-MAT-ELEC-CARRIER-DUALITY-001"
def experimentId : String := "SFT-EXP-MAT-ELEC-CARRIER-DUALITY-001"
def expectedLabel : String := "binary-occupation-carrier__occupied-and-held-absence-pair__charge-orientation-retained__two-carrier-classes__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
def frozenRelation : String := "binary-occupation-carrier__occupied-and-held-absence-pair__charge-orientation-retained__two-carrier-classes__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
def falsification : String := "The claim fails if a complete registered electron and hole carrier duality observation lacks any sealed carrier, relation, organization or boundary feature, any required row is omitted, or a tampered row is accepted."
def targetId : String := "sft-mat-elec-carrier-duality-001-authority-correspondence"
def sourceIds : List String := ["NIST-SEMICONDUCTOR-CARRIERS-2026-07-24", "NIST-OPTICAL-MATERIALS-2026-07-24"]
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
def registration (sealHash : String) : Value := .object [("experiment_id",.text "SFT-EXP-MAT-ELEC-CARRIER-DUALITY-001"),("claim_id",.text "SFT-MAT-ELEC-CARRIER-DUALITY-001"),("frozen_relation",.text "binary-occupation-carrier__occupied-and-held-absence-pair__charge-orientation-retained__two-carrier-classes__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"),("target_id",.text "sft-mat-elec-carrier-duality-001-authority-correspondence"),("source_references",.array [.array [.text "NIST-SEMICONDUCTOR-CARRIERS-2026-07-24",.text "https://www.nist.gov/news-events/news/2017/03/testing-performance-semiconductors-light",.text "experiments/external_sources/materials/snapshots/nist-semiconductor-carriers.html",.text "sha256:05c774e4a30e6009f031b3064b16319d181ddac92e6d088a01bb6fe362172cc5"],.array [.text "NIST-OPTICAL-MATERIALS-2026-07-24",.text "https://www.nist.gov/programs-projects/theory-optical-properties-materials",.text "experiments/external_sources/materials/snapshots/nist-optical-materials.html",.text "sha256:3cd2616a7d74445fda880027ee0d7659d112e27a48e9a86616e766b41f0c5f1b"]]),("required_fragments",.array [.array [.text "NIST-SEMICONDUCTOR-CARRIERS-2026-07-24",.text "negative carriers are electrons"],.array [.text "NIST-SEMICONDUCTOR-CARRIERS-2026-07-24",.text "positive carriers are referred to as “holes”"],.array [.text "NIST-OPTICAL-MATERIALS-2026-07-24",.text "electron and hole lifetime-damping effects"],.array [.text "NIST-OPTICAL-MATERIALS-2026-07-24",.text "semiconductors"]]),("pre_source_seal_path",.text "experiments/sealed_predictions/materials_complete_branch_pre_source.json"),("pre_source_seal_hash",.text sealHash),("prediction_program",programDocument),("expected_observation_label",.text "binary-occupation-carrier__occupied-and-held-absence-pair__charge-orientation-retained__two-carrier-classes__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"),("falsification_condition",.text "The claim fails if a complete registered electron and hole carrier duality observation lacks any sealed carrier, relation, organization or boundary feature, any required row is omitted, or a tampered row is accepted."),("all_source_rows_required",.boolean true),("source_content_absent_until_after_complete_branch_seal",.boolean true),("target_inaccessible_before_prediction_seal",.boolean true)]
def envelope (registryHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registryHash)]

def registeredSubbranches : List String := ["measurement_identity","crystal_quasicrystal","defects_microstructure","electronic_semiconductor","superconducting_superfluid_topological","mechanical","thermal_magnetic_optical","material_classes_bulk","processing_degradation","advanced_functional_sustainable"]
def subbranch : String := "electronic_semiconductor"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-erased-or-answer-only",false),("binary-occupation-carrier",true)]),("relation",[("relation-imported-fitted-or-erased",false),("occupied-and-held-absence-pair",true)]),("organization",[("organization-collapsed",false),("charge-orientation-retained",true)]),("observation",[("observation-boundary-unrecorded",false),("two-carrier-classes",true)]),("record",[("result-without-state-transition-record",false),("complete-state-transition-boundary-trace",true)]),("provenance",[("authority-or-target-selected-law",false),("root-bound-forward-forcing",true)]),("generality",[("single-specimen-or-instance-lookup",false),("positive-finite-successor-closure",true)]),("extension",[("free-fit-exception-or-extra-rule",false),("no-extra-rule",true)])]
def preservingNames : List (String × List (String × Bool)) → Except String (List String)
 | [] => .ok []
 | (key,choices)::rest => do
   if !(choices.length == 2) then .error "each Materials dimension must exhaust two registered forms"
   else
    let held := choices.filter (fun c => c.2)
    if !(held.length == 1) then .error (Text.intercalate "" ["dimension ",key," requires one preserving form"])
    else do
     let tail ← preservingNames rest
     .ok ((held.headD ("",false)).1::tail)

def binding : Option (List MaterialSource.Requirement) := some DualitySource.requirements

def bindingSources (rows : List MaterialSource.Requirement) : List String :=
 rows.foldl (fun held row => if held.any (fun id => Text.equal id row.sourceId) then held else held++[row.sourceId]) []

def sameLabels : List String → List String → Bool
 | [], [] => true
 | [], _::_ => false
 | _::_, [] => false
 | a::xs, b::ys => Text.equal a b && sameLabels xs ys

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-MAT-").isPrefixOf (Text.chars claimId) then .error "Materials blueprint claim identity is invalid"
 else if !(Text.chars "SFT-EXP-MAT-").isPrefixOf (Text.chars experimentId) then .error "Materials blueprint experiment identity is invalid"
 else if !(registeredSubbranches.any (fun name => Text.equal name subbranch)) then .error "Materials blueprint subbranch is unregistered"
 else if DualityEvidence.dependencies.isEmpty || !(dimensions.length == 8) then .error "Materials blueprint requires dependencies and eight dimensions"
 else if !(SFT.Chemistry.SourceExtraction.unique (dimensions.map (fun d => d.1))) then .error "Materials blueprint dimensions repeat"
 else do
  let names ← preservingNames dimensions
  if !(Text.equal frozenRelation (Text.intercalate "__" names)) then .error "Materials exact result is not the unique preservation survivor"
  else if !SFT.Chemistry.SourceText.nonblank expectedLabel || !SFT.Chemistry.SourceText.nonblank falsification then .error "Materials blueprint lacks prediction or falsification boundary"
  else if !(DualityEvidence.witness0 && DualityEvidence.witness1 && DualityEvidence.witness2) then .error "Materials operational witness failed"
  else match binding with
  | none => .error "Materials claim lacks a post-seal binding"
  | some rows =>
   if sourceIds.isEmpty || !(sameLabels sourceIds (bindingSources rows)) then .error "Materials source support differs from the registered binding"
   else if !(Text.equal targetId (Text.append (Text.lowerAscii claimId) "-authority-correspondence")) then .error "Materials target identity is invalid"
   else .ok ()

theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Materials.DualityExperiment
