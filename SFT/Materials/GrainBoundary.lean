import SFT.Materials.Lattice
import SFT.Mathematics.GraphPathSoundness
namespace SFT.Materials.GrainBoundary
open SFT.Mathematics.GraphOperations
open SFT.Mathematics.DiscreteObjects

-- Obligation21: orientation labels are held crystal observations.
structure Carrier where
 lattice : Lattice.Record
 orientation : String → String
 provenance : SFT.Host.Canonical.Value
 boundary : String

def adjacent (carrier : Carrier) (a b : String) : Prop :=
 (a,b) ∈ carrier.lattice.cells.graph.edges ∨ (b,a) ∈ carrier.lattice.cells.graph.edges

theorem adjacencySymmetric (carrier : Carrier) {a b : String}
 (h : adjacent carrier a b) : adjacent carrier b a :=
 match h with | .inl h => .inr h | .inr h => .inl h

inductive Joined (carrier : Carrier) : String → String → Prop where
 | identity (a : String) (held : a ∈ carrier.lattice.cells.graph.nodes) : Joined carrier a a
 | append {a b c : String} (prior : Joined carrier a b) (edge : adjacent carrier b c)
     (coherent : carrier.orientation b = carrier.orientation c) : Joined carrier a c

variable {carrier : Carrier} {a b c : String}

theorem adjacentHeld (edge : adjacent carrier a b) :
 a ∈ carrier.lattice.cells.graph.nodes ∧ b ∈ carrier.lattice.cells.graph.nodes := by
 have endpoints := acceptedGraphEndpoints carrier.lattice.cells.nodes carrier.lattice.cells.edges
   carrier.lattice.cells.graph carrier.lattice.cells.generated
 cases edge with
 | inl h => exact endpoints (a,b) h
 | inr h => have h := endpoints (b,a) h; exact ⟨h.2,h.1⟩

theorem joinedHeld (joined : Joined carrier a b) :
 a ∈ carrier.lattice.cells.graph.nodes ∧ b ∈ carrier.lattice.cells.graph.nodes := by
 induction joined with
 | identity held => exact ⟨held,held⟩
 | append prior edge coherent ih => exact ⟨ih.1,(adjacentHeld edge).2⟩

theorem joinedOrientation (joined : Joined carrier a b) : carrier.orientation a = carrier.orientation b := by
 induction joined with
 | identity => rfl
 | append prior edge coherent ih => exact ih.trans coherent

theorem joinedTransitive (first : Joined carrier a b) (second : Joined carrier b c) : Joined carrier a c := by
 induction second with
 | identity => exact first
 | append prior edge coherent ih => exact .append ih edge coherent

theorem joinedSymmetric (joined : Joined carrier a b) : Joined carrier b a := by
 induction joined with
 | identity held => exact .identity _ held
 | @append b c prior edge coherent ih =>
   exact joinedTransitive (.append (.identity c (adjacentHeld edge).2)
     (adjacencySymmetric _ edge) coherent.symm) ih

def grain (carrier : Carrier) (root site : String) : Prop := Joined carrier root site

theorem grainCoherent (left : grain carrier a b) (right : grain carrier a c) :
 carrier.orientation b = carrier.orientation c := (joinedOrientation left).symm.trans (joinedOrientation right)

theorem grainConnected (left : grain carrier a b) (right : grain carrier a c) : Joined carrier b c :=
 joinedTransitive (joinedSymmetric left) right

-- A complete adjacent path in a proposed region retains every intermediate site.
inductive RegionPath (carrier : Carrier) (region : String → Prop) : String → String → Prop where
 | identity (a : String) (held : a ∈ carrier.lattice.cells.graph.nodes) (inside : region a) : RegionPath carrier region a a
 | append {a b c : String} (prior : RegionPath carrier region a b) (edge : adjacent carrier b c)
     (inside : region c) : RegionPath carrier region a c

theorem regionPathStarts {region : String → Prop} (path : RegionPath carrier region a b) : region a := by
 induction path with
 | identity held inside => exact inside
 | append prior edge inside ih => exact ih

theorem regionPathEnds {region : String → Prop} (path : RegionPath carrier region a b) : region b := by
 cases path with
 | identity held inside => exact inside
 | append prior edge inside => exact inside

theorem homogeneousPathJoins {region : String → Prop}
 (coherent : ∀ x y, region x → region y → carrier.orientation x = carrier.orientation y)
 (path : RegionPath carrier region a b) : Joined carrier a b := by
 induction path with
 | identity held inside => exact .identity _ held
 | append prior edge inside ih => exact .append ih edge (coherent _ _ (regionPathEnds prior) inside)

theorem grainMaximal {region : String → Prop} (root : String)
 (coherent : ∀ x y, region x → region y → carrier.orientation x = carrier.orientation y)
 (connected : ∀ site, region site → RegionPath carrier region root site) :
 ∀ site, region site → grain carrier root site := by
 intro site inside
 exact homogeneousPathJoins coherent (connected site inside)

theorem grainHasInternalPaths (joined : Joined carrier a b) : RegionPath carrier (grain carrier a) a b := by
 induction joined with
 | identity held => exact .identity _ held (.identity _ held)
 | append prior edge coherent ih => exact .append ih edge (.append prior edge coherent)

theorem sharedSiteSameGrain (left : grain carrier a c) (right : grain carrier b c) (site : String) :
 grain carrier a site ↔ grain carrier b site := by
 have ab := joinedTransitive left (joinedSymmetric right)
 constructor
 · intro h; exact joinedTransitive (joinedSymmetric ab) h
 · intro h; exact joinedTransitive ab h

def boundaryEdges (carrier : Carrier) : List Edge :=
 carrier.lattice.cells.graph.edges.filter (fun edge => decide (carrier.orientation edge.1 ≠ carrier.orientation edge.2))

theorem exactBoundaryMembership (edge : Edge) : edge ∈ boundaryEdges carrier ↔
 edge ∈ carrier.lattice.cells.graph.edges ∧ carrier.orientation edge.1 ≠ carrier.orientation edge.2 := by
 have h := filterMemberIff (fun edge : Edge => decide (carrier.orientation edge.1 ≠ carrier.orientation edge.2))
   carrier.lattice.cells.graph.edges edge
 constructor
 · intro member
   have h := h.mp member
   exact ⟨h.1,of_decide_eq_true h.2⟩
 · intro h'
   exact h.mpr ⟨h'.1,decide_eq_true h'.2⟩

theorem adjacentDistinctGrainsExactly (edge : (a,b) ∈ carrier.lattice.cells.graph.edges) :
 ¬ Joined carrier a b ↔ carrier.orientation a ≠ carrier.orientation b := by
 constructor
 · intro separate same
   exact separate (.append (.identity a (adjacentHeld (Or.inl edge)).1) (Or.inl edge) same)
 · intro different joined; exact different (joinedOrientation joined)

theorem boundarySeparatesExactly (edge : Edge) : edge ∈ boundaryEdges carrier ↔
 edge ∈ carrier.lattice.cells.graph.edges ∧ ¬ Joined carrier edge.1 edge.2 := by
 constructor
 · intro h
   have h := (exactBoundaryMembership edge).mp h
   exact ⟨h.1,(adjacentDistinctGrainsExactly h.1).mpr h.2⟩
 · intro h
   exact (exactBoundaryMembership edge).mpr ⟨h.1,(adjacentDistinctGrainsExactly h.1).mp h.2⟩
end SFT.Materials.GrainBoundary
