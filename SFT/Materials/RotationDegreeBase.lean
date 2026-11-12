import SFT.Materials.RotationCoprime
import SFT.Mathematics.OrbitTilingCount
namespace SFT.Materials.RotationDegreeBase
open RotationTotient RotationCoprime RotationFactorPrimality
open SFT.Mathematics.OrbitTilingCount SFT.Physics.SpatialStability
open SFT.Foundation.FractionReduction

theorem nodupUnique (xs : List Nat) (h : xs.Nodup) : Unique xs := by
 induction h with
 | nil => trivial
 | @cons a xs absent rest ih => exact ⟨fun member => absent a member rfl,ih⟩

theorem residuesUnique (n : PositiveCount) : Unique (residues n) :=
 uniqueFilter _ _ (nodupUnique _ (positiveCountUnique n.val))

theorem degreeEqualsReducedCount (n : PositiveCount) (above : 1 < n.val) :
 (totientCount n).val = (reducedResidues n.val).length := by
 apply sameMembersLength _ _ (residuesUnique n) (uniqueFilter _ _ (positiveRanksUnique n.val))
 intro c
 constructor
 · intro h
   have h := (exactCoprimeResidues n c).mp h
   have ne : c ≠ n.val := by
     intro eq
     have g := h.2.2
     rw [eq,gcdSelf] at g
     exact Nat.ne_of_gt above g
   exact (reducedResidueMember n.val c n.property).mpr
     ⟨h.1,Nat.lt_of_le_of_ne h.2.1 ne,h.2.2⟩
 · intro h
   have h := (reducedResidueMember n.val c n.property).mp h
   exact (exactCoprimeResidues n c).mpr ⟨h.1,Nat.le_of_lt h.2.1,h.2.2⟩

theorem primeDegree (p : PositiveCount) (prime : Prime p.val) :
 (totientCount p).val = p.val-1 :=
 (degreeEqualsReducedCount p prime.1).trans (primeReducedCount p.val prime)

theorem admittedPrimeBound (p : PositiveCount) (prime : Prime p.val)
 (admitted : crystallographicRotationAdmitted p = true) : p.val ≤ 3 := by
 have h := (admittedDegree p).mp admitted
 change (totientCount p).val ≤ 2 at h
 rw [primeDegree p prime] at h
 have reconstruct := subtractAdd p.val 1 p.property
 have bound := Nat.succ_le_succ h
 change p.val-1+1 ≤ 3 at bound
 rw [reconstruct] at bound
 exact bound
end SFT.Materials.RotationDegreeBase
