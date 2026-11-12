import SFT.Materials.RotationPrimePower
import SFT.Mathematics.OrbitBinaryDepth
namespace SFT.Materials.RotationDegreeLift
open RotationTotient RotationCoprime RotationDegreeBase RotationResidueBlocks
open SFT.Physics.SpatialStability SFT.Mathematics.OrbitTilingCount SFT.Mathematics.OrbitOrderIdentity
open SFT.Mathematics.OrbitBinaryDepth SFT.Foundation.FractionReduction
open SFT.Mathematics.CategoryPaths SFT.Foundation.CommonRefinement

def eligible (n bound : Nat) : List Nat :=
 (positiveCounts bound).filter (fun c => decide (1 = Nat.gcd c n))

theorem eligibleMember (n bound c : Nat) : c ∈ eligible n bound ↔
 0 < c ∧ c ≤ bound ∧ Nat.gcd c n = 1 := by
 constructor
 · intro h
   have h := (filterMember _ _ _).mp h
   have bounds := (positiveCountMembership _ _).mp h.1
   exact ⟨bounds.1,bounds.2,(of_decide_eq_true h.2).symm⟩
 · intro h
   exact (filterMember _ _ _).mpr ⟨(positiveCountMembership _ _).mpr ⟨h.1,h.2.1⟩,decide_eq_true h.2.2.symm⟩

theorem eligibleUnique (n bound : Nat) : Unique (eligible n bound) :=
 uniqueFilter _ _ (nodupUnique _ (positiveCountUnique bound))

theorem originalDegree (n : PositiveCount) : (eligible n.val n.val).length = (totientCount n).val := by
 apply sameMembersLength _ _ (eligibleUnique _ _) (residuesUnique n)
 intro c
 exact (eligibleMember _ _ _).trans (exactCoprimeResidues n c).symm

theorem eligibleShift (xs : List Nat) (n k : Nat) (hn : 0 < n) :
 (xs.map (fun c => n*k+c)).filter (fun c => decide (1 = Nat.gcd c n)) =
 (xs.filter (fun c => decide (1 = Nat.gcd c n))).map (fun c => n*k+c) := by
 induction xs with
 | nil => rfl
 | cons a xs ih =>
   have same : Nat.gcd (n*k+a) n = Nat.gcd a n := by
     apply sameRemainderSameGcd _ _ _ hn
     rw [Nat.add_comm]
     exact moduloAddMultiple a n k hn
   rw [List.map_cons,filterHead,filterHead,same]
   cases decide (1 = Nat.gcd a n) <;> rw [ih] <;> rfl

theorem liftedDegree (n : PositiveCount) (k : Nat) :
 (eligible n.val (n.val*k)).length = k*(totientCount n).val := by
 induction k with
 | zero => rw [Nat.mul_zero,Nat.zero_mul]; rfl
 | succ k ih =>
   rw [Nat.mul_succ]
   unfold eligible
   rw [positiveCountsAdd,filterAppend,eligibleShift _ _ _ n.property,appendLength,mapLength]
   change (eligible n.val (n.val*k)).length+(eligible n.val n.val).length = _
   rw [ih,originalDegree,Nat.succ_mul]
end SFT.Materials.RotationDegreeLift
