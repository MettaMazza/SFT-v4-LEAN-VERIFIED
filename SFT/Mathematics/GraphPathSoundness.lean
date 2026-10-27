import SFT.Mathematics.GraphReachability
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem outgoingMembership (edges : List Edge) (held node : String) (visited : List String) :
    node ∈ outgoingUnvisited edges held visited ↔ (held,node) ∈ edges ∧ ¬ node ∈ visited := by
  constructor
  · intro member
    obtain ⟨edge,kept,same⟩ := memMapPreimage Prod.snd node _ member
    have parts := (filterMemberIff _ _ _).mp kept
    have origin : decide (edge.1 = held) = true := by
      cases h : decide (edge.1 = held) with
      | false => rw [h] at parts; cases parts.2
      | true => rfl
    have absent : ¬ edge.2 ∈ visited := by
      intro seen
      have yes := (hasIff _ _).mpr seen
      rw [origin,yes] at parts
      cases parts.2
    have equal := of_decide_eq_true origin
    cases edge with
    | mk left right =>
      dsimp only at equal same absent
      cases equal
      cases same
      exact ⟨parts.1,absent⟩
  · intro conditions
    apply memMap Prod.snd (held,node)
    apply (filterMemberIff _ _ _).mpr
    refine ⟨conditions.1,?_⟩
    have no : has visited node = false := by
      cases h : has visited node with
      | false => rfl
      | true => exact False.elim (conditions.2 ((hasIff _ _).mp h))
    rw [no]
    rw [show decide ((held,node).1 = held) = true from decide_eq_true rfl]
    rfl

theorem searchPreservesProperty (edges : List Edge) (target : String) (property : String → Prop)
    (closed : ∀ left right, (left,right) ∈ edges → property left → property right)
    (state : SearchState edges) :
    (∀ node, node ∈ state.frontier → property node) → searchLoop edges target state = true → property target := by
  apply (searchOrder edges).wf.induction state
  intro current ih frontierProperty success
  cases queue : current.frontier with
  | nil => rw [searchEmpty edges target current queue] at success; cases success
  | cons held rest =>
    have heldProperty := frontierProperty held (queue ▸ List.Mem.head rest)
    by_cases hit : held = target
    · cases hit; exact heldProperty
    · by_cases seen : has current.visited held = true
      · apply ih (skipState edges current held rest queue) (skipDecreases edges current held rest queue)
        · intro node member
          exact frontierProperty node (queue ▸ List.Mem.tail held member)
        · rw [← searchSkipsVisited edges target current held rest queue hit seen]
          exact success
      · apply ih (expandState edges current held rest queue) (expandDecreases edges current held rest queue seen)
        · intro node member
          cases memAppendCases node rest _ member with
          | inl h => exact frontierProperty node (queue ▸ List.Mem.tail held h)
          | inr h => exact closed held node ((outgoingMembership edges held node _).mp h).1 heldProperty
        · rw [← searchExpandsFresh edges target current held rest queue hit seen]
          exact success

-- A witness is the actual complete node list, ending at target and beginning at origin.
def PathWitness (graph : GeneratedGraph) (origin target : String) : Prop :=
  ∃ prefixNodes : List String, pathIsValid graph (prefixNodes ++ [target]) = true ∧
    (prefixNodes ++ [target]).head? = some origin

theorem identityPathWitness (graph : GeneratedGraph) (origin : String) (member : origin ∈ graph.nodes) :
    PathWitness graph origin origin :=
  ⟨[],(identityPathIff graph origin).mpr member,rfl⟩

theorem pathWitnessTarget (graph : GeneratedGraph) (origin target : String)
    (witness : PathWitness graph origin target) : target ∈ graph.nodes := by
  obtain ⟨prefixNodes,valid,_⟩ := witness
  exact (pathMeaning graph _).mp valid |>.2.1 target (memAppendRight _ _ _ (List.Mem.head []))

theorem extendPathWitness (graph : GeneratedGraph) (origin held next : String)
    (prior : PathWitness graph origin held) (edge : (held,next) ∈ graph.edges)
    (nextMember : next ∈ graph.nodes) : PathWitness graph origin next := by
  obtain ⟨prefixNodes,valid,starts⟩ := prior
  have heldMember := (pathMeaning graph _).mp valid |>.2.1 held (memAppendRight _ _ _ (List.Mem.head []))
  have transition : pathIsValid graph [held,next] = true := by
    apply (pathMeaning graph _).mpr
    refine ⟨rfl,?_,?_⟩
    · intro node member
      cases member with
      | head => exact heldMember
      | tail _ h =>
        cases h with
        | head => exact nextMember
        | tail _ h => cases h
    · intro cell member
      cases member with
      | head => exact edge
      | tail _ h => cases h
  refine ⟨prefixNodes ++ [held],?_,?_⟩
  · rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative]
    exact (pathCompositionIff graph prefixNodes [next] held).mpr ⟨valid,transition⟩
  · cases prefixNodes with
    | nil => exact starts
    | cons first rest => exact starts

theorem acceptedGraphEndpoints (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) :
    ∀ edge, edge ∈ graph.edges → edge.1 ∈ graph.nodes ∧ edge.2 ∈ graph.nodes := by
  have shape := graphConstructorResult nodes edges graph accepted
  cases shape
  have outsideFalse : edges.any (fun edge => !has nodes edge.1 || !has nodes edge.2) = false := by
    unfold makeGraph at accepted
    cases guard : nodes.isEmpty || !distinct nodes <;> rw [guard] at accepted
    · cases repeated : !distinct edges <;> rw [repeated] at accepted
      · cases outside : edges.any (fun edge => !has nodes edge.1 || !has nodes edge.2) with
        | false => rfl
        | true => rw [outside] at accepted; cases accepted
      · cases accepted
    · cases accepted
  intro edge member
  have check := anyFalseAtMember (fun edge : Edge => !has nodes edge.1 || !has nodes edge.2) edges outsideFalse edge member
  cases left : has nodes edge.1 <;> cases right : has nodes edge.2 <;> rw [left,right] at check
  all_goals try cases check
  exact ⟨(hasIff _ _).mp left,(hasIff _ _).mp right⟩

theorem reachableHasPath (graph : GeneratedGraph) (origin target : String)
    (endpoints : ∀ edge, edge ∈ graph.edges → edge.1 ∈ graph.nodes ∧ edge.2 ∈ graph.nodes)
    (success : reachable graph origin target = true) : PathWitness graph origin target := by
  unfold reachable at success
  by_cases same : origin = target
  · cases same
    rw [ite_eq_left rfl] at success
    exact identityPathWitness graph origin ((hasIff _ _).mp success)
  · rw [ite_eq_right same] at success
    have reached : target = origin ∨ PathWitness graph origin target := by
      apply searchPreservesProperty graph.edges target (fun node => node = origin ∨ PathWitness graph origin node)
        ?_ (initialSearch graph.edges origin) ?_ success
      · intro left right edge prior
        apply Or.inr
        apply extendPathWitness graph origin left right ?_ edge (endpoints (left,right) edge).2
        cases prior with
        | inl eq =>
          cases eq
          exact identityPathWitness graph origin (endpoints (origin,right) edge).1
        | inr path => exact path
      · intro node member
        cases member with
        | head => exact Or.inl rfl
        | tail _ h => cases h
    cases reached with
    | inl reverse => exact False.elim (same reverse.symm)
    | inr path => exact path

theorem admittedReachabilityHasPath (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) (origin target : String)
    (success : reachable graph origin target = true) : PathWitness graph origin target :=
  reachableHasPath graph origin target (acceptedGraphEndpoints nodes edges graph accepted) success

end SFT.Mathematics.GraphOperations
