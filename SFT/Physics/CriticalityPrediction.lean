import SFT.Physics.CoupledMapCriticalityCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.CriticalityPrediction
open SFT.Host SFT.Host.Canonical CoupledMapCriticalityCertificate LeptonIntervals
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let c ← criticalityCertificate
 if !c.uniqueThreshold then throw "formal threshold certificate failed"
 pure [("expansion_relation",.label (← CapabilityValues.heldLabel "local-expansion" "complete-generated-m")),("coupling_relation",.label (← CapabilityValues.heldLabel "transverse-residual" "m-times-One-minus-g")),("threshold_relation",.label (← CapabilityValues.heldLabel "neutral-boundary" "m-minus-One-over-m")),("regime_relation",.label (← CapabilityValues.heldLabel "critical-regimes" "below-expands-boundary-neutral-above-contracts")),("scope_relation",.label (← CapabilityValues.heldLabel "topology-scope" "normalized-channel-only-other-eigenfactors-retained")),("analytic_relation",.label (← CapabilityValues.heldLabel "analytic-boundary" "external-symbolic-translation-only"))]
def experimentId : String := "SFT-EXP-PHYS-COUPLED-MAP-CRITICALITY-TERMINAL-008"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "PH3 prediction has wrong Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "PH3 prediction has wrong Fold shape"
 | .count _ => .error "PH3 prediction has wrong Fold shape"
 | .ratio _ _ => .error "PH3 prediction has wrong Fold shape"
 | .label _ => .error "PH3 prediction has wrong Fold shape"
 | .pair _ _ => .error "PH3 prediction has wrong Fold shape"
 | .table _ => .error "PH3 prediction has wrong Fold shape"
end SFT.Physics.CriticalityPrediction
