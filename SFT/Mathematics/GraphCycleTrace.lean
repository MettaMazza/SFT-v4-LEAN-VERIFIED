import SFT.Mathematics.GraphCycles
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

-- The list records every successive target, including the closing edge target.
inductive ReturnTrace (edges : List Edge) : String → List String → List String → Prop where
  | closes (node : String) (held : List String) (target : String)
      (edge : (node,target) ∈ edges) (returned : target ∈ held) :
      ReturnTrace edges node held [target]
  | advances (node : String) (held : List String) (next : String) (trace : List String)
      (edge : (node,next) ∈ edges) (fresh : ¬ next ∈ held)
      (continuation : ReturnTrace edges next (held ++ [next]) trace) :
      ReturnTrace edges node held (next::trace)

theorem cycleScanProducesTrace (edges : List Edge) (state : CycleState edges)
    (recur : (next : CycleState edges) → (cycleOrder edges).rel next state → Bool)
    (sound : ∀ edge (member : edge ∈ edges) (notHeld : has state.heldPath edge.2 ≠ true),
      recur (cycleNext edges state edge.2) (cycleNextDecreases edges state edge member notHeld) = true →
      ∃ trace, ReturnTrace edges edge.2 (state.heldPath ++ [edge.2]) trace)
    (remaining : List Edge) (included : ∀ edge, edge ∈ remaining → edge ∈ edges)
    (success : cycleScan edges state recur remaining included = true) :
    ∃ trace, ReturnTrace edges state.node state.heldPath trace := by
  induction remaining with
  | nil => cases success
  | cons edge rest ih =>
    unfold cycleScan at success
    split at success
    next origin =>
      have matching : (state.node,edge.2) ∈ edges := by rw [← origin]; exact included edge (List.Mem.head rest)
      split at success
      next returned => exact ⟨[edge.2],ReturnTrace.closes _ _ _ matching ((hasIff _ _).mp returned)⟩
      next notHeld =>
        split at success
        next childSuccess =>
          obtain ⟨trace,continued⟩ := sound edge (included edge (List.Mem.head rest)) notHeld childSuccess
          have absent : ¬ edge.2 ∈ state.heldPath := fun h => notHeld ((hasIff _ _).mpr h)
          exact ⟨edge.2::trace,ReturnTrace.advances _ _ _ _ matching absent continued⟩
        next _ => exact ih _ success
    next _ => exact ih _ success

theorem cycleVisitProducesTrace (edges : List Edge) (state : CycleState edges) :
    cycleVisit edges state = true → ∃ trace, ReturnTrace edges state.node state.heldPath trace := by
  apply (cycleOrder edges).wf.induction state
  intro current ih success
  rw [cycleVisitEquation] at success
  apply cycleScanProducesTrace edges current (fun next _ => cycleVisit edges next) ?_ edges (fun _ h => h) success
  intro edge member notHeld childSuccess
  exact ih (cycleNext edges current edge.2) (cycleNextDecreases edges current edge member notHeld) childSuccess

theorem cycleScanRecursiveSuccess (edges : List Edge) (state : CycleState edges)
    (recur : (next : CycleState edges) → (cycleOrder edges).rel next state → Bool)
    (remaining : List Edge) (included : ∀ edge, edge ∈ remaining → edge ∈ edges)
    (chosen : Edge) (member : chosen ∈ remaining) (origin : chosen.1 = state.node)
    (notHeld : has state.heldPath chosen.2 ≠ true)
    (childSuccess : recur (cycleNext edges state chosen.2)
      (cycleNextDecreases edges state chosen (included chosen member) notHeld) = true) :
    cycleScan edges state recur remaining included = true := by
  induction remaining with
  | nil => cases member
  | cons edge rest ih =>
    cases member with
    | head =>
      unfold cycleScan
      rw [ite_eq_left origin,dite_eq_right notHeld]
      rw [childSuccess]
      rfl
    | tail _ h =>
      have tailTrue := ih (fun cell hm => included cell (List.Mem.tail edge hm)) h childSuccess
      unfold cycleScan
      split
      · split
        · rfl
        · split
          · rfl
          · exact tailTrue
      · exact tailTrue

theorem returnTraceDetected (edges : List Edge) (state : CycleState edges) :
    ∀ trace, ReturnTrace edges state.node state.heldPath trace → cycleVisit edges state = true := by
  apply (cycleOrder edges).wf.induction state
  intro current ih trace witness
  cases witness with
  | closes node held target edge returned =>
    exact cycleVisitImmediateReturn edges current (current.node,target) edge rfl returned
  | advances node held next trace edge fresh continued =>
    have notHeld : has current.heldPath next ≠ true := fun h => fresh ((hasIff _ _).mp h)
    have childSuccess := ih (cycleNext edges current next)
      (cycleNextDecreases edges current (current.node,next) edge notHeld) trace continued
    rw [cycleVisitEquation]
    exact cycleScanRecursiveSuccess edges current (fun next _ => cycleVisit edges next) edges (fun _ h => h)
      (current.node,next) edge rfl notHeld childSuccess

theorem cycleVisitIffReturnTrace (edges : List Edge) (state : CycleState edges) :
    cycleVisit edges state = true ↔ ∃ trace, ReturnTrace edges state.node state.heldPath trace :=
  ⟨cycleVisitProducesTrace edges state,fun ⟨trace,h⟩ => returnTraceDetected edges state trace h⟩

theorem anyTrueWitness {α : Type} (items : List α) (test : α → Bool) :
    items.any test = true ↔ ∃ item, item ∈ items ∧ test item = true := by
  induction items with
  | nil => constructor; intro h; cases h; intro ⟨item,h,_⟩; cases h
  | cons item rest ih =>
    change (test item || rest.any test) = true ↔ _
    cases first : test item with
    | true =>
      constructor
      · intro _; exact ⟨item,List.Mem.head rest,first⟩
      · intro _; rfl
    | false =>
      change rest.any test = true ↔ _
      constructor
      · intro h
        obtain ⟨other,member,passed⟩ := ih.mp h
        exact ⟨other,List.Mem.tail item member,passed⟩
      · intro ⟨other,member,passed⟩
        apply ih.mpr
        cases member with
        | head => rw [first] at passed; cases passed
        | tail _ h => exact ⟨other,h,passed⟩

theorem directedCycleIffReturnTrace (graph : GeneratedGraph) :
    directedCycleExists graph = true ↔
      ∃ node, node ∈ graph.nodes ∧ ∃ trace, ReturnTrace graph.edges node [node] trace := by
  constructor
  · intro success
    obtain ⟨node,member,passed⟩ := (anyTrueWitness graph.nodes _).mp success
    exact ⟨node,member,cycleVisitProducesTrace graph.edges (initialCycle graph.edges node) passed⟩
  · intro ⟨node,member,trace,witness⟩
    apply (anyTrueWitness graph.nodes _).mpr
    exact ⟨node,member,returnTraceDetected graph.edges (initialCycle graph.edges node) trace witness⟩

theorem returnTraceNonempty (edges : List Edge) (node : String) (held trace : List String)
    (witness : ReturnTrace edges node held trace) : trace.isEmpty = false := by
  cases witness <;> rfl

theorem returnTraceAdjacentEdges (edges : List Edge) (node : String) (held trace : List String)
    (witness : ReturnTrace edges node held trace) :
    ∀ edge, edge ∈ adjacentPairs (node::trace) → edge ∈ edges := by
  induction witness with
  | closes node held target edge returned =>
    intro cell member
    cases member with
    | head => exact edge
    | tail _ h => cases h
  | advances node held next trace edge fresh continued ih =>
    intro cell member
    cases member with
    | head => exact edge
    | tail _ h => exact ih cell h

theorem returnTraceNodes (graph : GeneratedGraph)
    (endpoints : ∀ edge, edge ∈ graph.edges → edge.1 ∈ graph.nodes ∧ edge.2 ∈ graph.nodes)
    (node : String) (held trace : List String) (witness : ReturnTrace graph.edges node held trace) :
    ∀ target, target ∈ trace → target ∈ graph.nodes := by
  induction witness with
  | closes node held target edge returned =>
    intro other member
    cases member with
    | head => exact (endpoints (node,target) edge).2
    | tail _ h => cases h
  | advances node held next trace edge fresh continued ih =>
    intro other member
    cases member with
    | head => exact (endpoints (node,next) edge).2
    | tail _ h => exact ih other h

theorem admittedReturnTraceIsPath (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) (node : String) (held trace : List String)
    (member : node ∈ graph.nodes) (witness : ReturnTrace graph.edges node held trace) :
    pathIsValid graph (node::trace) = true := by
  apply (pathMeaning graph _).mpr
  refine ⟨rfl,?_,returnTraceAdjacentEdges graph.edges node held trace witness⟩
  intro other h
  cases h with
  | head => exact member
  | tail _ h => exact returnTraceNodes graph (acceptedGraphEndpoints nodes edges graph accepted) node held trace witness other h

theorem returnTraceClosingDecomposition (edges : List Edge) (node : String) (held trace : List String)
    (witness : ReturnTrace edges node held trace) :
    ∃ prefixNodes target, trace = prefixNodes ++ [target] ∧ target ∈ held ++ prefixNodes := by
  induction witness with
  | closes node held target edge returned =>
    exact ⟨[],target,rfl,memAppendLeft _ _ _ returned⟩
  | advances node held next trace edge fresh continued ih =>
    obtain ⟨prefixNodes,target,shape,returned⟩ := ih
    refine ⟨next::prefixNodes,target,congrArg (List.cons next) shape,?_⟩
    rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative] at returned
    exact returned

theorem walkReturnProducesTrace (edges : List Edge) (prefixNodes : List String) :
    ∀ node held target,
      (∀ edge, edge ∈ adjacentPairs (node::(prefixNodes ++ [target])) → edge ∈ edges) →
      target ∈ held ++ prefixNodes → ∃ trace, ReturnTrace edges node held trace := by
  induction prefixNodes with
  | nil =>
    intro node held target allEdges returned
    have inHeld : target ∈ held := by
      cases memAppendCases target held [] returned with
      | inl h => exact h
      | inr h => cases h
    exact ⟨[target],ReturnTrace.closes node held target (allEdges (node,target) (List.Mem.head [])) inHeld⟩
  | cons next rest ih =>
    intro node held target allEdges returned
    have edge := allEdges (node,next) (List.Mem.head _)
    cases seen : has held next with
    | true => exact ⟨[next],ReturnTrace.closes node held next edge ((hasIff _ _).mp seen)⟩
    | false =>
      have absent : ¬ next ∈ held := by
        intro member
        have yes := (hasIff _ _).mpr member
        rw [seen] at yes
        cases yes
      have later : target ∈ (held ++ [next]) ++ rest := by
        rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative]
        exact returned
      obtain ⟨trace,continued⟩ := ih next (held ++ [next]) target
        (fun cell member => allEdges cell (List.Mem.tail (node,next) member)) later
      exact ⟨next::trace,ReturnTrace.advances node held next trace edge absent continued⟩

theorem admittedCycleHasReturnPath (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) (success : directedCycleExists graph = true) :
    ∃ node prefixNodes target, node ∈ graph.nodes ∧
      pathIsValid graph (node::(prefixNodes ++ [target])) = true ∧ target ∈ node::prefixNodes := by
  obtain ⟨node,member,trace,witness⟩ := (directedCycleIffReturnTrace graph).mp success
  obtain ⟨prefixNodes,target,shape,returned⟩ := returnTraceClosingDecomposition graph.edges node [node] trace witness
  have valid := admittedReturnTraceIsPath nodes edges graph accepted node [node] trace member witness
  rw [shape] at valid
  exact ⟨node,prefixNodes,target,member,valid,returned⟩

theorem completeReturnPathDetected (graph : GeneratedGraph) (node : String) (prefixNodes : List String) (target : String)
    (member : node ∈ graph.nodes) (valid : pathIsValid graph (node::(prefixNodes ++ [target])) = true)
    (returned : target ∈ node::prefixNodes) : directedCycleExists graph = true := by
  obtain ⟨trace,witness⟩ := walkReturnProducesTrace graph.edges prefixNodes node [node] target
    ((pathMeaning graph _).mp valid).2.2 returned
  exact (directedCycleIffReturnTrace graph).mpr ⟨node,member,trace,witness⟩

theorem admittedCycleIffCompleteReturnPath (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) :
    directedCycleExists graph = true ↔
      ∃ node prefixNodes target, node ∈ graph.nodes ∧
        pathIsValid graph (node::(prefixNodes ++ [target])) = true ∧ target ∈ node::prefixNodes :=
  ⟨admittedCycleHasReturnPath nodes edges graph accepted,
    fun ⟨node,prefixNodes,target,member,valid,returned⟩ => completeReturnPathDetected graph node prefixNodes target member valid returned⟩

end SFT.Mathematics.GraphOperations
