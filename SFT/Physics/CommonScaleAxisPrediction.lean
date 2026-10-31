import SFT.Physics.CommonScaleAxisMeasurement
import SFT.Physics.RunningConvergencePrediction
namespace SFT.Physics.CommonScaleAxisPrediction
open SFT.Host SFT.Host.Canonical CommonScaleAxis
open RunningConvergencePrediction (label ratio)
def claimId : String := "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030"
def experimentId : String := "SFT-EXP-PHYS-SCALE-COMMON-AXIS-TERMINAL-030"
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let certificate ← commonAxisCertificate
 let terminal := (← terminalElectroweakChain).terminalShare
 let leading ← leadingElectroweakShare (.integer 4)
 pure [("terminal_on_shell_share",← ratio terminal),("leading_support_eight_share",← ratio leading),
 ("unit_ratio_witness",← ratio certificate.unitRatioWitness),
 ("axis",← label "scale-axis" "One-base-binary-support-successor"),
 ("terminal_transport",← label "electroweak" "support-sixteen-hold-three-return-over-seventeen"),
 ("scale_translation",← label "physical-scale" "exact-ratio-before-postseal-held-reference"),
 ("provenance",← label "provenance" "observational-development-explicit")]
def predictionProgram (inputs : List (String × CapabilityValues.Value)) : CapabilityAdmission.Program :=
 let keys := inputs.map Prod.fst
 ⟨Text.append experimentId "-exact-prediction",
  keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩

def predictionDocument (inputs : List (String × CapabilityValues.Value)) : Value :=
 let program := predictionProgram inputs
 .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
  ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]

def inputsValue (inputs : List (String × CapabilityValues.Value)) : Value :=
 .object (inputs.map (fun (key,v) => (key,CapabilityValues.canonical v)))

def registration (inputs : List (String × CapabilityValues.Value)) : Value := .object [
("schema",.text "sft-v3-common-scale-axis-experiment/1"),
("claim_id",.text "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030"),
("experiment_id",.text "SFT-EXP-PHYS-SCALE-COMMON-AXIS-TERMINAL-030"),
("registered_by",.text "Maria Smith"),
("protocol",.text "observational-data-informed_target-inaccessible_sealed-comparison"),
("frozen_relation",.text "The common support axis, weak squared-support curve, terminal held level thirteen, exact on-shell share, unit invariance and exact scale-ratio transport seal before any coupling or scale target opens."),
("prediction_program",predictionDocument inputs),
("withheld_target_ids",.array [.text "WITHHELD-COMMON-SCALE-AND-COUPLING-COMPLETE-VECTOR"]),
("source_ids",.array [.text "PDG-2026-ELECTROWEAK-SCALE-VECTOR",.text "PDG-2025-2026-STRONG-EM-COMPLETE-RUNNING-VECTOR"]),
("source_hashes",.object [("experiments/external_sources/physics/snapshots/common-scale-axis-source-record.json",.text "sha256:157f5a0e4c74b26065747d354c1f942740831524618ab21b6b44bdc672d6325f"),("experiments/external_sources/physics/snapshots/pdg-2026-electroweak-model.pdf",.text "sha256:a102f6252b7190dc423200271dffa7c805cd15a50391b1c578853d2f777611cb"),("experiments/external_sources/physics/snapshots/coupling-running-convergence-source-record.json",.text "sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953"),("claims/SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006/certificate.json",.text "sha256:f598cd663a76f8137cf2e40c5e8154083b8196ec399751da8577ce9769f688d6"),("claims/SFT-PHYS-VALIDATION-ELECTROWEAK-TERMINAL-003/certificate.json",.text "sha256:3d93670205eb78e5f45da65574c011beb64a142bdf07cd36a2f09f97f8c93980"),("claims/SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003/certificate.json",.text "sha256:41ac74e37c135774d5c8b384c5fcf5aae5415c21c2a63b3d77c5a5d2981ed651")]),
("row_retention_policy",.text "all printed weak scheme and low-transfer rows, complete weak figure, inherited complete strong/EM vector, terminal on-shell and proton-Planck certificates, every adverse and scheme boundary"),
("target_access_policy",.text "capability-closed prediction; release only after matching seal"),
("comparison_protocol",.text "exact rational interval comparison, direction checks, complete row custody and inherited-receipt identity validation"),
("falsification_condition",.text "Reject if any source or inherited receipt identity changes; if the terminal on-shell prediction leaves the registered on-shell interval; if the registered sub-W low-transfer direction is reversed; if the NuTeV adverse row, scheme distinctions, W-threshold sign change, strong/EM complete vectors or proton-Planck scale receipt are omitted; if a measured value selects a rung or law; or if target access precedes the seal.")]
def frozenRelation : String := "The common support axis, weak squared-support curve, terminal held level thirteen, exact on-shell share, unit invariance and exact scale-ratio transport seal before any coupling or scale target opens."
end SFT.Physics.CommonScaleAxisPrediction
