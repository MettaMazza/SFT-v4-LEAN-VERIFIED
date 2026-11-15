import SFT.Physics.StrongFieldNonlinearFixedPointCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.StrongFieldPrediction
open SFT.Host SFT.Host.Canonical StrongFieldNonlinearFixedPointCertificate
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 pure [("chargeless_relation",.label (← CapabilityValues.heldLabel "chargeless-source" "empty-correction-and-held-One")),("gravity_relation",.label (← CapabilityValues.heldLabel "gravity-self-source" "unique-quarter-One-fixed-point-with-shrinking-corrections")),("strong_update_relation",.label (← CapabilityValues.heldLabel "colour-self-source" "each-successor-retains-F-and-appends-complete-binary-carrier")),("strong_fixed_relation",.label (← CapabilityValues.heldLabel "strong-finite-fixed-point" "empty-for-every-positive-exact-finite-F-by-F-plus-two-order")),("strong_bound_relation",.label (← CapabilityValues.heldLabel "strong-confinement" "finite-witness-above-every-positive-exact-finite-bound")),("scope_relation",.label (← CapabilityValues.heldLabel "strong-field-scope" "persistent-self-source-branch-without-completed-infinity"))]
def experimentId : String := "SFT-EXP-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "D10e prediction shape changed" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "D10e prediction shape changed"
 | .count _ => .error "D10e prediction shape changed"
 | .ratio _ _ => .error "D10e prediction shape changed"
 | .label _ => .error "D10e prediction shape changed"
 | .pair _ _ => .error "D10e prediction shape changed"
 | .table _ => .error "D10e prediction shape changed"
end SFT.Physics.StrongFieldPrediction
