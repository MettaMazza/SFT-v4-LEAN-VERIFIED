import SFT.Materials.RotationResidueBlocks
namespace SFT.Materials.RotationPrimePower
open RotationFactors RotationFactorDivisibility RotationFactorPrimality RotationPrimeSupport RotationTotient
open RotationCoprime RotationDegreeBase RotationResidueBlocks
open SFT.Foundation.FractionReduction SFT.Physics.SpatialStability SFT.Mathematics.OrbitTilingCount

def primePowerOrder (p k : Nat) (prime : Prime p) : PositiveCount :=
 ⟨p^(k+1),Nat.pow_pos (Nat.lt_trans (by decide) prime.1)⟩

theorem primeDividesPower (p k : Nat) : p ∣ p^(k+1) :=
 ⟨p^k,(Nat.pow_succ p k).trans (Nat.mul_comm _ _)⟩

theorem powerResidue (p k : Nat) (prime : Prime p) (c : Nat) :
 c ∈ residues (primePowerOrder p k prime) ↔
 0 < c ∧ c ≤ p^(k+1) ∧ c%p ≠ 0 := by
 constructor
 · intro held
   have h := (residueMembership _ c).mp held
   refine ⟨h.1,h.2.1,?_⟩
   exact h.2.2 p ((exactPrimeSupport _ _ p).mpr ⟨prime,primeDividesPower p k⟩)
 · intro h
   apply (residueMembership _ c).mpr
   refine ⟨h.1,h.2.1,?_⟩
   intro q held
   have support := (exactPrimeSupport _ _ q).mp held
   have qp := primePower q p (k+1) support.1 support.2
   cases prime.2 q qp with
   | inl one =>
     have above := support.1.1
     rw [one] at above
     exact False.elim (Nat.lt_irrefl _ above)
   | inr same => rw [same]; exact h.2.2

theorem primePowerDegree (p k : Nat) (prime : Prime p) :
 (totientCount (primePowerOrder p k prime)).val = p^k*(p-1) := by
 have same : (residues (primePowerOrder p k prime)).length =
     (nonmultiples (p^(k+1)) p).length := by
   apply sameMembersLength _ _ (residuesUnique _) (uniqueFilter _ _ (nodupUnique _ (positiveCountUnique _)))
   intro c
   constructor
   · intro h
     have h := (powerResidue p k prime c).mp h
     exact (filterMember _ _ _).mpr
       ⟨(positiveCountMembership _ _).mpr ⟨h.1,h.2.1⟩,(nonzeroCheck _).mpr h.2.2⟩
   · intro h
     have h := (filterMember _ _ _).mp h
     have bounds := (positiveCountMembership _ _).mp h.1
     exact (powerResidue p k prime c).mpr ⟨bounds.1,bounds.2,(nonzeroCheck _).mp h.2⟩
   
 change (residues (primePowerOrder p k prime)).length = _
 rw [same,Nat.pow_succ,Nat.mul_comm (p^k) p]
 exact blockCount p (p^k) (Nat.lt_trans (by decide) prime.1)

theorem primePowerFactorDegree (p k : Nat) (prime : Prime p) :
 p-1 ∣ (totientCount (primePowerOrder p k prime)).val :=
 ⟨p^k,(primePowerDegree p k prime).trans (Nat.mul_comm _ _)⟩

theorem powerLinearBound (p k : Nat) (base : 1 < p) : k+1 ≤ p^k := by
 induction k with
 | zero => exact Nat.le_refl _
 | succ k ih =>
   have positive : 0 < p^k := Nat.pow_pos (Nat.lt_trans (by decide) base)
   have step : p^k+1 ≤ p^k+p^k := Nat.add_le_add_left positive _
   have twice : p^k+p^k ≤ p^k*p := by
     have h := Nat.mul_le_mul_left (p^k) base
     rw [Nat.mul_succ,Nat.mul_one] at h
     exact h
   have bound := Nat.le_trans (Nat.succ_le_succ ih) (Nat.le_trans step twice)
   rw [Nat.pow_succ]
   exact bound

theorem binaryExponentBound (k : Nat) (prime : Prime 2)
 (admitted : crystallographicRotationAdmitted (primePowerOrder 2 k prime) = true) : k ≤ 1 := by
 have h := (admittedDegree _).mp admitted
 change (totientCount (primePowerOrder 2 k prime)).val ≤ 2 at h
 rw [primePowerDegree] at h
 change 2^k*1 ≤ 2 at h
 rw [Nat.mul_one] at h
 exact Nat.le_of_succ_le_succ (Nat.le_trans (powerLinearBound 2 k (by decide)) h)

theorem ternaryExponentBound (k : Nat) (prime : Prime 3)
 (admitted : crystallographicRotationAdmitted (primePowerOrder 3 k prime) = true) : k = 0 := by
 have h := (admittedDegree _).mp admitted
 change (totientCount (primePowerOrder 3 k prime)).val ≤ 2 at h
 rw [primePowerDegree] at h
 change 3^k*2 ≤ 2 at h
 cases k with
 | zero => rfl
 | succ k =>
   have lower : 2 ≤ 3^(k+1) := Nat.le_trans (Nat.succ_le_succ (Nat.zero_lt_succ k)) (powerLinearBound 3 (k+1) (by decide))
   have four := Nat.mul_le_mul_right 2 lower
   exact False.elim (Nat.not_succ_le_self 2 (Nat.le_trans (by decide : 3 ≤ 2*2) (Nat.le_trans four h)))
end SFT.Materials.RotationPrimePower
