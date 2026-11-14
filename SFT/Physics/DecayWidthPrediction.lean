import SFT.Physics.DecayWidthBranchingLifetimeCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.DecayWidthPrediction
open SFT.Host SFT.Host.Canonical DecayWidthBranchingLifetimeCertificate LeptonIntervals
set_option maxRecDepth 20000
def positiveRatio (q : Rat) : Except String CapabilityValues.Value := do
 if q.num < 1 then throw "decay prediction input must remain exact and positive"
 let n ← CapabilityValues.count q.num.toNat
 let d ← CapabilityValues.count q.den
 pure (.ratio n d)
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let c ← formalCertificate
 pure [("partial_width_one",← positiveRatio (← LeptonRatios.atIndex c.sampleWidths 0)),("partial_width_two",← positiveRatio (← LeptonRatios.atIndex c.sampleWidths 1)),("partial_width_three",← positiveRatio (← LeptonRatios.atIndex c.sampleWidths 2)),("total_width",← positiveRatio c.total),("branch_one",← positiveRatio (← LeptonRatios.atIndex c.parts 0)),("branch_two",← positiveRatio (← LeptonRatios.atIndex c.parts 1)),("branch_three",← positiveRatio (← LeptonRatios.atIndex c.parts 2)),("branch_partition",← positiveRatio c.partition),("lifetime",← positiveRatio c.lifetime),("closed_channel",.label (← CapabilityValues.heldLabel "decay-channel" "structural-empty-form")),("width_relation",.label (← CapabilityValues.heldLabel "decay-width" "complete-positive-partial-sum")),("branch_relation",.label (← CapabilityValues.heldLabel "decay-branch" "partial-over-total-partition-of-one")),("lifetime_relation",.label (← CapabilityValues.heldLabel "decay-duration" "action-over-total-width"))]
def experimentId : String := "SFT-EXP-PHYS-DECAY-WIDTH-BRANCHING-LIFETIME-TERMINAL-006"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "decay-width prediction has the wrong exact Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "decay-width prediction has the wrong exact Fold shape"
 | .count _ => .error "decay-width prediction has the wrong exact Fold shape"
 | .ratio _ _ => .error "decay-width prediction has the wrong exact Fold shape"
 | .label _ => .error "decay-width prediction has the wrong exact Fold shape"
 | .pair _ _ => .error "decay-width prediction has the wrong exact Fold shape"
 | .table _ => .error "decay-width prediction has the wrong exact Fold shape"
end SFT.Physics.DecayWidthPrediction
