import SFT.Mathematics.SelfSimilarConvergence
namespace SFT.Physics.BoundaryGrowthDiscriminator
open SFT.Foundation.FractionReduction
open SFT.Mathematics.SelfSimilarConvergence

-- source_boundary_growth.py: exact powers of a/b with a>b>0.
-- The bound is derived from the held input, not a fixed search depth.
theorem successorBudget (b n : Nat) : b*(b+(n+1)) ≤ (b+n)*(b+1) := by
 have identity : (b+n)*(b+1) = b*(b+(n+1))+n := by
  conv => lhs; simp only [addMul,Nat.mul_add,Nat.mul_one,Nat.add_assoc,Nat.add_comm,Nat.add_left_comm,Nat.mul_comm]
  all_goals (conv => rhs; simp only [addMul,Nat.mul_add,Nat.mul_one,Nat.add_assoc,Nat.add_comm,Nat.add_left_comm,Nat.mul_comm])
 rw [identity]
 exact Nat.le_add_right _ _

theorem exactPowerLowerBound (a b n : Nat) (above : b+1 ≤ a) :
 b^n*(b+n) ≤ b*a^n := by
 induction n with
 | zero => change 1*(b+0) ≤ b*1; rw [Nat.add_zero,Nat.one_mul,Nat.mul_one]; exact Nat.le_refl _
 | succ n ih =>
  rw [Nat.pow_succ,Nat.pow_succ]
  calc
   b^n*b*(b+(n+1)) = b^n*(b*(b+(n+1))) := mulAssoc _ _ _
   _ ≤ b^n*((b+n)*(b+1)) := Nat.mul_le_mul_left _ (successorBudget b n)
   _ = (b^n*(b+n))*(b+1) := (mulAssoc _ _ _).symm
   _ ≤ (b*a^n)*a := Nat.mul_le_mul ih above
   _ = b*(a^n*a) := mulAssoc _ _ _

def strictExcessBound (b upperNumerator : Nat) : Nat := b*upperNumerator+1

theorem derivedStrictExcess (a b u : Nat) (positive : 0 < b) (above : b+1 ≤ a) :
 u*b^(strictExcessBound b u) < a^(strictExcessBound b u) := by
 let n := strictExcessBound b u
 have inside : u*b < b+n := by
  have first : u*b < n := by
   change u*b < b*u+1
   rw [Nat.mul_comm u b]
   exact Nat.lt_succ_self _
  exact Nat.lt_of_lt_of_le first (Nat.le_add_left n b)
 have strict := Nat.mul_lt_mul_of_pos_left inside (Nat.pow_pos positive (n:=n))
 have bound := exactPowerLowerBound a b n above
 have result := Nat.lt_of_lt_of_le strict bound
 have rearrange : b^n*(u*b) = b*(u*b^n) := by
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm]
  all_goals (conv => rhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm])
 rw [rearrange] at result
 exact Nat.lt_of_not_ge (fun contrary => Nat.not_le_of_gt result (Nat.mul_le_mul_left b contrary))

theorem anyPositiveUpperDenominator (a b u v : Nat)
 (positive : 0 < b) (above : b+1 ≤ a) (denominator : 0 < v) :
 u*b^(strictExcessBound b u) < v*a^(strictExcessBound b u) := by
 have h := derivedStrictExcess a b u positive above
 exact Nat.lt_of_lt_of_le h (Nat.le_mul_of_pos_left _ denominator)

theorem strictExcessSuccessor (a b u v n : Nat) (positive : 0 < b) (above : b ≤ a)
 (excess : u*b^n < v*a^n) : u*b^(n+1) < v*a^(n+1) := by
 rw [Nat.pow_succ,Nat.pow_succ,← mulAssoc,← mulAssoc]
 exact Nat.lt_of_lt_of_le (Nat.mul_lt_mul_of_pos_right excess positive)
   (Nat.mul_le_mul_left _ above)

theorem everyLaterPowerExcluded (a b u v n extra : Nat) (positive : 0 < b) (above : b ≤ a)
 (excess : u*b^n < v*a^n) : u*b^(n+extra) < v*a^(n+extra) := by
 induction extra with
 | zero => exact excess
 | succ extra ih => exact strictExcessSuccessor a b u v (n+extra) positive above ih

theorem completeDerivedTailExcluded (a b u v extra : Nat)
 (positive : 0 < b) (above : b+1 ≤ a) (denominator : 0 < v) :
 u*b^(strictExcessBound b u+extra) < v*a^(strictExcessBound b u+extra) :=
 everyLaterPowerExcluded a b u v _ extra positive (Nat.le_trans (Nat.le_succ _) above)
   (anyPositiveUpperDenominator a b u v positive above denominator)

def inInterval (a b lower lowerDen upper upperDen exponent : Nat) : Bool :=
 decide (lower*b^exponent ≤ lowerDen*a^exponent) &&
 decide (upperDen*a^exponent ≤ upper*b^exponent)

def allCompatible (a b lower lowerDen upper upperDen : Nat) : List Nat :=
 ((List.range (strictExcessBound b upper)).map (fun n => n+1)).filter
   (inInterval a b lower lowerDen upper upperDen)

theorem syntheticCubic : allCompatible 3 1 27 1 27 1 = [3] := rfl
theorem syntheticInterval : allCompatible 2 1 7 1 9 1 = [3] := rfl

theorem allAtOrBeyondExcluded (a b u v n : Nat)
 (positive : 0 < b) (above : b+1 ≤ a) (denominator : 0 < v)
 (later : strictExcessBound b u ≤ n) : u*b^n < v*a^n := by
 induction later with
 | refl => exact anyPositiveUpperDenominator a b u v positive above denominator
 | @step n h ih => exact strictExcessSuccessor a b u v n positive (Nat.le_trans (Nat.le_succ _) above) ih

theorem everyCompatibleExponentBelowBound (a b u v n : Nat)
 (positive : 0 < b) (above : b+1 ≤ a) (denominator : 0 < v)
 (compatible : v*a^n ≤ u*b^n) : n < strictExcessBound b u :=
 Nat.lt_of_not_ge (fun later =>
   Nat.not_le_of_gt (allAtOrBeyondExcluded a b u v n positive above denominator later) compatible)

def fullIntervalCensus (a b lower lowerDen upper upperDen : Nat) : Nat → Nat → List Nat
 | _,0 => []
 | n,fuel+1 =>
   let rest := fullIntervalCensus a b lower lowerDen upper upperDen (n+1) fuel
   if upperDen*a^n ≤ upper*b^n then
     if lower*b^n ≤ lowerDen*a^n then n::rest else rest
   else rest

def sourceStopScan (a b lower lowerDen upper upperDen : Nat) : Nat → Nat → List Nat
 | _,0 => []
 | n,fuel+1 =>
   if upperDen*a^n ≤ upper*b^n then
     let rest := sourceStopScan a b lower lowerDen upper upperDen (n+1) fuel
     if lower*b^n ≤ lowerDen*a^n then n::rest else rest
   else []

theorem censusAfterExcessEmpty (a b lower lowerDen upper upperDen fuel n : Nat)
 (positive : 0 < b) (above : b ≤ a) (excess : upper*b^n < upperDen*a^n) :
 fullIntervalCensus a b lower lowerDen upper upperDen n fuel = [] := by
 induction fuel generalizing n with
 | zero => rfl
 | succ fuel ih =>
   unfold fullIntervalCensus
   rw [if_neg (Nat.not_le_of_gt excess)]
   exact ih (n+1) (strictExcessSuccessor a b upper upperDen n positive above excess)

theorem stopScanRetainsCompleteFamily (a b lower lowerDen upper upperDen fuel n : Nat)
 (positive : 0 < b) (above : b ≤ a) :
 sourceStopScan a b lower lowerDen upper upperDen n fuel =
 fullIntervalCensus a b lower lowerDen upper upperDen n fuel := by
 induction fuel generalizing n with
 | zero => rfl
 | succ fuel ih =>
   let scan := sourceStopScan a b lower lowerDen upper upperDen (n+1) fuel
   let census := fullIntervalCensus a b lower lowerDen upper upperDen (n+1) fuel
   change (if upperDen*a^n ≤ upper*b^n then
     (if lower*b^n ≤ lowerDen*a^n then n::scan else scan) else []) =
     (if upperDen*a^n ≤ upper*b^n then
     (if lower*b^n ≤ lowerDen*a^n then n::census else census) else census)
   cases (inferInstance : Decidable (upperDen*a^n ≤ upper*b^n)) with
   | isTrue within =>
     rw [ite_eq_left within,ite_eq_left within]
     exact congrArg (fun rest => if lower*b^n ≤ lowerDen*a^n then n::rest else rest) (ih (n+1))
   | isFalse outside =>
     rw [ite_eq_right outside,ite_eq_right outside]
     exact (censusAfterExcessEmpty a b lower lowerDen upper upperDen fuel (n+1)
       positive above (strictExcessSuccessor a b upper upperDen n positive above
         (Nat.lt_of_not_ge outside))).symm

def compatiblePositiveExponents (a b lower lowerDen upper upperDen : Nat) : List Nat :=
 sourceStopScan a b lower lowerDen upper upperDen 1 (strictExcessBound b upper)

theorem originalCubicScan : compatiblePositiveExponents 3 1 27 1 27 1 = [3] := rfl
theorem originalIntervalScan : compatiblePositiveExponents 2 1 7 1 9 1 = [3] := rfl

def firstExcess (a b upper upperDen : Nat) : Nat → Nat → Nat
 | n,0 => n
 | n,fuel+1 => if upperDen*a^n ≤ upper*b^n then firstExcess a b upper upperDen (n+1) fuel else n

theorem firstExcessStopsAbove (a b upper upperDen fuel n : Nat)
 (endExcess : upper*b^(n+fuel) < upperDen*a^(n+fuel)) :
 upper*b^(firstExcess a b upper upperDen n fuel) < upperDen*a^(firstExcess a b upper upperDen n fuel) := by
 induction fuel generalizing n with
 | zero => exact endExcess
 | succ fuel ih =>
   change upper*b^(if upperDen*a^n ≤ upper*b^n then firstExcess a b upper upperDen (n+1) fuel else n) <
     upperDen*a^(if upperDen*a^n ≤ upper*b^n then firstExcess a b upper upperDen (n+1) fuel else n)
   cases (inferInstance : Decidable (upperDen*a^n ≤ upper*b^n)) with
   | isTrue within =>
     rw [ite_eq_left within]
     apply ih
     rw [Nat.succ_add]
     exact endExcess
   | isFalse outside =>
     rw [ite_eq_right outside]
     exact Nat.lt_of_not_ge outside

def monotonicStopCertificate (a b upper upperDen : Nat) : Bool :=
 let n := firstExcess a b upper upperDen 1 (strictExcessBound b upper)
 decide (upper*b^n < upperDen*a^n) && decide (a^n*b^(n+1) < a^(n+1)*b^n)

theorem originalStopIndex : firstExcess 5 2 40 1 1 (strictExcessBound 2 40) = 5 := rfl
theorem originalStopCertificate : monotonicStopCertificate 5 2 40 1 = true := rfl

theorem positivePowerSuccessor (a b n : Nat) (positive : 0 < b) (above : b < a) :
 a^n*b^(n+1) < a^(n+1)*b^n := by
 have pa : 0<a := Nat.lt_trans positive above
 have h := Nat.mul_lt_mul_of_pos_left above (Nat.mul_pos (Nat.pow_pos pa (n:=n)) (Nat.pow_pos positive (n:=n)))
 rw [Nat.pow_succ,Nat.pow_succ]
 have left : a^n*(b^n*b) = (a^n*b^n)*b := (mulAssoc _ _ _).symm
 have right : (a^n*a)*b^n = (a^n*b^n)*a := by
  rw [mulAssoc,Nat.mul_comm a (b^n),← mulAssoc]
 rw [left,right]
 exact h

theorem originalMethodAlwaysCloses (a b upper upperDen : Nat)
 (positive : 0 < b) (above : b+1 ≤ a) (denominator : 0 < upperDen) :
 monotonicStopCertificate a b upper upperDen = true := by
 let n := firstExcess a b upper upperDen 1 (strictExcessBound b upper)
 have endBound := allAtOrBeyondExcluded a b upper upperDen (1+strictExcessBound b upper)
   positive above denominator (Nat.le_add_left _ _)
 have stopped := firstExcessStopsAbove a b upper upperDen (strictExcessBound b upper) 1 endBound
 have successor := positivePowerSuccessor a b n positive above
 change (decide (upper*b^n < upperDen*a^n) && decide (a^n*b^(n+1) < a^(n+1)*b^n)) = true
 rw [decide_eq_true stopped,decide_eq_true successor]
 rfl

open SFT.Physics.FoldFirstReturn SFT.Physics.LeptonIntervals

def checkedFractions (distance lower upper : Rat) : Except String (List Nat) :=
 let one := normalize 1 1 (by decide)
 if !one.blt distance then .error "ValueError: distance ratio must be greater than the One"
 else if !one.blt lower || upper.blt lower then
   .error "ValueError: response-ratio interval must be positive, ordered and above the One"
 else .ok (compatiblePositiveExponents distance.num.natAbs distance.den
   lower.num.natAbs lower.den upper.num.natAbs upper.den)

def checkedCompatible : Input → Input → Input → Except String (List Nat)
 | .fraction distance,.fraction lower,.fraction upper => checkedFractions distance lower upper
 | .nonFraction,_,_ => .error "ValueError: boundary-growth comparison requires exact fractions"
 | .fraction _,.nonFraction,_ => .error "ValueError: boundary-growth comparison requires exact fractions"
 | .fraction _,.fraction _,.nonFraction => .error "ValueError: boundary-growth comparison requires exact fractions"

def checkedStopCertificate (distance upper : Rat) : Except String Bool :=
 let one := normalize 1 1 (by decide)
 if !one.blt distance || !one.blt upper then
   .error "ValueError: monotonic certificate requires ratios above the One"
 else .ok (monotonicStopCertificate distance.num.natAbs distance.den upper.num.natAbs upper.den)

theorem allFractionInputsRetainOriginalGuards (distance lower upper : Rat) :
 checkedCompatible (.fraction distance) (.fraction lower) (.fraction upper) =
 checkedFractions distance lower upper := rfl

theorem originalCheckedCubic : checkedCompatible
 (.fraction (normalize 3 1 (by decide))) (.fraction (normalize 27 1 (by decide)))
 (.fraction (normalize 27 1 (by decide))) = .ok [3] := rfl

theorem originalCheckedInterval : checkedCompatible
 (.fraction (normalize 2 1 (by decide))) (.fraction (normalize 7 1 (by decide)))
 (.fraction (normalize 9 1 (by decide))) = .ok [3] := rfl

theorem originalCheckedStop : checkedStopCertificate
 (normalize 5 2 (by decide)) (normalize 40 1 (by decide)) = .ok true := rfl
end SFT.Physics.BoundaryGrowthDiscriminator

#print axioms SFT.Physics.BoundaryGrowthDiscriminator.successorBudget
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.exactPowerLowerBound
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.strictExcessBound
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.derivedStrictExcess
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.anyPositiveUpperDenominator
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.strictExcessSuccessor
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.everyLaterPowerExcluded
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.completeDerivedTailExcluded
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.inInterval
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.allCompatible
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.syntheticCubic
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.syntheticInterval
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.allAtOrBeyondExcluded
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.everyCompatibleExponentBelowBound
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.fullIntervalCensus
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.sourceStopScan
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.censusAfterExcessEmpty
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.stopScanRetainsCompleteFamily
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.compatiblePositiveExponents
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.originalCubicScan
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.originalIntervalScan
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.firstExcess
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.firstExcessStopsAbove
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.monotonicStopCertificate
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.originalStopIndex
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.originalStopCertificate
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.positivePowerSuccessor
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.originalMethodAlwaysCloses
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.checkedFractions
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.checkedCompatible
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.checkedStopCertificate
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.allFractionInputsRetainOriginalGuards
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.originalCheckedCubic
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.originalCheckedInterval
#print axioms SFT.Physics.BoundaryGrowthDiscriminator.originalCheckedStop
