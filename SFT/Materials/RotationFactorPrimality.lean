import SFT.Materials.RotationFactorDivisibility
namespace SFT.Materials.RotationFactorPrimality
open RotationFactors RotationFactorSupport RotationFactorDivisibility SFT.Foundation.FractionReduction

def Prime (p : Nat) : Prop := 1 < p ∧ ∀ q, q ∣ p → q=1 ∨ q=p

theorem zeroCannotDivide (r : Nat) (positive : 0 < r) : ¬ 0 ∣ r := by
 intro ⟨k,hk⟩
 rw [Nat.zero_mul] at hk
 exact Nat.ne_of_gt positive hk

theorem trialPrime (r d : Nat) (hd : 1 < d) (prior : NoEarlierDivisor r d)
 (divides : d ∣ r) : Prime d := by
 refine ⟨hd,?_⟩
 intro q qd
 cases q with
 | zero => exact False.elim (zeroCannotDivide d (Nat.lt_trans (by decide) hd) qd)
 | succ q =>
   cases q with
   | zero => exact Or.inl rfl
   | succ q =>
     have lower : 1 < q+1+1 := Nat.succ_lt_succ (Nat.zero_lt_succ _)
     have bound := divisorBound _ d (Nat.lt_trans (by decide) hd) qd
     cases Nat.eq_or_lt_of_le bound with
     | inl same => exact Or.inr same
     | inr smaller => exact False.elim (prior _ lower smaller (composeDivides _ _ _ qd divides))

theorem finalPrime (r d : Nat) (hr : 1 < r) (prior : NoEarlierDivisor r d)
 (finished : ¬ d*d ≤ r) : Prime r := by
 refine ⟨hr,?_⟩
 intro q qr
 have positive : 0 < r := Nat.lt_trans (by decide) hr
 cases q with
 | zero => exact False.elim (zeroCannotDivide r positive qr)
 | succ q =>
   cases q with
   | zero => exact Or.inl rfl
   | succ q =>
     have qlower : 1 < q+1+1 := Nat.succ_lt_succ (Nat.zero_lt_succ _)
     by_cases same : q+1+1=r
     · exact Or.inr same
     · have qpositive : 0 < q+1+1 := Nat.zero_lt_succ _
       have tpositive := quotientPositive r (q+1+1) positive qpositive qr
       have factor := quotientFactor r (q+1+1) qpositive qr
       have tlower : 1 < r/(q+1+1) := by
         cases ht : r/(q+1+1) with
         | zero => rw [ht] at tpositive; cases tpositive
         | succ t =>
           cases t with
           | zero => rw [ht,Nat.mul_one] at factor; exact False.elim (same factor.symm)
           | succ t => exact Nat.succ_lt_succ (Nat.zero_lt_succ _)
       have tr : r/(q+1+1) ∣ r := ⟨q+1+1,factor.trans (Nat.mul_comm _ _)⟩
       have dq : d ≤ q+1+1 := Nat.le_of_not_gt (fun h => prior _ qlower h qr)
       have dt : d ≤ r/(q+1+1) := Nat.le_of_not_gt (fun h => prior _ tlower h tr)
       have bound := Nat.mul_le_mul dq dt
       rw [←factor] at bound
       exact False.elim (finished bound)

theorem everyEmittedPrime (s : FactorState) : NoEarlierDivisor s.remainder s.divisor →
 ∀ p, p ∈ factorRun s → Prime p := by
 apply factorOrder.wf.induction s
 intro current ih prior p held
 rw [factorEquation] at held
 unfold factorBody at held
 split at held
 · rename_i bound
   split at held
   · rename_i divides
     cases held with
     | head => exact trialPrime _ _ current.lower prior (dividesFromRemainder _ _ (Nat.lt_trans (by decide) current.lower) divides)
     | tail _ ht =>
       exact ih _ (measureDecreases _ _ _
         (strip current.remainder current.divisor current.positive current.lower).property.2
         (divisorWithin _ _ current.lower bound)) (strippingPreservesExclusion current prior) p ht
   · rename_i notDivisible
     have nextPrior := successorExclusion _ _ prior (fun h =>
       notDivisible (zeroRemainderOfDivides _ _ (Nat.lt_trans (by decide) current.lower) h))
     exact ih ⟨current.remainder,current.divisor+1,current.positive,Nat.lt_trans current.lower (Nat.lt_succ_self _)⟩
       (measureDecreases _ _ _ (Nat.le_refl _) (divisorWithin _ _ current.lower bound)) nextPrior p held
 · rename_i finished
   split at held
   · rename_i positive
     cases held with
     | head => exact finalPrime _ _ positive prior finished
     | tail _ ht => cases ht
   · cases held

theorem originalFactorsPrime (order : Nat) (positive : 0 < order) (p : Nat)
 (held : p ∈ factorLoop order 2 positive (by decide)) : Prime p :=
 everyEmittedPrime _ (initialExclusion order) p held
end SFT.Materials.RotationFactorPrimality
