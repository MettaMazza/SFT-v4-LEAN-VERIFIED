import SFT.Physics.BoundaryGrowth
import SFT.Mathematics.DiscreteComposition
namespace SFT.Physics.InverseSquareInterval
open SFT.Foundation.ExactOperations SFT.Foundation.Count.TraceDerivation

-- Numerator-derived fuel is a termination certificate, not a search cutoff:
-- for positive denominator d, n*d ≤ u implies n ≤ u.
def scan (lower upper : PositiveFraction) : Nat → Nat → List Nat
 | _,0 => []
 | start,fuel+1 =>
   if start*upper.denominator ≤ upper.numerator then
    let rest := scan lower upper (start+1) fuel
    if lower.numerator ≤ start*lower.denominator then start::rest else rest
   else []

theorem laterAbove (upper : PositiveFraction) (start later : Nat)
 (order : start≤later) (above : upper.numerator<start*upper.denominator) :
 upper.numerator<later*upper.denominator :=
 Nat.lt_of_lt_of_le above (Nat.mul_le_mul_right upper.denominator order)

theorem scanSound (lower upper : PositiveFraction) (fuel start n : Nat)
 (held : n∈scan lower upper start fuel) : start≤n ∧
 lower.numerator≤n*lower.denominator ∧ n*upper.denominator≤upper.numerator := by
 induction fuel generalizing start with
 | zero => cases held
 | succ fuel ih =>
   rw [scan.eq_2] at held
   split at held
   · rename_i inside
     split at held
     · rename_i lowerBound
       cases held with
       | head => exact ⟨Nat.le_refl _,lowerBound,inside⟩
       | tail _ member =>
         have h := ih (start+1) member
         exact ⟨Nat.le_trans (Nat.le_succ start) h.1,h.2⟩
     · have h := ih (start+1) held
       exact ⟨Nat.le_trans (Nat.le_succ start) h.1,h.2⟩
   · cases held

theorem scanComplete (lower upper : PositiveFraction) (fuel start n : Nat)
 (atOrAfter : start≤n) (within : n<start+fuel)
 (lowerBound : lower.numerator≤n*lower.denominator)
 (upperBound : n*upper.denominator≤upper.numerator) : n∈scan lower upper start fuel := by
 induction fuel generalizing start with
 | zero => exact False.elim (Nat.not_lt_of_ge atOrAfter within)
 | succ fuel ih =>
   have inside : start*upper.denominator≤upper.numerator :=
    Nat.le_trans (Nat.mul_le_mul_right _ atOrAfter) upperBound
   rw [scan.eq_2]
   rw [ite_eq_left inside]
   by_cases same : n=start
   · subst n
     rw [ite_eq_left lowerBound]
     exact .head _
   · have next : start+1≤n := Nat.lt_of_le_of_ne atOrAfter (fun eq => same eq.symm)
     have window : n<(start+1)+fuel := by rw [Nat.succ_add]; exact within
     have retained := ih (start+1) next window
     split
     · exact .tail _ retained
     · exact retained

def exponents (lower upper : PositiveFraction) := scan lower upper 1 (upper.numerator+1)

theorem exponentsExactly (lower upper : PositiveFraction) (n : Nat) :
 n∈exponents lower upper ↔ 0<n ∧ lower.numerator≤n*lower.denominator ∧ n*upper.denominator≤upper.numerator := by
 constructor
 · exact scanSound lower upper _ _ n
 · intro h
   apply scanComplete lower upper _ 1 n h.1
   · have bounded : n≤upper.numerator := Nat.le_trans
       (Nat.le_mul_of_pos_right n (Nat.pos_of_ne_zero upper.denominatorNonzero)) h.2.2
     exact Nat.lt_of_le_of_lt bounded (Nat.lt_of_lt_of_le (Nat.lt_succ_self _) (Nat.le_add_left _ 1))
   · exact h.2.1
   · exact h.2.2

open SFT.Physics.FoldFirstReturn SFT.Physics.BoundaryGrowth

def checkedFractions (lower upper : Rat) : Except String (List Nat) :=
 match admitPositive lower with
 | none => .error "ValueError: reported exponent interval must be positive and ordered"
 | some lo => match admitPositive upper with
   | none => .error "ValueError: reported exponent interval must be positive and ordered"
   | some hi =>
     if lo.numerator*hi.denominator ≤ hi.numerator*lo.denominator then .ok (exponents lo hi)
     else .error "ValueError: reported exponent interval must be positive and ordered"

def checked : Input → Input → Except String (List Nat)
 | .nonFraction,_ => .error "ValueError: reported exponent bounds must be exact fractions"
 | .fraction lower,other => match other with
   | .nonFraction => .error "ValueError: reported exponent bounds must be exact fractions"
   | .fraction upper => checkedFractions lower upper

def reportedLower : PositiveFraction := normalizePositive 199999999999999996 100000000000000000 (by decide) (by decide)
def reportedUpper : PositiveFraction := normalizePositive 200000000000000058 100000000000000000 (by decide) (by decide)

theorem reportedCensus : exponents reportedLower reportedUpper=[2] := rfl

theorem reportedChecked : checked (.fraction (asFraction reportedLower)) (.fraction (asFraction reportedUpper))=.ok [2] := rfl

theorem oneBelow : 1*reportedLower.denominator<reportedLower.numerator := by decide

theorem threeAbove : reportedUpper.numerator<3*reportedUpper.denominator := by decide

end SFT.Physics.InverseSquareInterval
