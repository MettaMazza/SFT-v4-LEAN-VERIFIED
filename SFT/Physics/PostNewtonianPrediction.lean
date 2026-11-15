import SFT.Physics.PostNewtonianFixedPointCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.PostNewtonianPrediction
open SFT.Host SFT.Host.Canonical PostNewtonianFixedPointCertificate
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 pure [("source_relation",.label (← CapabilityValues.heldLabel "self-source-matter" "binary-colour-structural-source")),("coupling_relation",.label (← CapabilityValues.heldLabel "self-source-coupling" "forced-half-One")),("action_relation",.label (← CapabilityValues.heldLabel "field-feedback" "positive-field-square")),("fixed_relation",.label (← CapabilityValues.heldLabel "admissible-fixed-point" "unique-quarter-One")),("convergence_relation",.label (← CapabilityValues.heldLabel "successor-contraction" "errors-and-corrections-shrink-below-quarter")),("scope_relation",.label (← CapabilityValues.heldLabel "comparison-scope" "exact-Fold-scalar-not-universal-PN-convergence"))]
def experimentId : String := "SFT-EXP-PHYS-POST-NEWTONIAN-FIXED-POINT-TERMINAL-009"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "D9m prediction shape changed" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "D9m prediction shape changed"
 | .count _ => .error "D9m prediction shape changed"
 | .ratio _ _ => .error "D9m prediction shape changed"
 | .label _ => .error "D9m prediction shape changed"
 | .pair _ _ => .error "D9m prediction shape changed"
 | .table _ => .error "D9m prediction shape changed"
end SFT.Physics.PostNewtonianPrediction
