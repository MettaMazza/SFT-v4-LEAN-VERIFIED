import SFT.Physics.SymmetricSourceConservationCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.SymmetricPrediction
open SFT.Host SFT.Host.Canonical SymmetricSourceConservationCertificate
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 pure [("component_relation",.label (← CapabilityValues.heldLabel "symmetric-component-carrier" "complete-generated-rank-two-slots")),("pairing_relation",.label (← CapabilityValues.heldLabel "curvature-source-pairing" "one-slot-to-one-slot")),("operator_relation",.label (← CapabilityValues.heldLabel "generated-difference-algebra" "commuting-held-coordinate-shifts")),("conservation_relation",.label (← CapabilityValues.heldLabel "local-source-closure" "carried-and-opposed-ledgers-match")),("source_relation",.label (← CapabilityValues.heldLabel "source-component-meaning" "energy-momentum-stress-partition")),("adverse_relation",.label (← CapabilityValues.heldLabel "leak-control" "missing-flow-breaks-balance")),("scope_relation",.label (← CapabilityValues.heldLabel "comparison-scope" "generated-commuting-difference-channel"))]
def experimentId : String := "SFT-EXP-PHYS-SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "D9n prediction shape changed" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "D9n prediction shape changed"
 | .count _ => .error "D9n prediction shape changed"
 | .ratio _ _ => .error "D9n prediction shape changed"
 | .label _ => .error "D9n prediction shape changed"
 | .pair _ _ => .error "D9n prediction shape changed"
 | .table _ => .error "D9n prediction shape changed"
end SFT.Physics.SymmetricPrediction
