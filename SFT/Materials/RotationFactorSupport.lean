import SFT.Materials.RotationFactors
namespace SFT.Materials.RotationFactorSupport
open RotationFactors

theorem everyFactorExceedsOne (s : FactorState) : ∀ p, p ∈ factorRun s → 1 < p := by
 apply factorOrder.wf.induction s
 intro current ih p held
 rw [factorEquation] at held
 unfold factorBody at held
 split at held
 · rename_i bound
   split at held
   · rename_i divides
     cases held with
     | head => exact current.lower
     | tail _ ht => exact ih _ (measureDecreases _ _ _
         (strip current.remainder current.divisor current.positive current.lower).property.2
         (divisorWithin _ _ current.lower bound)) p ht
   · exact ih _ (measureDecreases _ _ _ (Nat.le_refl _) (divisorWithin _ _ current.lower bound)) p held
 · split at held
   · rename_i positive
     cases held with
     | head => exact positive
     | tail _ ht => cases ht
   · cases held

theorem originalFactorsExceedOne (order : Nat) (positive : 0 < order)
 (p : Nat) (held : p ∈ factorLoop order 2 positive (by decide)) : 1 < p :=
 everyFactorExceedsOne _ p held
theorem strippedNotDivisible (d : Nat) (hd : 1 < d) (s : StripState) :
 (strip s.val d s.property hd).val % d ≠ 0 := by
 apply stripOrder.wf.induction s
 intro current ih
 rw [stripEquation]
 unfold stripBody
 split
 · rename_i divides
   exact ih _ (quotientSmaller current.val d current.property hd divides)
 · rename_i notDivisible
   exact notDivisible

theorem strippedPower (d : Nat) (hd : 1 < d) (s : StripState) :
 ∃ k, s.val = d^k * (strip s.val d s.property hd).val := by
 apply stripOrder.wf.induction s
 intro current ih
 have equation := stripEquation current.val d current.property hd
 unfold stripBody at equation
 split at equation
 · rename_i divides
   let next : StripState := ⟨current.val/d,SFT.Foundation.FractionReduction.quotientPositive
     current.val d current.property (Nat.lt_trans (by decide) hd)
     (dividesFromRemainder current.val d (Nat.lt_trans (by decide) hd) divides)⟩
   obtain ⟨k,hk⟩ := ih next (quotientSmaller current.val d current.property hd divides)
   refine ⟨k+1,?_⟩
   have exactFactor := SFT.Foundation.FractionReduction.quotientFactor current.val d
     (Nat.lt_trans (by decide) hd)
     (dividesFromRemainder current.val d (Nat.lt_trans (by decide) hd) divides)
   rw [equation,Nat.pow_succ]
   calc
     current.val = d*(current.val/d) := exactFactor
     _ = d*(d^k*(strip (current.val/d) d _ hd).val) := congrArg (fun n => d*n) hk
     _ = (d*d^k)*(strip (current.val/d) d _ hd).val :=
       (SFT.Foundation.FractionReduction.mulAssoc _ _ _).symm
     _ = (d^k*d)*(strip (current.val/d) d _ hd).val :=
       congrArg (fun n => n*(strip (current.val/d) d _ hd).val) (Nat.mul_comm _ _)
 · refine ⟨0,?_⟩
   rw [equation]
   exact (Nat.one_mul _).symm
end SFT.Materials.RotationFactorSupport
