import SFT.Physics.ParkerProtonEnergy
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.ParkerPrediction
open SFT.Host SFT.Host.Canonical ParkerProtonEnergy
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let terminal ← protonEnergyFraction
 let leading ← historicalLeadingFraction
 let tn ← CapabilityValues.count terminal.num.natAbs
 let td ← CapabilityValues.count terminal.den
 let ln ← CapabilityValues.count leading.num.natAbs
 let ld ← CapabilityValues.count leading.den
 pure [("terminal_fraction",.ratio tn td),("historical_fraction",.ratio ln ld),
 ("channel_relation",.label (← CapabilityValues.heldLabel "proton-colour-channels" "three-squared-Take-One-is-eight")),
 ("energy_relation",.label (← CapabilityValues.heldLabel "field-energy" "electromagnetic-amplitude-self-composition")),
 ("scale_boundary",.label (← CapabilityValues.heldLabel "dimensionful-scale" "proton-rest-energy-postseal-only")),
 ("provenance",.label (← CapabilityValues.heldLabel "provenance" "observational-derivation-not-historical-blindness"))]
def experimentId : String := "SFT-EXP-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (keys : List String) : Except String (List (String × CapabilityValues.Value)) := match output with
 | .word cells => if cells.length != keys.length then .error "Parker prediction has wrong Fold shape" else .ok (keys.zip cells)
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => .error "Parker prediction has wrong Fold shape"
end SFT.Physics.ParkerPrediction
