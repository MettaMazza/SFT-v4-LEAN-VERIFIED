import SFT.Materials.RotationFactorSupport
import SFT.Physics.SpatialStability
namespace SFT.Materials.RotationTotient
open RotationFactors RotationFactorSupport SFT.Mathematics.DiscreteObjects
open SFT.Physics.SpatialStability SFT.Foundation.ExactValueIdentity
abbrev PositiveCount := {n : Nat // 0 < n}

def passes (candidate : Nat) (factors : List Nat) : Bool :=
 factors.all (fun p => !(candidate % p == 0))

def residues (order : PositiveCount) : List Nat :=
 (positiveCounts order.val).filter (fun candidate => passes candidate (factorLoop order.val 2 order.property (by decide)))

theorem nonzeroCheck (n : Nat) : (!(n == 0)) = true ↔ n ≠ 0 := by
 cases n with
 | zero => constructor; intro h; cases h; intro h; exact False.elim (h rfl)
 | succ n => constructor; intro _ eq; cases eq; intro _; rfl

theorem residueMembership (order : PositiveCount) (candidate : Nat) :
 candidate ∈ residues order ↔ 0 < candidate ∧ candidate ≤ order.val ∧
   ∀ p, p ∈ factorLoop order.val 2 order.property (by decide) → candidate % p ≠ 0 := by
 constructor
 · intro held
   have h := (filterMemberIff _ _ _).mp held
   have bound := (positiveCountMembership _ _).mp h.1
   refine ⟨bound.1,bound.2,?_⟩
   intro p hp
   exact (nonzeroCheck _).mp ((allTrueIffMembers _ _).mp h.2 p hp)
 · intro h
   apply (filterMemberIff _ _ _).mpr
   refine ⟨(positiveCountMembership _ _).mpr ⟨h.1,h.2.1⟩,?_⟩
   exact (allTrueIffMembers _ _).mpr (fun p hp => (nonzeroCheck _).mpr (h.2.2 p hp))

theorem oneRetained (order : PositiveCount) : 1 ∈ residues order := by
 apply (residueMembership order 1).mpr
 refine ⟨by decide,order.property,?_⟩
 intro p hp
 have gt := originalFactorsExceedOne order.val order.property p hp
 rw [moduloBelow 1 p (Nat.lt_trans (by decide) gt) gt]
 exact Nat.noConfusion

theorem countPositive (order : PositiveCount) : 0 < (residues order).length := by
 have held := oneRetained order
 cases eq : residues order with
 | nil => rw [eq] at held; cases held
 | cons x xs => exact Nat.zero_lt_succ _

def totientCount (order : PositiveCount) : PositiveCount :=
 ⟨(residues order).length,countPositive order⟩

def crystallographicRotationAdmitted (order : PositiveCount) : Bool :=
 decide ((totientCount order).val ≤ 2)

theorem admittedDegree (order : PositiveCount) : crystallographicRotationAdmitted order = true ↔
 (residues order).length ≤ 2 := by
 constructor
 · intro h; exact of_decide_eq_true h
 · intro h; exact decide_eq_true h
end SFT.Materials.RotationTotient
