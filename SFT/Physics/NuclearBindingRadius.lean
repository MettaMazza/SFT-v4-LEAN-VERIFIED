import SFT.Physics.NuclearBindingCurve
namespace SFT.Physics.NuclearBindingRadius
open LeptonIntervals VacuumLedgerProofs GeneratorOperations NuclearBindingCurve
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
-- The source whole-count loop. The decreasing natural remainder is an
-- execution measure, never an additional scientific cutoff.
def lowerScan (mass : Nat) : Nat → Nat → Nat
 | 0,lower => lower
 | n+1,lower => if (lower+1)^3 ≤ mass then lowerScan mass n (lower+1) else lower
def lowerWhole (mass lower : Nat) : Nat := lowerScan mass (mass-lower) lower
-- Exhaustion is possible only when the next whole cube already exceeds mass.
theorem exhaustedStops (mass lower : Nat) (done : mass-lower=0) : ¬ (lower+1)^3 ≤ mass := by
 intro h
 have square : lower+1 ≤ (lower+1)*(lower+1) := Nat.le_mul_of_pos_right _ (Nat.zero_lt_succ lower)
 have cubic : lower+1 ≤ (lower+1)*(lower+1)*(lower+1) := Nat.le_trans square (Nat.mul_le_mul_right (lower+1) square)
 rw [Nat.pow_succ,Nat.pow_succ,Nat.pow_succ,Nat.pow_zero,Nat.one_mul] at h
 have bound := Nat.le_trans cubic h
 have before : lower < mass := Nat.lt_of_lt_of_le (Nat.lt_succ_self lower) bound
 exact Nat.ne_of_gt (SFT.Foundation.ExactCast.subtractPositive mass lower before) done
inductive WholeTrace (mass : Nat) : Nat → Nat → Prop where
 | stop (lower : Nat) : ¬ (lower+1)^3 ≤ mass → WholeTrace mass lower lower
 | step (lower result : Nat) : (lower+1)^3 ≤ mass → WholeTrace mass (lower+1) result → WholeTrace mass lower result
theorem scanTrace (mass fuel lower : Nat) (enough : mass-lower ≤ fuel) :
 WholeTrace mass lower (lowerScan mass fuel lower) := by
 induction fuel generalizing lower with
 | zero =>
   exact .stop lower (exhaustedStops mass lower (Nat.eq_zero_of_le_zero enough))
 | succ fuel ih =>
   if h : (lower+1)^3 ≤ mass then
    rw [lowerScan,ite_eq_left h]
    apply WholeTrace.step lower _ h
    apply ih
    rw [Nat.sub_succ]
    exact Nat.pred_le_pred enough
   else
    rw [lowerScan,ite_eq_right h]
    exact .stop lower h
theorem wholeLoopCorrespondence (mass lower : Nat) : WholeTrace mass lower (lowerWhole mass lower) :=
 scanTrace mass (mass-lower) lower (Nat.le_refl _)
def cube (r : Rat) := multiply (multiply r r) r
def refine (mass : Rat) : Nat → Rat × Rat → Rat × Rat
 | 0,bounds => bounds
 | n+1,(lower,upper) =>
   let mid := midpoint lower upper
   refine mass n (if (cube mid).blt mass then (mid,upper) else (lower,mid))
def exactCubeRootEnclosure : CountInput → CountInput → Except String (Rat × Rat)
 | .boolean _,_ => .error "mass support begins with the binary composite"
 | .integer a,refs => do
   if a < 2 then throw "mass support begins with the binary composite"
   match refs with
   | .boolean _ => throw "refinement count must be positive"
   | .integer n =>
     if n < 1 then throw "refinement count must be positive"
     let lower := lowerWhole a.toNat 1
     if lower^3 == a.toNat then pure (wholeRatio lower,wholeRatio lower) else
      let mass := normalize a 1 (by decide)
      let bounds := refine mass n.toNat (wholeRatio lower,wholeRatio (lower+1))
      if !(cube bounds.1).blt mass || !mass.blt (cube bounds.2) then throw "rational cube-root enclosure failed"
      pure bounds
def bindingScoreEnclosure (a z refs : CountInput) : Except String (Rat × Rat) := do
 let radius ← exactCubeRootEnclosure a refs
 let retained ← nonradialRetention a z
 let radial ← netRadialLoss a z
 let lower ← RunningConvergence.positiveTake retained (← LeptonRatios.divide radial radius.1)
 let upper ← RunningConvergence.positiveTake retained (← LeptonRatios.divide radial radius.2)
 if upper.blt lower then throw "binding enclosure reversed"
 pure (lower,upper)
def continuousVertexEnclosure (a refs : CountInput) : Except String (Rat × Rat) := do
 let bounds ← exactCubeRootEnclosure a refs
 let alpha ← electromagneticShare
 let binary ← AlphaCovers.binaryCount
 match a with
 | .boolean _ => throw "mass support begins with the binary composite"
 | .integer a =>
   let mass := normalize a 1 (by decide)
   let vertex := fun radius => LeptonRatios.divide (multiply mass (add radius alpha))
     (add (multiply (wholeRatio binary) radius) (multiply (multiply (wholeRatio binary) alpha) mass))
   let lower ← vertex bounds.1
   let upper ← vertex bounds.2
   if upper.blt lower then throw "vertex enclosure reversed"
   pure (lower,upper)
theorem cutoffWhole : lowerWhole 4096 1 = 16 := rfl
theorem originalCutoffRadius : exactCubeRootEnclosure (.integer 4096) (.integer 1) = .ok (wholeRatio 16,wholeRatio 16) := rfl
end SFT.Physics.NuclearBindingRadius
