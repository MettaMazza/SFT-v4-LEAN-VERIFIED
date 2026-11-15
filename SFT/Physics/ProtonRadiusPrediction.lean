import SFT.Physics.ProtonRadius
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.ProtonRadiusPrediction
open SFT.Host SFT.Host.Canonical ProtonRadius
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let terminal ← terminalRadiusCoefficient
 let leading ← leadingRadiusMultiplier
 let tn ← CapabilityValues.count terminal.num.natAbs
 let td ← CapabilityValues.count terminal.den
 let ln ← CapabilityValues.count leading.num.natAbs
 let ld ← CapabilityValues.count leading.den
 pure [("terminal_coefficient",.ratio tn td),("leading_multiplier",.ratio ln ld),
 ("tripling_edge",.label (← CapabilityValues.heldLabel "proton-radius" "outer-two-thirds-complement")),
 ("charge_support",.label (← CapabilityValues.heldLabel "proton-charge" "nine-internal-pairs-plus-one-external-charge")),
 ("probe_relation",.label (← CapabilityValues.heldLabel "probe" "one-proton-radius-independent-of-probe")),
 ("scale_boundary",.label (← CapabilityValues.heldLabel "dimensionful-scale" "reduced-proton-Compton-postseal-only")),
 ("provenance",.label (← CapabilityValues.heldLabel "provenance" "observational-derivation-not-historical-blindness"))]

def experimentId : String := "SFT-EXP-PHYS-PROTON-RADIUS-TERMINAL-029"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (keys : List String) : Except String (List (String × CapabilityValues.Value)) := match output with
 | .word cells => if cells.length != keys.length then .error "proton-radius prediction has wrong Fold shape" else .ok (keys.zip cells)
 | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => .error "proton-radius prediction has wrong Fold shape"
end SFT.Physics.ProtonRadiusPrediction
