import SFT.Physics.CollectivePhaseOrder
namespace SFT.Physics.CollectiveSuperconductivity

-- Auxiliary facts about endpoint momentum readings on complete band paths.
-- Unequal readings are not identified with V3 momentum randomization.
-- The source dissipative-transition binding is separate from these facts.
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects SFT.Mathematics.FoldScalar
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

deriving instance DecidableEq for Orientation
deriving instance DecidableEq for SFT.Foundation.ExactOperations.PositiveFraction
deriving instance DecidableEq for Scalar

structure Transport where
 boundary : CollectiveBand.Boundary
 momentum : String → Scalar
 collectiveLabel : String → String

def accessibleEdges (t : Transport) := (CollectiveBand.support t.boundary).flatMap adjacentPairs

def coherentEdges (t : Transport) := (accessibleEdges t).filter
 (fun e => decide (t.collectiveLabel e.1 = t.collectiveLabel e.2))

def momentumChangingEdges (t : Transport) := (coherentEdges t).filter
 (fun e => decide (t.momentum e.1 ≠ t.momentum e.2))

theorem accessibleExactly (t : Transport) (edge : Edge) : edge ∈ accessibleEdges t ↔
 ∃ path, path ∈ CollectiveBand.support t.boundary ∧ edge ∈ adjacentPairs path := by
 constructor
 · intro h; exact memFlatMapOrigin _ _ _ h
 · intro ⟨path,held,member⟩; exact memFlatMap _ _ path _ held member

theorem coherentExactly (t : Transport) (edge : Edge) : edge ∈ coherentEdges t ↔
 edge ∈ accessibleEdges t ∧ t.collectiveLabel edge.1 = t.collectiveLabel edge.2 := by
 constructor
 · intro h
   have p := (filterMemberIff _ _ _).mp h
   exact ⟨p.1,of_decide_eq_true p.2⟩
 · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem momentumChangingExactly (t : Transport) (edge : Edge) : edge ∈ momentumChangingEdges t ↔
 edge ∈ coherentEdges t ∧ t.momentum edge.1 ≠ t.momentum edge.2 := by
 constructor
 · intro h
   have p := (filterMemberIff _ _ _).mp h
   exact ⟨p.1,of_decide_eq_true p.2⟩
 · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem noMomentumChangeIffPreserved (t : Transport) : momentumChangingEdges t = [] ↔
 ∀ edge, edge ∈ coherentEdges t → t.momentum edge.1 = t.momentum edge.2 := by
 constructor
 · intro empty edge held
   by_cases same : t.momentum edge.1 = t.momentum edge.2
   · exact same
   · have h := (momentumChangingExactly t edge).mpr ⟨held,same⟩
     rw [empty] at h
     cases h
 · intro all
   cases rows : momentumChangingEdges t with
   | nil => rfl
   | cons first rest =>
     have member : first ∈ momentumChangingEdges t := by rw [rows]; exact List.Mem.head _
     have p := (momentumChangingExactly t first).mp member
     exact False.elim (p.2 (all first p.1))

theorem everyAccessibleStepIsGenerated (t : Transport) (edge : Edge) (held : edge ∈ accessibleEdges t) :
 edge ∈ t.boundary.lattice.cells.graph.edges := by
 obtain ⟨path,hp,he⟩ := (accessibleExactly t edge).mp held
 have pathValid := ((CollectiveBand.bandExactly t.boundary path).mp hp).2.1
 exact ((pathMeaning _ _).mp pathValid).2.2 edge he

theorem everyAccessiblePathClosesPhase (t : Transport) (path : List String)
 (held : path ∈ CollectiveBand.support t.boundary) :
 SFT.QuantumComputation.ReversibleModel.phaseAction t.boundary.preparation.state path =
 .ok t.boundary.preparation.state := ((CollectiveBand.bandExactly _ _).mp held).2.2

inductive CoherentPath (t : Transport) : String → String → Type where
 | one (x : String) : CoherentPath t x x
 | append {a b c : String} : CoherentPath t a b → (b,c) ∈ coherentEdges t → CoherentPath t a c

theorem unchangedEdgeReadingsCompose (t : Transport) (closed : momentumChangingEdges t = []) {a b : String}
 (path : CoherentPath t a b) : t.momentum a = t.momentum b := by
 induction path with
 | one => rfl
 | append prior step ih =>
   exact ih.trans ((noMomentumChangeIffPreserved t).mp closed _ step)

theorem collectiveLabelRetained (t : Transport) {a b : String}
 (path : CoherentPath t a b) : t.collectiveLabel a = t.collectiveLabel b := by
 induction path with
 | one => rfl
 | append prior step ih => exact ih.trans ((coherentExactly t _).mp step).2

end SFT.Physics.CollectiveSuperconductivity
