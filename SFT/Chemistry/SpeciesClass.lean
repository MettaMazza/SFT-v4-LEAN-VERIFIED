import SFT.Chemistry.EntityIdentity
import SFT.InformationScience.EntropyPartition
namespace SFT.Chemistry.SpeciesClass
open SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

structure Member where
 entity : EntityIdentity.Entity
 accessible : List String
 timescale : String

def sameSupport (a b : List String) : Prop := ∀ state, state ∈ a ↔ state ∈ b

def equivalent (a b : Member) : Prop :=
 EntityIdentity.sameIdentity a.entity b.entity ∧ sameSupport a.accessible b.accessible ∧ a.timescale = b.timescale

def classContains (support : List Member) (representative member : Member) : Prop :=
 member ∈ support ∧ equivalent representative member

theorem equivalentReflexive (a : Member) : equivalent a a :=
 ⟨rfl,fun _ => ⟨id,id⟩,rfl⟩
theorem equivalentSymmetric (a b : Member) (same : equivalent a b) : equivalent b a :=
 ⟨same.1.symm,fun state => (same.2.1 state).symm,same.2.2.symm⟩
theorem equivalentTransitive (a b c : Member) (ab : equivalent a b) (bc : equivalent b c) : equivalent a c :=
 ⟨ab.1.trans bc.1,fun state => (ab.2.1 state).trans (bc.2.1 state),ab.2.2.trans bc.2.2⟩

theorem completeClass (support : List Member) (a b : Member) :
 classContains support a b ↔ b ∈ support ∧
 a.entity.record = b.entity.record ∧
 (∀ state, state ∈ a.accessible ↔ state ∈ b.accessible) ∧ a.timescale = b.timescale :=
 ⟨id,id⟩

theorem everyMemberCovered (support : List Member) (a : Member) (held : a ∈ support) :
 classContains support a a := ⟨held,equivalentReflexive a⟩

theorem equivalentRepresentatives (support : List Member) (a b : Member) (same : equivalent a b)
 (member : Member) : classContains support a member ↔ classContains support b member :=
 ⟨fun held => ⟨held.1,equivalentTransitive b a member (equivalentSymmetric a b same) held.2⟩,
 fun held => ⟨held.1,equivalentTransitive a b member same held.2⟩⟩

theorem overlappingClassesAgree (support : List Member) (a b member : Member)
 (left : classContains support a member) (right : classContains support b member) : equivalent a b :=
 equivalentTransitive a member b left.2 (equivalentSymmetric b member right.2)

theorem leastRequiredQuotient (relation : Member → Member → Prop)
 (retains : ∀ a b, relation a b → a.entity.record = b.entity.record ∧
 sameSupport a.accessible b.accessible ∧ a.timescale = b.timescale)
 (a b : Member) (same : relation a b) : equivalent a b := retains a b same

theorem singletonBase (a : Member) : classContains [a] a a :=
 ⟨List.Mem.head _,equivalentReflexive a⟩

theorem successorRetains (support : List Member) (a member fresh : Member)
 (held : classContains support a member) : classContains (support ++ [fresh]) a member :=
 ⟨List.mem_append_left _ held.1,held.2⟩

theorem admittedSuccessorJoins (support : List Member) (a fresh : Member)
 (same : equivalent a fresh) : classContains (support ++ [fresh]) a fresh :=
 ⟨List.mem_append_right _ (List.Mem.head _),same⟩

theorem mixedIdentityRejected (support : List Member) (a b : Member)
 (different : a.entity.record ≠ b.entity.record) : ¬ classContains support a b :=
 fun held => different held.2.1

theorem differentSupportRejected (support : List Member) (a b : Member)
 (state : String) (left : state ∈ a.accessible) (right : ¬ state ∈ b.accessible) :
 ¬ classContains support a b := fun held => right ((held.2.2.1 state).mp left)

theorem differentTimescaleRejected (support : List Member) (a b : Member)
 (different : a.timescale ≠ b.timescale) : ¬ classContains support a b :=
 fun held => different held.2.2.2

-- A more resolving declared boundary may split a class, but cannot merge
-- a distinction retained at the earlier boundary.
theorem refinedBoundaryClass (support : List Member) (a member : Member)
 (refined : Member → Member → Prop)
 (retains : ∀ x y, refined x y → equivalent x y)
 (held : member ∈ support ∧ refined a member) : classContains support a member :=
 ⟨held.1,retains a member held.2⟩

end SFT.Chemistry.SpeciesClass
