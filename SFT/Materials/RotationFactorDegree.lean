import SFT.Materials.RotationDegreeFresh
namespace SFT.Materials.RotationFactorDegree
open RotationTotient RotationCoprime RotationDegreeBase RotationDegreeLift RotationDegreeProduct RotationDegreeFresh
open RotationFactors RotationFactorDivisibility RotationFactorPrimality RotationPrimeSupport
open SFT.Foundation.FractionReduction

theorem factorDegreeDivides (n : Nat) (hn : 0 < n) (p : Nat) (prime : Prime p) (pn : p ∣ n) :
 p-1 ∣ (totientCount ⟨n,hn⟩).val := by
 induction n using Nat.strongRecOn with
 | ind n ih =>
   have hp : 0 < p := Nat.lt_trans (by decide) prime.1
   have positive := quotientPositive n p hn hp pn
   have factor := quotientFactor n p hp pn
   let m : PositiveCount := ⟨n/p,positive⟩
   have same : productOrder p prime m = (⟨n,hn⟩ : PositiveCount) := Subtype.eq factor.symm
   by_cases repeated : m.val%p=0
   · have before := quotientSmaller n p hn prime.1 (zeroRemainderOfDivides p n hp pn)
     have prior := ih m.val before positive (dividesFromRemainder m.val p hp repeated)
     rw [←same,repeatedPrimeDegree p prime m (dividesFromRemainder m.val p hp repeated)]
     obtain ⟨k,hk⟩ := prior
     exact ⟨p*k,by rw [hk,←mulAssoc,Nat.mul_comm p (p-1),mulAssoc]⟩
   · rw [←same,freshPrimeDegree p prime m repeated]
     exact ⟨(totientCount m).val,rfl⟩

theorem admittedFactorBound (n : PositiveCount) (admitted : crystallographicRotationAdmitted n = true)
 (p : Nat) (prime : Prime p) (pn : p ∣ n.val) : p ≤ 3 := by
 have divides := factorDegreeDivides n.val n.property p prime pn
 have bound := divisorBound (p-1) (totientCount n).val (totientCount n).property divides
 have small := (admittedDegree n).mp admitted
 have result := Nat.succ_le_succ (Nat.le_trans bound small)
 change p-1+1 ≤ 3 at result
 rw [subtractAdd p 1 (Nat.lt_trans (by decide) prime.1)] at result
 exact result

theorem admittedFactorTwoOrThree (n : PositiveCount) (admitted : crystallographicRotationAdmitted n = true)
 (p : Nat) (prime : Prime p) (pn : p ∣ n.val) : p=2 ∨ p=3 := by
 cases Nat.eq_or_lt_of_le (admittedFactorBound n admitted p prime pn) with
 | inl three => exact Or.inr three
 | inr below => exact Or.inl (Nat.le_antisymm (Nat.le_of_lt_succ below) prime.1)

theorem divisorDegreeBound (p : Nat) (prime : Prime p) (n : PositiveCount) :
 (totientCount n).val ≤ (totientCount (productOrder p prime n)).val := by
 by_cases repeated : n.val%p=0
 · rw [repeatedPrimeDegree p prime n (dividesFromRemainder n.val p (Nat.lt_trans (by decide) prime.1) repeated)]
   have h := Nat.mul_le_mul_right (totientCount n).val (Nat.le_trans (by decide : 1 ≤ 2) prime.1)
   rw [Nat.one_mul] at h
   exact h
 · rw [freshPrimeDegree p prime n repeated]
   have positive : 1 ≤ p-1 := by
     cases p with
     | zero => cases prime.1
     | succ p => exact Nat.le_of_succ_le_succ prime.1
   have h := Nat.mul_le_mul_right (totientCount n).val positive
   rw [Nat.one_mul] at h
   exact h
end SFT.Materials.RotationFactorDegree
