import SFT.Materials.MaterialCarrier
import SFT.Mathematics.GraphPathCompleteness
namespace SFT.Materials.PorousOrganization
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[64]: structural absence is a retained pore support,
-- not a numerical zero or an erased constituent.
structure Record where
 network : GeneratedGraph
 solid : List String
 poreGraph : GeneratedGraph
 completePartition : ∀ x, x ∈ network.nodes ↔ x ∈ solid ∨ x ∈ poreGraph.nodes
 disjoint : ∀ x, x ∈ solid → x ∈ poreGraph.nodes → False
 poreEdges : ∀ e, e ∈ poreGraph.edges ↔ e ∈ network.edges ∧ e.1 ∈ poreGraph.nodes ∧ e.2 ∈ poreGraph.nodes
 access : List String
 accessHeld : ∀ x ∈ access, x ∈ poreGraph.nodes
 interface : List Edge
 computedInterface : crossingCut network solid = .ok interface
 resolution : SFT.Host.Canonical.Value
 accessBoundary : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

def accessible (r : Record) (x : String) : Prop :=
 ∃ a ∈ r.access, PathWitness r.poreGraph a x

theorem poreSupportRetained (r : Record) (x : String) (held : x ∈ r.poreGraph.nodes) : x ∈ r.network.nodes :=
 (r.completePartition x).mpr (.inr held)

theorem solidSupportRetained (r : Record) (x : String) (held : x ∈ r.solid) : x ∈ r.network.nodes :=
 (r.completePartition x).mpr (.inl held)

theorem poreNotSolid (r : Record) (x : String) (held : x ∈ r.poreGraph.nodes) : x ∉ r.solid :=
 fun solid => r.disjoint x solid held

theorem interfaceExactly (r : Record) (e : Edge) : e ∈ r.interface ↔
 e ∈ r.network.edges ∧ (has r.solid e.1 != has r.solid e.2) = true :=
 cutMembership r.network r.solid r.interface r.computedInterface e

theorem accessibleIsPore (r : Record) (x : String) (held : accessible r x) : x ∈ r.poreGraph.nodes := by
 obtain ⟨a,_,path⟩ := held
 exact pathWitnessTarget r.poreGraph a x path

theorem accessibleNotSolid (r : Record) (x : String) (held : accessible r x) : x ∉ r.solid :=
 poreNotSolid r x (accessibleIsPore r x held)

theorem everyAccessPointAccessible (r : Record) (x : String) (held : x ∈ r.access) : accessible r x :=
 ⟨x,held,identityPathWitness r.poreGraph x (r.accessHeld x held)⟩

theorem connectedAccessPropagates (r : Record) (x y : String) (held : accessible r x)
 (path : PathWitness r.poreGraph x y) : accessible r y := by
 obtain ⟨a,ha,prior⟩ := held
 exact ⟨a,ha,composePathWitnesses r.poreGraph a x y prior path⟩

theorem accessSearchSound (r : Record) (a x : String) (entry : a ∈ r.access)
 (found : reachable r.poreGraph a x = true) : accessible r x := by
 refine ⟨a,entry,?_⟩
 apply reachableHasPath r.poreGraph a x
 · intro e held
   have bound := (r.poreEdges e).mp held
   exact ⟨bound.2.1,bound.2.2⟩
 · exact found

theorem accessSearchComplete (r : Record) (a x : String) (path : PathWitness r.poreGraph a x) :
 reachable r.poreGraph a x = true := pathWitnessReachable r.poreGraph a x path

def record (r : Record) := (r,r.interface,r.poreGraph,r.access)

theorem wholeInputRetained (r : Record) : (record r).1 = r := rfl

theorem resolutionRetained (r : Record) : (record r).1.resolution = r.resolution := rfl

def records (rs : List Record) := rs.map record

theorem base (r : Record) : records [r] = [record r] := rfl

theorem successor (rs : List Record) (r : Record) : records (rs++[r]) = records rs++[record r] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.PorousOrganization
