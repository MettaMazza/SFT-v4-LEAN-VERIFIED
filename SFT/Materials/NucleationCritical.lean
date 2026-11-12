import SFT.Materials.NucleationBoundary
namespace SFT.Materials.NucleationCritical
open NucleationBoundary
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects

-- Internal witness search; scientific output below retains every least cluster,
-- so equal-sized persistent clusters are not arbitrarily discarded.
def witness : List Cluster → Option Cluster
 | [] => none
 | first::rest =>
   if persists first then
     match witness rest with
     | none => some first
     | some prior => if first.cells.length ≤ prior.cells.length then some first else some prior
   else witness rest

def Least (family : List Cluster) (cluster : Cluster) : Prop :=
 cluster ∈ family ∧ persists cluster=true ∧
 ∀ other, other ∈ family → persists other=true → cluster.cells.length ≤ other.cells.length

theorem persistentHasWitness (family : List Cluster)
 (present : ∃ x, x∈family ∧ persists x=true) : ∃ y, witness family=some y := by
 induction family with
 | nil => obtain ⟨x,h,_⟩ := present; cases h
 | cons x xs ih =>
   by_cases hp : persists x=true
   · cases ht : witness xs with
     | none =>
       refine ⟨x,?_⟩
       rw [witness,if_pos hp,ht]
     | some y =>
       by_cases le : x.cells.length ≤ y.cells.length
       · refine ⟨x,?_⟩
         rw [witness,if_pos hp,ht]
         exact if_pos le
       · refine ⟨y,?_⟩
         rw [witness,if_pos hp,ht]
         exact if_neg le
   · obtain ⟨z,member,passed⟩ := present
     have tailPresent : ∃ z, z∈xs ∧ persists z=true := by
       cases member with
       | head => exact False.elim (hp passed)
       | tail _ h => exact ⟨z,h,passed⟩
     obtain ⟨y,found⟩ := ih tailPresent
     refine ⟨y,?_⟩
     rw [witness,if_neg hp]
     exact found

theorem witnessSound (family : List Cluster) (cluster : Cluster)
 (found : witness family=some cluster) : Least family cluster := by
 induction family generalizing cluster with
 | nil => cases found
 | cons first rest ih =>
   unfold witness at found
   split at found
   · rename_i passed
     cases tail : witness rest with
     | none =>
       rw [tail] at found
       dsimp only at found
       have same := Option.some.inj found
       cases same
       refine ⟨.head _,passed,?_⟩
       intro other member survives
       cases member with
       | head => exact Nat.le_refl _
       | tail _ held =>
         -- A persistent tail member contradicts the empty search.
         obtain ⟨y,yes⟩ := persistentHasWitness rest ⟨other,held,survives⟩
         rw [tail] at yes
         cases yes
     | some prior =>
       rw [tail] at found
       dsimp only at found
       have lower := ih prior tail
       split at found
       · rename_i le
         have same := Option.some.inj found
         cases same
         refine ⟨.head _,passed,?_⟩
         intro other member survives
         cases member with
         | head => exact Nat.le_refl _
         | tail _ held => exact Nat.le_trans le (lower.2.2 other held survives)
       · rename_i gt
         have same := Option.some.inj found
         cases same
         refine ⟨.tail _ lower.1,lower.2.1,?_⟩
         intro other member survives
         cases member with
         | head => exact Nat.le_of_lt (Nat.lt_of_not_ge gt)
         | tail _ held => exact lower.2.2 other held survives
   · rename_i absent
     have lower := ih cluster found
     refine ⟨.tail _ lower.1,lower.2.1,?_⟩
     intro other member survives
     cases member with
     | head => exact False.elim (absent survives)
     | tail _ held => exact lower.2.2 other held survives

def critical (family : List Cluster) (cluster : Cluster) : Bool :=
 persists cluster && family.all (fun other => !persists other || decide (cluster.cells.length ≤ other.cells.length))

def nuclei (family : List Cluster) := family.filter (critical family)
theorem criticalExactly (family : List Cluster) (cluster : Cluster) : critical family cluster=true ↔
 persists cluster=true ∧ ∀ other, other∈family → persists other=true → cluster.cells.length ≤ other.cells.length := by
 have both : ∀ x y : Bool, (x && y)=true ↔ x=true ∧ y=true := by
   intro x y; cases x <;> cases y <;> decide
 constructor
 · intro passed
   have h := (both _ _).mp passed
   refine ⟨h.1,?_⟩
   intro other member hp
   have check := (allTrueIffMembers _ _).mp h.2 other member
   rw [hp] at check
   exact of_decide_eq_true check
 · intro h
   apply (both _ _).mpr
   refine ⟨h.1,(allTrueIffMembers _ _).mpr ?_⟩
   intro other member
   cases hp : persists other with
   | false => rfl
   | true => exact decide_eq_true (h.2 other member hp)

theorem nucleiExactly (family : List Cluster) (cluster : Cluster) : cluster∈nuclei family ↔ Least family cluster := by
 have h := filterMemberIff (critical family) family cluster
 constructor
 · intro member
   have parts := h.mp member
   exact ⟨parts.1,(criticalExactly family cluster).mp parts.2⟩
 · intro least
   exact h.mpr ⟨least.1,(criticalExactly family cluster).mpr least.2⟩

theorem witnessIncluded (family : List Cluster) (cluster : Cluster) (found : witness family=some cluster) :
 cluster∈nuclei family := (nucleiExactly family cluster).mpr (witnessSound family cluster found)

theorem allLeastHaveSameSize (family : List Cluster) (a b : Cluster)
 (ha : a∈nuclei family) (hb : b∈nuclei family) : a.cells.length=b.cells.length := by
 have aLeast := (nucleiExactly family a).mp ha
 have bLeast := (nucleiExactly family b).mp hb
 exact Nat.le_antisymm (aLeast.2.2 b bLeast.1 bLeast.2.1) (bLeast.2.2 a aLeast.1 aLeast.2.1)
end SFT.Materials.NucleationCritical
