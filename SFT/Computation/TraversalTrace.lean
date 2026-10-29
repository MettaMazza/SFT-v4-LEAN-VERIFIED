import SFT.Computation.SequenceTrace
import SFT.Mathematics.GraphPathCompleteness
namespace SFT.Computation.TraversalTrace
open SFT.Mathematics GraphOperations DiscreteObjects

-- Each snapshot retains the original visited list and full frontier order.
inductive Traversal (edges : List Edge) (target : String) : SearchState edges → List (SearchState edges) → Bool → Prop where
 | empty (state) (queue : state.frontier = []) : Traversal edges target state [state] false
 | hit (state rest) (queue : state.frontier = target :: rest) : Traversal edges target state [state] true
 | skip (state held rest) (queue : state.frontier = held :: rest)
     (different : held ≠ target) (seen : has state.visited held = true)
     (states answer) (tail : Traversal edges target (skipState edges state held rest queue) states answer) :
     Traversal edges target state (state :: states) answer
 | expand (state held rest) (queue : state.frontier = held :: rest)
     (different : held ≠ target) (fresh : has state.visited held ≠ true)
     (states answer) (tail : Traversal edges target (expandState edges state held rest queue) states answer) :
     Traversal edges target state (state :: states) answer

theorem finiteTraversal (edges : List Edge) (target : String) (state : SearchState edges) :
    ∃ states answer, Traversal edges target state states answer := by
  induction state using (searchOrder edges).wf.induction with
  | h state ih =>
    cases queue : state.frontier with
    | nil => exact ⟨[state],false,.empty state queue⟩
    | cons held rest =>
      by_cases same : held = target
      · cases same; exact ⟨[state],true,.hit state rest queue⟩
      · by_cases seen : has state.visited held = true
        · obtain ⟨states,answer,tail⟩ := ih (skipState edges state held rest queue) (skipDecreases _ _ _ _ queue)
          exact ⟨state :: states,answer,.skip _ _ _ queue same seen _ _ tail⟩
        · obtain ⟨states,answer,tail⟩ := ih (expandState edges state held rest queue) (expandDecreases _ _ _ _ queue seen)
          exact ⟨state :: states,answer,.expand _ _ _ queue same seen _ _ tail⟩

theorem traversalReplays (edges : List Edge) (target : String) (state : SearchState edges)
    (states : List (SearchState edges)) (answer : Bool) (trace : Traversal edges target state states answer) :
    searchLoop edges target state = answer := by
  induction trace with
  | empty state queue => exact searchEmpty _ _ _ queue
  | hit state rest queue => exact searchHitsTarget _ _ _ _ queue
  | skip state held rest queue different seen states answer tail ih =>
    exact (searchSkipsVisited _ _ _ _ _ queue different seen).trans ih
  | expand state held rest queue different fresh states answer tail ih =>
    exact (searchExpandsFresh _ _ _ _ _ queue different fresh).trans ih

theorem exactFrontierExpansion (edges : List Edge) (state : SearchState edges) (held : String) (rest : List String)
    (queue : state.frontier = held :: rest) :
    (expandState edges state held rest queue).visited = state.visited ++ [held] ∧
      (expandState edges state held rest queue).frontier = rest ++ outgoingUnvisited edges held (state.visited ++ [held]) :=
  ⟨rfl,rfl⟩

theorem visitRetained (edges : List Edge) (state : SearchState edges) (held node : String) (rest : List String)
    (queue : state.frontier = held :: rest) (prior : node ∈ state.visited) :
    node ∈ (expandState edges state held rest queue).visited :=
  SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ prior

theorem frontierCoverage (edges : List Edge) (state : SearchState edges) (node : String)
    (held : node ∈ state.frontier) : node ∈ state.unseen ∨ node ∈ state.visited :=
  state.frontierCovered node held

theorem emptyFrontierTerminal (edges : List Edge) (target : String) (state : SearchState edges)
    (queue : state.frontier = []) : Traversal edges target state [state] false := .empty _ queue

theorem rootedTraversalReconstructs (graph : GeneratedGraph) (origin target : String)
    (different : origin ≠ target) (states : List (SearchState graph.edges)) (answer : Bool)
    (trace : Traversal graph.edges target (initialSearch graph.edges origin) states answer) :
    reachable graph origin target = answer := by
  unfold reachable
  rw [ite_eq_right different]
  exact traversalReplays _ _ _ _ _ trace

theorem acceptedPathCertificate (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) (origin target : String)
    (different : origin ≠ target) (states : List (SearchState graph.edges))
    (trace : Traversal graph.edges target (initialSearch graph.edges origin) states true) :
    PathWitness graph origin target :=
  (admittedReachabilityIffPath _ _ _ accepted _ _).mp (rootedTraversalReconstructs _ _ _ different _ _ trace)

theorem rejectedPathCertificate (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) (origin target : String)
    (different : origin ≠ target) (states : List (SearchState graph.edges))
    (trace : Traversal graph.edges target (initialSearch graph.edges origin) states false) :
    ¬ PathWitness graph origin target := by
  intro path
  have reached := (admittedReachabilityIffPath _ _ _ accepted _ _).mpr path
  rw [rootedTraversalReconstructs _ _ _ different _ _ trace] at reached
  cases reached

theorem rootIdentity (graph : GeneratedGraph) (origin : String) (held : origin ∈ graph.nodes) :
    reachable graph origin origin = true := (reachableIdentity _ _).trans ((hasIff _ _).mpr held)

theorem empiricalTranslationBoundary (preSeal mutation allRows identified : Bool)
    (accepted : SFT.Foundation.MeasurementProtocol.accepts preSeal mutation allRows identified = true) :
    preSeal = false ∧ mutation = false ∧ allRows = true ∧ identified = true :=
  (SFT.Foundation.MeasurementProtocol.acceptanceIff _ _ _ _).mp accepted

end SFT.Computation.TraversalTrace
