import SFT.Physics.OrbitalDimensionStabilityCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.OrbitalPrediction
open SFT.Host SFT.Host.Canonical OrbitalDimensionStabilityCertificate
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 pure [("dimension_relation",.label (← CapabilityValues.heldLabel "dimension-domain" "complete-positive-wholes-at-least-two")),("gravity_relation",.label (← CapabilityValues.heldLabel "gravity-dilution" "positive-denominator-q-to-d-minus-One")),("centrifugal_relation",.label (← CapabilityValues.heldLabel "centrifugal-dilution" "positive-denominator-q-cubed")),("comparison_relation",.label (← CapabilityValues.heldLabel "outward-comparison" "denominator-order-only")),("partition_relation",.label (← CapabilityValues.heldLabel "stability-partition" "stable-two-three-marginal-four-unstable-above")),("scope_relation",.label (← CapabilityValues.heldLabel "orbital-scope" "circular-central-force-positive-magnitudes"))]
def experimentId : String := "SFT-EXP-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "D9f prediction shape changed" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "D9f prediction shape changed"
 | .count _ => .error "D9f prediction shape changed"
 | .ratio _ _ => .error "D9f prediction shape changed"
 | .label _ => .error "D9f prediction shape changed"
 | .pair _ _ => .error "D9f prediction shape changed"
 | .table _ => .error "D9f prediction shape changed"
end SFT.Physics.OrbitalPrediction
