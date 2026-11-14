import SFT.Physics.CoupledEnsembleSynchronizationCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.SynchronizationPrediction
open SFT.Host SFT.Host.Canonical CoupledEnsembleSynchronizationCertificate LeptonIntervals
set_option maxRecDepth 20000
def positiveRatio (value : Int) : Except String CapabilityValues.Value := do
 if value < 1 then throw "formal prediction input must be positive"
 let n ← CapabilityValues.count value.toNat
 let d ← CapabilityValues.count 1
 pure (.ratio n d)
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let c ← formalCertificate
 pure [
  ("coupling_numerator",← positiveRatio c.uniqueSynchronizingCoupling.num),
  ("coupling_denominator",← positiveRatio (.ofNat c.uniqueSynchronizingCoupling.den)),
  ("pair_relation",.label (← CapabilityValues.heldLabel "pair-synchronization" "equal-moves-reassemble-separation")),
  ("residual_relation",.label (← CapabilityValues.heldLabel "pair-residual" "half-One-empty-off-half-positive")),
  ("terminal_relation",.label (← CapabilityValues.heldLabel "synchronized-ensemble" "common-Fold-successor-preserves-equality")),
  ("scope_relation",.label (← CapabilityValues.heldLabel "synchronization-scope" "pair-boundary-general-ensemble-convergence-separate"))]
def experimentId : String := "SFT-EXP-PHYS-COUPLED-ENSEMBLE-SYNCHRONIZATION-TERMINAL-007"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "coupled-ensemble prediction has wrong Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "coupled-ensemble prediction has wrong Fold shape"
 | .count _ => .error "coupled-ensemble prediction has wrong Fold shape"
 | .ratio _ _ => .error "coupled-ensemble prediction has wrong Fold shape"
 | .label _ => .error "coupled-ensemble prediction has wrong Fold shape"
 | .pair _ _ => .error "coupled-ensemble prediction has wrong Fold shape"
 | .table _ => .error "coupled-ensemble prediction has wrong Fold shape"
end SFT.Physics.SynchronizationPrediction
