import SFT.Physics.FusionFissionYieldThresholdProofs
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.YieldThresholdPrediction
open SFT.Host SFT.Host.Canonical FusionFissionYieldThreshold LeptonIntervals
set_option maxRecDepth 20000
def positiveRatio (q : Rat) : Except String CapabilityValues.Value := do
 if !zero.blt q then throw "formal yield input must remain exact and positive"
 let n ← CapabilityValues.count q.num.toNat
 let d ← CapabilityValues.count q.den
 pure (.ratio n d)
def countValue (n : Nat) : Except String CapabilityValues.Value := do pure (.count (← CapabilityValues.count n))
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let o ← exactReleaseOrder
 let t ← thresholdTopology
 let trace ← fissionThresholdTrace
 pure [("fusion_per_nucleon_lower",← positiveRatio o.fusionPerNucleon.1),("fusion_per_nucleon_upper",← positiveRatio o.fusionPerNucleon.2),("fission_per_nucleon_lower",← positiveRatio o.fissionPerNucleon.1),("fission_per_nucleon_upper",← positiveRatio o.fissionPerNucleon.2),("fusion_total_lower",← positiveRatio o.fusionTotal.1),("fusion_total_upper",← positiveRatio o.fusionTotal.2),("fission_total_lower",← positiveRatio o.fissionTotal.1),("fission_total_upper",← positiveRatio o.fissionTotal.2),("fusion_conserved_mass",← countValue 4),("fission_conserved_mass",← countValue 238),("fusion_charge_path_count",← countValue (t.fusionInterBoundaryPaths.getD 0)),("fission_internal_boundary_cells",← countValue trace.internalBoundaryCells),("per_nucleon_order",.label (← CapabilityValues.heldLabel "yield-order" "fusion-greater-per-nucleon")),("total_order",.label (← CapabilityValues.heldLabel "yield-order" "fission-greater-total")),("fusion_threshold",.label (← CapabilityValues.heldLabel "threshold-carrier" "charged-boundary-approach")),("fission_threshold",.label (← CapabilityValues.heldLabel "threshold-carrier" "neutral-capture-or-internal-surface")),("fission_inter_boundary",.label (← CapabilityValues.heldLabel "structural-absence" "empty-form")),("threshold_scope",.label (← CapabilityValues.heldLabel "threshold-scope" "normalized-structure-with-reaction-specific-dimensions")),("access_carrier",.label (← CapabilityValues.heldLabel "reaction-access" "thermal-or-directed-energy-support")),("metric_retention",.label (← CapabilityValues.heldLabel "measurement-metric" "retain-per-nucleon-and-total-separately"))]
def experimentId : String := "SFT-EXP-PHYS-NUCLEAR-FUSION-FISSION-YIELD-THRESHOLD-006"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "yield/threshold prediction has the wrong exact Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "yield/threshold prediction has the wrong exact Fold shape"
 | .count _ => .error "yield/threshold prediction has the wrong exact Fold shape"
 | .ratio _ _ => .error "yield/threshold prediction has the wrong exact Fold shape"
 | .label _ => .error "yield/threshold prediction has the wrong exact Fold shape"
 | .pair _ _ => .error "yield/threshold prediction has the wrong exact Fold shape"
 | .table _ => .error "yield/threshold prediction has the wrong exact Fold shape"
end SFT.Physics.YieldThresholdPrediction
