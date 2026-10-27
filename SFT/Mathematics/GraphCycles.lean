import SFT.Mathematics.GraphPathCompleteness
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects CombinatorialArrangements SFT.Foundation.Count.TraceDerivation

structure CycleState (edges : List Edge) where
  unseen : List String
  heldPath : List String
  node : String
  targetsCovered : ∀ edge, edge ∈ edges → edge.2 ∈ unseen ∨ edge.2 ∈ heldPath

def cycleOrder (edges : List Edge) : WellFoundedRelation (CycleState edges) :=
  measure (fun state => state.unseen.length)

def cycleNext (edges : List Edge) (state : CycleState edges) (next : String) : CycleState edges where
  unseen := remainder state.unseen next
  heldPath := state.heldPath ++ [next]
  node := next
  targetsCovered := fun edge member => coverageAfterVisit _ _ _ _ (state.targetsCovered edge member)

theorem cycleNextDecreases (edges : List Edge) (state : CycleState edges) (edge : Edge)
    (member : edge ∈ edges) (notHeld : has state.heldPath edge.2 ≠ true) :
    (cycleOrder edges).rel (cycleNext edges state edge.2) state := by
  apply remainderShorter
  cases state.targetsCovered edge member with
  | inl h => exact h
  | inr h => exact False.elim (notHeld ((hasIff _ _).mpr h))

def cycleScan (edges : List Edge) (state : CycleState edges)
    (recur : (next : CycleState edges) → (cycleOrder edges).rel next state → Bool)
    (remaining : List Edge) (included : ∀ edge, edge ∈ remaining → edge ∈ edges) : Bool :=
  match remaining with
  | [] => false
  | edge::rest =>
    if edge.1 = state.node then
      if seen : has state.heldPath edge.2 = true then true
      else if recur (cycleNext edges state edge.2) (cycleNextDecreases edges state edge (included edge (List.Mem.head rest)) seen) then true
      else cycleScan edges state recur rest (fun cell member => included cell (List.Mem.tail edge member))
    else cycleScan edges state recur rest (fun cell member => included cell (List.Mem.tail edge member))

def cycleBody (edges : List Edge) (state : CycleState edges)
    (recur : (next : CycleState edges) → (cycleOrder edges).rel next state → Bool) : Bool :=
  cycleScan edges state recur edges (fun _ h => h)

def cycleVisit (edges : List Edge) : CycleState edges → Bool :=
  (cycleOrder edges).wf.fix (cycleBody edges)

theorem cycleVisitEquation (edges : List Edge) (state : CycleState edges) :
    cycleVisit edges state = cycleScan edges state (fun next _ => cycleVisit edges next) edges (fun _ h => h) := by
  unfold cycleVisit
  rw [WellFounded.fix_eq]
  rfl

def initialCycle (edges : List Edge) (node : String) : CycleState edges where
  unseen := edges.map Prod.snd
  heldPath := [node]
  node := node
  targetsCovered := fun edge member => Or.inl (memMap Prod.snd edge edges member)

def directedCycleExists (graph : GeneratedGraph) : Bool :=
  graph.nodes.any (fun node => cycleVisit graph.edges (initialCycle graph.edges node))

theorem cycleScanEmpty (edges : List Edge) (state : CycleState edges)
    (recur : (next : CycleState edges) → (cycleOrder edges).rel next state → Bool)
    (included : ∀ edge, edge ∈ ([] : List Edge) → edge ∈ edges) :
    cycleScan edges state recur [] included = false := rfl

theorem cycleVisitEmpty (state : CycleState []) : cycleVisit [] state = false := by
  rw [cycleVisitEquation]
  rfl

theorem cycleScanNoOutgoing (edges : List Edge) (state : CycleState edges)
    (recur : (next : CycleState edges) → (cycleOrder edges).rel next state → Bool)
    (remaining : List Edge) (included : ∀ edge, edge ∈ remaining → edge ∈ edges)
    (none : ∀ edge, edge ∈ remaining → edge.1 ≠ state.node) :
    cycleScan edges state recur remaining included = false := by
  induction remaining with
  | nil => rfl
  | cons edge rest ih =>
    unfold cycleScan
    rw [ite_eq_right (none edge (List.Mem.head rest))]
    exact ih _ (fun cell member => none cell (List.Mem.tail edge member))

theorem cycleVisitNoOutgoing (edges : List Edge) (state : CycleState edges)
    (none : ∀ edge, edge ∈ edges → edge.1 ≠ state.node) : cycleVisit edges state = false := by
  rw [cycleVisitEquation]
  exact cycleScanNoOutgoing edges state _ edges _ none

theorem cycleScanImmediateReturn (edges : List Edge) (state : CycleState edges)
    (recur : (next : CycleState edges) → (cycleOrder edges).rel next state → Bool)
    (remaining : List Edge) (included : ∀ edge, edge ∈ remaining → edge ∈ edges)
    (returnEdge : Edge) (member : returnEdge ∈ remaining)
    (origin : returnEdge.1 = state.node) (returned : has state.heldPath returnEdge.2 = true) :
    cycleScan edges state recur remaining included = true := by
  induction remaining with
  | nil => cases member
  | cons edge rest ih =>
    cases member with
    | head =>
      unfold cycleScan
      rw [ite_eq_left origin,dite_eq_left returned]
    | tail _ h =>
      have tailTrue := ih (fun cell member => included cell (List.Mem.tail edge member)) h
      unfold cycleScan
      split
      · split
        · rfl
        · split
          · rfl
          · exact tailTrue
      · exact tailTrue

theorem cycleVisitImmediateReturn (edges : List Edge) (state : CycleState edges) (edge : Edge)
    (member : edge ∈ edges) (origin : edge.1 = state.node) (returned : edge.2 ∈ state.heldPath) :
    cycleVisit edges state = true := by
  rw [cycleVisitEquation]
  exact cycleScanImmediateReturn edges state _ edges _ edge member origin ((hasIff _ _).mpr returned)

theorem edgelessGraphHasNoCycle (nodes : List String) : directedCycleExists ⟨nodes,[]⟩ = false := by
  apply anyFalseOfMembers
  intro node _
  exact cycleVisitEmpty _

end SFT.Mathematics.GraphOperations
