import SFT.Materials.RotationFactorSupport
namespace SFT.Materials.RotationFactorDivisibility
open RotationFactors RotationFactorSupport SFT.Foundation.FractionReduction

theorem composeDivides (a b c : Nat) (ab : a ∣ b) (bc : b ∣ c) : a ∣ c := by
 obtain ⟨x,hx⟩ := ab
 obtain ⟨y,hy⟩ := bc
 refine ⟨x*y,?_⟩
 exact hy.trans ((congrArg (fun t => t*y) hx).trans (mulAssoc a x y))

theorem zeroRemainderOfDivides (d r : Nat) (hd : 0 < d) (divides : d ∣ r) : r%d=0 := by
 obtain ⟨k,hk⟩ := divides
 rw [hk]
 have split := remainderQuotient (d*k) d hd
 rw [divisionMultiple d k hd] at split
 cases eq : (d*k)%d with
 | zero => rfl
 | succ n =>
   rw [eq] at split
   have lt : d*k < (n+1)+d*k := Nat.lt_add_of_pos_left (Nat.zero_lt_succ n)
   rw [split] at lt
   exact False.elim (Nat.lt_irrefl _ lt)

theorem strippedDivides (d : Nat) (hd : 1 < d) (s : StripState) :
 (strip s.val d s.property hd).val ∣ s.val := by
 obtain ⟨k,hk⟩ := strippedPower d hd s
 exact ⟨d^k,hk.trans (Nat.mul_comm _ _)⟩

theorem everyFactorDivides (s : FactorState) : ∀ p, p ∈ factorRun s → p ∣ s.remainder := by
 apply factorOrder.wf.induction s
 intro current ih p held
 rw [factorEquation] at held
 unfold factorBody at held
 split at held
 · rename_i bound
   split at held
   · rename_i divides
     cases held with
     | head => exact dividesFromRemainder _ _ (Nat.lt_trans (by decide) current.lower) divides
     | tail _ ht =>
       have reduced := ih _ (measureDecreases _ _ _
         (strip current.remainder current.divisor current.positive current.lower).property.2
         (divisorWithin _ _ current.lower bound)) p ht
       exact composeDivides _ _ _ reduced (strippedDivides current.divisor current.lower ⟨current.remainder,current.positive⟩)
   · exact ih ⟨current.remainder,current.divisor+1,current.positive,Nat.lt_trans current.lower (Nat.lt_succ_self _)⟩ (measureDecreases _ _ _ (Nat.le_refl _) (divisorWithin _ _ current.lower bound)) p held
 · split at held
   · cases held with
     | head => exact ⟨1,(Nat.mul_one _).symm⟩
     | tail _ ht => cases ht
   · cases held

def NoEarlierDivisor (r d : Nat) : Prop := ∀ k, 1 < k → k < d → ¬ k ∣ r

theorem initialExclusion (r : Nat) : NoEarlierDivisor r 2 := by
 intro k lower upper
 exact False.elim (Nat.not_lt_of_ge lower upper)

theorem successorExclusion (r d : Nat) (prior : NoEarlierDivisor r d)
 (current : ¬ d ∣ r) : NoEarlierDivisor r (d+1) := by
 intro k hk bound
 cases Nat.eq_or_lt_of_le (Nat.le_of_lt_succ bound) with
 | inl same => cases same; exact current
 | inr smaller => exact prior k hk smaller

theorem strippingPreservesExclusion (s : FactorState)
 (prior : NoEarlierDivisor s.remainder s.divisor) :
 NoEarlierDivisor (strip s.remainder s.divisor s.positive s.lower).val (s.divisor+1) := by
 apply successorExclusion
 · intro k hk bound divides
   exact prior k hk bound (composeDivides _ _ _ divides (strippedDivides s.divisor s.lower ⟨s.remainder,s.positive⟩))
 · intro divides
   exact strippedNotDivisible s.divisor s.lower ⟨s.remainder,s.positive⟩
     (zeroRemainderOfDivides _ _ (Nat.lt_trans (by decide) s.lower) divides)
end SFT.Materials.RotationFactorDivisibility
