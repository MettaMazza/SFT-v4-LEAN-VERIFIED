import SFT.Mathematics.GraphOperations
import SFT.Mathematics.CombinatorialArrangements
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects CombinatorialArrangements SFT.Foundation.Count.TraceDerivation

-- The source scans every edge in order, after appending held to visited.
def outgoingUnvisited (edges : List Edge) (held : String) (visited : List String) : List String :=
  (edges.filter (fun edge => decide (edge.1 = held) && !has visited edge.2)).map Prod.snd

theorem outgoingTarget (edges : List Edge) (held : String) (visited : List String) (node : String)
    (member : node ∈ outgoingUnvisited edges held visited) : ∃ edge, edge ∈ edges ∧ edge.2 = node := by
  obtain ⟨edge,kept,same⟩ := memMapPreimage Prod.snd node _ member
  exact ⟨edge,(filterMemberIff _ _ _).mp kept |>.1,same⟩

-- Proof-only finite support. It cannot delete, reorder or cap the actual frontier.
structure SearchState (edges : List Edge) where
  unseen : List String
  visited : List String
  frontier : List String
  frontierCovered : ∀ node, node ∈ frontier → node ∈ unseen ∨ node ∈ visited
  targetsCovered : ∀ edge, edge ∈ edges → edge.2 ∈ unseen ∨ edge.2 ∈ visited

def searchOrder (edges : List Edge) : WellFoundedRelation (SearchState edges) :=
  invImage (fun state => (state.unseen.length,state.frontier.length)) (Prod.lex Nat.lt_wfRel Nat.lt_wfRel)

theorem coverageAfterVisit (unseen visited : List String) (held node : String)
    (covered : node ∈ unseen ∨ node ∈ visited) :
    node ∈ remainder unseen held ∨ node ∈ visited ++ [held] := by
  by_cases same : node = held
  · cases same; exact Or.inr (memAppendRight _ _ _ (List.Mem.head []))
  · cases covered with
    | inl h => exact Or.inl ((remainderMemberIff unseen held node).mpr ⟨h,same⟩)
    | inr h => exact Or.inr (memAppendLeft _ _ _ h)

def skipState (edges : List Edge) (state : SearchState edges) (held : String) (rest : List String)
    (queue : state.frontier = held::rest) : SearchState edges where
  unseen := state.unseen
  visited := state.visited
  frontier := rest
  frontierCovered := fun node member => state.frontierCovered node (queue ▸ List.Mem.tail held member)
  targetsCovered := state.targetsCovered

def expandState (edges : List Edge) (state : SearchState edges) (held : String) (rest : List String)
    (queue : state.frontier = held::rest) : SearchState edges where
  unseen := remainder state.unseen held
  visited := state.visited ++ [held]
  frontier := rest ++ outgoingUnvisited edges held (state.visited ++ [held])
  frontierCovered := by
    intro node member
    apply coverageAfterVisit
    cases memAppendCases node rest _ member with
    | inl h => exact state.frontierCovered node (queue ▸ List.Mem.tail held h)
    | inr h =>
      obtain ⟨edge,he,same⟩ := outgoingTarget edges held (state.visited ++ [held]) node h
      rw [← same]
      exact state.targetsCovered edge he
  targetsCovered := fun edge member => coverageAfterVisit _ _ _ _ (state.targetsCovered edge member)

theorem skipDecreases (edges : List Edge) (state : SearchState edges) (held : String) (rest : List String)
    (queue : state.frontier = held::rest) :
    (searchOrder edges).rel (skipState edges state held rest queue) state := by
  apply Prod.Lex.right
  change rest.length < state.frontier.length
  rw [queue]
  exact Nat.lt_succ_self _

theorem expandDecreases (edges : List Edge) (state : SearchState edges) (held : String) (rest : List String)
    (queue : state.frontier = held::rest) (notSeen : has state.visited held ≠ true) :
    (searchOrder edges).rel (expandState edges state held rest queue) state := by
  apply Prod.Lex.left
  apply remainderShorter
  cases state.frontierCovered held (queue ▸ List.Mem.head rest) with
  | inl member => exact member
  | inr member => exact False.elim (notSeen ((hasIff _ _).mpr member))

def searchBody (edges : List Edge) (target : String) (state : SearchState edges)
    (recur : (next : SearchState edges) → (searchOrder edges).rel next state → Bool) : Bool :=
  match queue : state.frontier with
  | [] => false
  | held::rest =>
    if held = target then true
    else if seen : has state.visited held = true then
      recur (skipState edges state held rest queue) (skipDecreases edges state held rest queue)
    else recur (expandState edges state held rest queue) (expandDecreases edges state held rest queue seen)

def searchLoop (edges : List Edge) (target : String) : SearchState edges → Bool :=
  (searchOrder edges).wf.fix (searchBody edges target)

theorem searchLoopEquation (edges : List Edge) (target : String) (state : SearchState edges) :
    searchLoop edges target state = searchBody edges target state (fun next _ => searchLoop edges target next) := by
  unfold searchLoop
  rw [WellFounded.fix_eq]

def initialSearch (edges : List Edge) (origin : String) : SearchState edges where
  unseen := origin :: edges.map Prod.snd
  visited := []
  frontier := [origin]
  frontierCovered := by
    intro node member
    cases member with
    | head => exact Or.inl (List.Mem.head _)
    | tail _ h => cases h
  targetsCovered := fun edge member => Or.inl (List.Mem.tail origin (memMap Prod.snd edge edges member))

def reachable (graph : GeneratedGraph) (origin target : String) : Bool :=
  if origin = target then has graph.nodes origin
  else searchLoop graph.edges target (initialSearch graph.edges origin)

theorem reachableIdentity (graph : GeneratedGraph) (origin : String) :
    reachable graph origin origin = has graph.nodes origin := by
  unfold reachable
  rw [ite_eq_left rfl]

theorem searchEmpty (edges : List Edge) (target : String) (state : SearchState edges)
    (queue : state.frontier = []) : searchLoop edges target state = false := by
  cases state with
  | mk unseen visited frontier covered targets =>
    dsimp only at queue
    cases queue
    rw [searchLoopEquation]
    rfl

theorem searchHitsTarget (edges : List Edge) (target : String) (state : SearchState edges) (rest : List String)
    (queue : state.frontier = target::rest) : searchLoop edges target state = true := by
  cases state with
  | mk unseen visited frontier covered targets =>
    dsimp only at queue
    cases queue
    rw [searchLoopEquation]
    unfold searchBody
    dsimp only
    rw [ite_eq_left rfl]

theorem searchSkipsVisited (edges : List Edge) (target : String) (state : SearchState edges)
    (held : String) (rest : List String) (queue : state.frontier = held::rest)
    (notTarget : held ≠ target) (seen : has state.visited held = true) :
    searchLoop edges target state = searchLoop edges target (skipState edges state held rest queue) := by
  cases state with
  | mk unseen visited frontier covered targets =>
    dsimp only at queue
    cases queue
    rw [searchLoopEquation]
    unfold searchBody
    dsimp only
    rw [ite_eq_right notTarget,dite_eq_left seen]

theorem searchExpandsFresh (edges : List Edge) (target : String) (state : SearchState edges)
    (held : String) (rest : List String) (queue : state.frontier = held::rest)
    (notTarget : held ≠ target) (notSeen : has state.visited held ≠ true) :
    searchLoop edges target state = searchLoop edges target (expandState edges state held rest queue) := by
  cases state with
  | mk unseen visited frontier covered targets =>
    dsimp only at queue
    cases queue
    rw [searchLoopEquation]
    unfold searchBody
    dsimp only
    rw [ite_eq_right notTarget,dite_eq_right notSeen]

end SFT.Mathematics.GraphOperations
