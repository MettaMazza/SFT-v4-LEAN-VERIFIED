import SFT.Materials.RotationFactorPrimality
import SFT.Mathematics.OrbitOrderIdentity
namespace SFT.Materials.RotationPrimeSupport
open RotationFactors RotationFactorSupport RotationFactorDivisibility RotationFactorPrimality
open SFT.Foundation.FractionReduction

theorem primeProduct (p a b : Nat) (prime : Prime p) (divides : p ∣ a*b) : p ∣ a ∨ p ∣ b := by
 by_cases left : a % p = 0
 · exact Or.inl (dividesFromRemainder a p (Nat.lt_trans (by decide) prime.1) left)
 · have gcdParts := gcdDivides a p
   have reduced : Nat.gcd a p=1 := by
     cases prime.2 _ gcdParts.2 with
     | inl one => exact one
     | inr same => rw [same] at gcdParts; exact False.elim (left (zeroRemainderOfDivides p a (Nat.lt_trans (by decide) prime.1) gcdParts.1))
   exact Or.inr (SFT.Mathematics.OrbitOrderIdentity.cancelReducedFactor a p b
     (Nat.lt_trans (by decide) prime.1) reduced divides)

theorem primePower (p d k : Nat) (prime : Prime p) (divides : p ∣ d^k) : p ∣ d := by
 induction k with
 | zero => exact False.elim (Nat.not_le_of_gt prime.1 (divisorBound p 1 (by decide) divides))
 | succ k ih =>
   rw [Nat.pow_succ] at divides
   cases primeProduct p (d^k) d prime divides with
   | inl earlier => exact ih earlier
   | inr current => exact current

theorem otherPrimeSurvivesStrip (s : FactorState) (p : Nat) (prime : Prime p)
 (trial : Prime s.divisor) (different : p ≠ s.divisor) (divides : p ∣ s.remainder) :
 p ∣ (strip s.remainder s.divisor s.positive s.lower).val := by
 obtain ⟨k,hk⟩ := strippedPower s.divisor s.lower ⟨s.remainder,s.positive⟩
 have productDivides : p ∣ s.divisor^k * (strip s.remainder s.divisor s.positive s.lower).val := by
   rw [←hk]; exact divides
 cases primeProduct _ _ _ prime productDivides with
 | inr retained => exact retained
 | inl removed =>
   have trialDivides := primePower _ _ _ prime removed
   cases trial.2 p trialDivides with
   | inl one => rw [one] at prime; exact False.elim (Nat.lt_irrefl _ prime.1)
   | inr same => exact False.elim (different same)

theorem everyPrimeFound (s : FactorState) : NoEarlierDivisor s.remainder s.divisor →
 ∀ p, Prime p → p ∣ s.remainder → p ∈ factorRun s := by
 apply factorOrder.wf.induction s
 intro current ih prior p prime divides
 rw [factorEquation]
 unfold factorBody
 split
 · rename_i bound
   split
   · rename_i trialDivides
     by_cases same : p=current.divisor
     · cases same; exact List.Mem.head _
     · have trial := trialPrime _ _ current.lower prior
         (dividesFromRemainder _ _ (Nat.lt_trans (by decide) current.lower) trialDivides)
       have retained := otherPrimeSurvivesStrip current p prime trial same divides
       exact List.Mem.tail _ (ih _ (measureDecreases _ _ _
         (strip current.remainder current.divisor current.positive current.lower).property.2
         (divisorWithin _ _ current.lower bound)) (strippingPreservesExclusion current prior) p prime retained)
   · rename_i notDivisible
     have nextPrior := successorExclusion _ _ prior (fun h =>
       notDivisible (zeroRemainderOfDivides _ _ (Nat.lt_trans (by decide) current.lower) h))
     exact ih ⟨current.remainder,current.divisor+1,current.positive,Nat.lt_trans current.lower (Nat.lt_succ_self _)⟩
       (measureDecreases _ _ _ (Nat.le_refl _) (divisorWithin _ _ current.lower bound)) nextPrior p prime divides
 · rename_i finished
   split
   · rename_i positive
     have final := finalPrime _ _ positive prior finished
     cases final.2 p divides with
     | inl one => rw [one] at prime; exact False.elim (Nat.lt_irrefl _ prime.1)
     | inr same => cases same; exact List.Mem.head _
   · rename_i atMostOne
     have one : current.remainder=1 := Nat.le_antisymm (Nat.le_of_not_gt atMostOne) current.positive
     rw [one] at divides
     exact False.elim (Nat.not_le_of_gt prime.1 (divisorBound p 1 (by decide) divides))

theorem exactPrimeSupport (order : Nat) (positive : 0 < order) (p : Nat) :
 p ∈ factorLoop order 2 positive (by decide) ↔ Prime p ∧ p ∣ order := by
 constructor
 · intro held
   exact ⟨originalFactorsPrime order positive p held,everyFactorDivides _ p held⟩
 · intro h
   exact everyPrimeFound _ (initialExclusion order) p h.1 h.2
end SFT.Materials.RotationPrimeSupport
