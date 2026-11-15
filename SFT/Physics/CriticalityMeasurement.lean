import SFT.Physics.CriticalityExperiment
namespace SFT.Physics.CriticalityMeasurement
open SFT.Host SFT.Host.Canonical CoupledMapCriticality RunningConvergenceMeasurement LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def truth : Value → Bool
 | .null => false
 | .boolean b => b
 | .integer n => decide (n≠0)
 | .text s => !s.isEmpty
 | .array xs => !xs.isEmpty
 | .object fields => !fields.isEmpty
structure Analysis where
 generatedLabelCount : Nat
 forcedThreshold : Rat
 belowControl : Rat
 boundary : Rat
 aboveControl : Rat
 multipliers : List Rat
 classes : List String
 directLowerBoundMatches : Bool
 criterionInputs : Value
 topologyDependentBounds : Bool
 finiteExample : List Value
 adverseCriticalBehavior : List Value
 topologyIndependenceNotClaimed : Bool
 completeTargetRowCount : Nat
 analyticValueImported : Bool
def exactMeasurementAnalysis (target : Value) : Except String Analysis := do
 let threshold ← holdingThreshold (.integer 2)
 let below := normalize 1 3 (by decide)
 let above := normalize 2 3 (by decide)
 let rows ← match target with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "TypeError"
 pure ⟨2,threshold,below,threshold,above,
  ← [below,threshold,above].mapM (retainedTransverseMultiplier (.integer 2)),
  ← [below,threshold,above].mapM (stabilityClass (.integer 2)),
  sameValue (← field target "normalized-zero-eigenratio-lower-bound") (.text "half-One") && threshold==normalize 1 2 (by decide),
  ← field target "criterion_inputs",
  truth (← field target "threshold_lower_label") && truth (← field target "threshold_upper_label") && truth (← field target "transverse_rate_relation"),
  [← field target "finite_example_member_count",← field target "finite_example_coupling",← field target "finite_example_critical_alpha"],
  [← field target "finite_time_distribution",← field target "outside_window_behavior"],
  sameValue (← field target "topology_independence_claimed") (.boolean false),rows.length,false⟩
def analysisValue (a : Analysis) : Value :=
 let frac := CoupledMapCriticalityEvidence.frac
 .object [("generated_label_count",.integer (.ofNat a.generatedLabelCount)),("forced_threshold",frac a.forcedThreshold),("below_control",frac a.belowControl),("boundary",frac a.boundary),("above_control",frac a.aboveControl),("multipliers",.array (a.multipliers.map frac)),("classes",.array (a.classes.map Value.text)),("direct_lower_bound_matches",.boolean a.directLowerBoundMatches),("criterion_inputs_retained",a.criterionInputs),("topology_dependent_bounds_retained",.boolean a.topologyDependentBounds),("finite_example_retained",.array a.finiteExample),("adverse_critical_behavior_retained",.array a.adverseCriticalBehavior),("topology_independence_not_claimed",.boolean a.topologyIndependenceNotClaimed),("complete_target_row_count",.integer (.ofNat a.completeTargetRowCount)),("analytic_or_decimal_value_used_as_proof",.boolean a.analyticValueImported)]
end SFT.Physics.CriticalityMeasurement
