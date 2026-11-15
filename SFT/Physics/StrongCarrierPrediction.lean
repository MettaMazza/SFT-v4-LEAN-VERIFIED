import SFT.Physics.StrongCarrierMasslessConfinedCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.StrongCarrierPrediction
open SFT.Host SFT.Host.Canonical StrongCarrierMasslessConfinedCertificate
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 pure [("sector_relation",.label (← CapabilityValues.heldLabel "strong-sector" "three-colour-labels-and-eight-nonsinglet-carriers")),("mass_relation",.label (← CapabilityValues.heldLabel "strong-carrier-mass" "empty-mass-and-rest-capture-record")),("causal_relation",.label (← CapabilityValues.heldLabel "strong-carrier-causal" "One-support-cell-per-tick-with-retained-phase")),("self_source_relation",.label (← CapabilityValues.heldLabel "strong-carrier-self-source" "colour-carrying-mediator-resources-own-channel")),("tube_relation",.label (← CapabilityValues.heldLabel "strong-carrier-tube" "fixed-half-One-width-and-two-thirds-work-successor")),("composition_relation",.label (← CapabilityValues.heldLabel "strong-carrier-composition" "local-massless-and-asymptotic-confined-records-coexist"))]
def experimentId : String := "SFT-EXP-PHYS-STRONG-CARRIER-MASSLESS-CONFINED-TERMINAL-013"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "D10f prediction shape changed" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "D10f prediction shape changed"
 | .count _ => .error "D10f prediction shape changed"
 | .ratio _ _ => .error "D10f prediction shape changed"
 | .label _ => .error "D10f prediction shape changed"
 | .pair _ _ => .error "D10f prediction shape changed"
 | .table _ => .error "D10f prediction shape changed"
end SFT.Physics.StrongCarrierPrediction
