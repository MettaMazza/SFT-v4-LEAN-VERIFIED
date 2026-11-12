import SFT.Materials.RotationFactorDegree
namespace SFT.Materials.RotationSmallDegrees
open RotationTotient RotationFactorPrimality RotationFactorDivisibility RotationPrimePower
open RotationDegreeProduct RotationDegreeFresh SFT.Foundation.FractionReduction

theorem primeTwo : Prime 2 := by
 refine ⟨by decide,?_⟩
 intro d divides
 have bound := divisorBound d 2 (by decide) divides
 cases d with
 | zero => exact False.elim (zeroCannotDivide 2 (by decide) divides)
 | succ d =>
   cases d with
   | zero => exact Or.inl rfl
   | succ d =>
     cases d with
     | zero => exact Or.inr rfl
     | succ d => exact False.elim (Nat.not_succ_le_self 2 (Nat.le_trans (Nat.succ_le_succ (Nat.succ_le_succ (Nat.succ_le_succ (Nat.zero_le d)))) bound))

theorem primeThree : Prime 3 := by
 refine ⟨by decide,?_⟩
 intro d divides
 have bound := divisorBound d 3 (by decide) divides
 cases d with
 | zero => exact False.elim (zeroCannotDivide 3 (by decide) divides)
 | succ d =>
   cases d with
   | zero => exact Or.inl rfl
   | succ d =>
     cases d with
     | zero =>
       have impossible := zeroRemainderOfDivides 2 3 (by decide) divides
       cases impossible
     | succ d =>
       cases d with
       | zero => exact Or.inr rfl
       | succ d => exact False.elim (Nat.not_succ_le_self 3 (Nat.le_trans (Nat.succ_le_succ (Nat.succ_le_succ (Nat.succ_le_succ (Nat.succ_le_succ (Nat.zero_le d))))) bound))

theorem degreeOne : (totientCount ⟨1,by decide⟩).val = 1 := by
 have h := RotationDegreeBase.residuesUnique (⟨1,by decide⟩ : PositiveCount)
 apply SFT.Mathematics.OrbitTilingCount.sameMembersLength _ [1] h ⟨(fun h => by cases h),True.intro⟩
 intro c
 constructor
 · intro held
   have h := (RotationCoprime.exactCoprimeResidues ⟨1,by decide⟩ c).mp held
   have eq : c=1 := Nat.le_antisymm h.2.1 h.1
   cases eq; exact List.Mem.head _
 · intro held
   cases held with
   | head => exact oneRetained _
   | tail _ impossible => cases impossible

theorem degreeTwo : (totientCount ⟨2,by decide⟩).val = 1 := primePowerDegree 2 0 primeTwo
theorem degreeThree : (totientCount ⟨3,by decide⟩).val = 2 := primePowerDegree 3 0 primeThree
theorem degreeFour : (totientCount ⟨4,by decide⟩).val = 2 := primePowerDegree 2 1 primeTwo

theorem degreeSix : (totientCount ⟨6,by decide⟩).val = 2 := by
 have h := freshPrimeDegree 2 primeTwo ⟨3,by decide⟩ (by decide)
 rw [degreeThree] at h
 exact h

theorem degreeEight : (totientCount ⟨8,by decide⟩).val = 4 := primePowerDegree 2 2 primeTwo
theorem degreeNine : (totientCount ⟨9,by decide⟩).val = 6 := primePowerDegree 3 1 primeThree

theorem degreeTwelve : (totientCount ⟨12,by decide⟩).val = 4 := by
 have h := repeatedPrimeDegree 2 primeTwo ⟨6,by decide⟩ ⟨3,rfl⟩
 rw [degreeSix] at h
 exact h

theorem degreeEighteen : (totientCount ⟨18,by decide⟩).val = 6 := by
 have h := repeatedPrimeDegree 3 primeThree ⟨6,by decide⟩ ⟨2,rfl⟩
 rw [degreeSix] at h
 exact h
end SFT.Materials.RotationSmallDegrees
