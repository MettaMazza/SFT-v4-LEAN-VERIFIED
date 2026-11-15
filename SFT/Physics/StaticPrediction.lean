import SFT.Physics.StaticExteriorClockCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.StaticPrediction
open SFT.Host SFT.Host.Canonical StaticExteriorClockCertificate
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 pure [("horizon_relation",.label (← CapabilityValues.heldLabel "generated-boundary" "twice-positive-mass-carrier")),("field_relation",.label (← CapabilityValues.heldLabel "radial-response" "rank-two-flux-conserved")),("well_relation",.label (← CapabilityValues.heldLabel "exterior-well" "one-radius-times-field")),("coefficient_relation",.label (← CapabilityValues.heldLabel "clock-square-coefficient" "positive-complement-completes-One")),("clock_relation",.label (← CapabilityValues.heldLabel "exact-clock-comparison" "rational-square-carriers-and-empty-boundary")),("successor_relation",.label (← CapabilityValues.heldLabel "outward-depth" "well-halves-field-quarters-flux-retained")),("scope_relation",.label (← CapabilityValues.heldLabel "comparison-scope" "finite-exterior-static-spherical-channel"))]
def experimentId : String := "SFT-EXP-PHYS-STATIC-EXTERIOR-CLOCK-TERMINAL-011"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "D9o prediction shape changed" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "D9o prediction shape changed"
 | .count _ => .error "D9o prediction shape changed"
 | .ratio _ _ => .error "D9o prediction shape changed"
 | .label _ => .error "D9o prediction shape changed"
 | .pair _ _ => .error "D9o prediction shape changed"
 | .table _ => .error "D9o prediction shape changed"
end SFT.Physics.StaticPrediction
