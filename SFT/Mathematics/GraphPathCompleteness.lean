import SFT.Mathematics.GraphPathSoundness
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

def VisitedClosed (edges : List Edge) (visited frontier : List String) : Prop :=
  ∀ left right, left ∈ visited → (left,right) ∈ edges → right ∈ visited ∨ right ∈ frontier

theorem skipRetainsCovered (edges : List Edge) (state : SearchState edges) (held node : String) (rest : List String)
    (queue : state.frontier = held::rest) (seen : held ∈ state.visited)
    (covered : node ∈ state.visited ∨ node ∈ state.frontier) :
    node ∈ (skipState edges state held rest queue).visited ∨ node ∈ (skipState edges state held rest queue).frontier := by
  cases covered with
  | inl h => exact Or.inl h
  | inr h =>
    rw [queue] at h
    cases h with
    | head => exact Or.inl seen
    | tail _ h => exact Or.inr h

theorem expandRetainsCovered (edges : List Edge) (state : SearchState edges) (held node : String) (rest : List String)
    (queue : state.frontier = held::rest) (covered : node ∈ state.visited ∨ node ∈ state.frontier) :
    node ∈ (expandState edges state held rest queue).visited ∨ node ∈ (expandState edges state held rest queue).frontier := by
  cases covered with
  | inl h => exact Or.inl (memAppendLeft _ _ _ h)
  | inr h =>
    rw [queue] at h
    cases h with
    | head => exact Or.inl (memAppendRight _ _ _ (List.Mem.head []))
    | tail _ h => exact Or.inr (memAppendLeft _ _ _ h)

theorem skipPreservesClosure (edges : List Edge) (state : SearchState edges) (held : String) (rest : List String)
    (queue : state.frontier = held::rest) (seen : held ∈ state.visited)
    (closed : VisitedClosed edges state.visited state.frontier) :
    VisitedClosed edges (skipState edges state held rest queue).visited (skipState edges state held rest queue).frontier := by
  intro left right member edge
  exact skipRetainsCovered edges state held right rest queue seen (closed left right member edge)

theorem expandPreservesClosure (edges : List Edge) (state : SearchState edges) (held : String) (rest : List String)
    (queue : state.frontier = held::rest) (closed : VisitedClosed edges state.visited state.frontier) :
    VisitedClosed edges (expandState edges state held rest queue).visited (expandState edges state held rest queue).frontier := by
  intro left right member edge
  cases memAppendCases left state.visited [held] member with
  | inl h => exact expandRetainsCovered edges state held right rest queue (closed left right h edge)
  | inr h =>
    have same : left = held := by
      cases h with
      | head => rfl
      | tail _ h => cases h
    cases same
    cases visited : has (state.visited ++ [held]) right with
    | true => exact Or.inl ((hasIff _ _).mp visited)
    | false =>
      have absent : ¬ right ∈ state.visited ++ [held] := by
        intro member
        have found := (hasIff _ _).mpr member
        rw [visited] at found
        cases found
      exact Or.inr (memAppendRight _ _ _ ((outgoingMembership edges held right _).mpr ⟨edge,absent⟩))

theorem searchFailureCertificate (edges : List Edge) (target : String) (state : SearchState edges) :
    (¬ target ∈ state.visited) → VisitedClosed edges state.visited state.frontier →
    searchLoop edges target state = false →
    ∃ exhausted : List String,
      (∀ node, node ∈ state.visited → node ∈ exhausted) ∧
      (∀ node, node ∈ state.frontier → node ∈ exhausted) ∧
      (¬ target ∈ exhausted) ∧
      (∀ left right, left ∈ exhausted → (left,right) ∈ edges → right ∈ exhausted) := by
  apply (searchOrder edges).wf.induction state
  intro current ih targetAbsent closed failed
  cases queue : current.frontier with
  | nil =>
    refine ⟨current.visited,fun _ h => h,?_,targetAbsent,?_⟩
    · intro node h; cases h
    · intro left right member edge
      cases closed left right member edge with
      | inl h => exact h
      | inr h => rw [queue] at h; cases h
  | cons held rest =>
    by_cases hit : held = target
    · cases hit
      rw [searchHitsTarget edges target current rest queue] at failed
      cases failed
    · by_cases seen : has current.visited held = true
      · have heldVisited := (hasIff _ _).mp seen
        have nextFailed : searchLoop edges target (skipState edges current held rest queue) = false := by
          rw [← searchSkipsVisited edges target current held rest queue hit seen]; exact failed
        obtain ⟨exhausted,oldVisited,oldFrontier,absent,edgeClosed⟩ :=
          ih (skipState edges current held rest queue) (skipDecreases edges current held rest queue)
            targetAbsent (skipPreservesClosure edges current held rest queue heldVisited closed) nextFailed
        refine ⟨exhausted,oldVisited,?_,absent,edgeClosed⟩
        intro node member
        cases member with
        | head => exact oldVisited held heldVisited
        | tail _ h => exact oldFrontier node h
      · have nextAbsent : ¬ target ∈ (expandState edges current held rest queue).visited := by
          intro member
          cases memAppendCases target current.visited [held] member with
          | inl h => exact targetAbsent h
          | inr h =>
            cases h with
            | head => exact hit rfl
            | tail _ h => cases h
        have nextFailed : searchLoop edges target (expandState edges current held rest queue) = false := by
          rw [← searchExpandsFresh edges target current held rest queue hit seen]; exact failed
        obtain ⟨exhausted,newVisited,newFrontier,absent,edgeClosed⟩ :=
          ih (expandState edges current held rest queue) (expandDecreases edges current held rest queue seen)
            nextAbsent (expandPreservesClosure edges current held rest queue closed) nextFailed
        refine ⟨exhausted,?_,?_,absent,edgeClosed⟩
        · intro node member; exact newVisited node (memAppendLeft _ _ _ member)
        · intro node member
          cases member with
          | head => exact newVisited held (memAppendRight _ _ _ (List.Mem.head []))
          | tail _ h => exact newFrontier node (memAppendLeft _ _ _ h)

theorem closedAlongPath (edges : List Edge) (closedNodes : List String)
    (closed : ∀ left right, left ∈ closedNodes → (left,right) ∈ edges → right ∈ closedNodes)
    (path : List String) :
    ∀ origin, path.head? = some origin → origin ∈ closedNodes →
      (∀ edge, edge ∈ adjacentPairs path → edge ∈ edges) →
      ∀ node, node ∈ path → node ∈ closedNodes := by
  induction path with
  | nil => intro origin starts; cases starts
  | cons first rest ih =>
    intro origin starts member allEdges node nodeMember
    have same : first = origin := Option.some.inj starts
    have firstMember : first ∈ closedNodes := same ▸ member
    cases nodeMember with
    | head => exact firstMember
    | tail _ nodeRest =>
      cases rest with
      | nil => cases nodeRest
      | cons second tail =>
        apply ih second rfl (closed first second firstMember (allEdges (first,second) (List.Mem.head _))) ?_ node nodeRest
        intro edge he
        exact allEdges edge (List.Mem.tail (first,second) he)

theorem pathWitnessInClosedSet (graph : GeneratedGraph) (origin target : String) (closedNodes : List String)
    (closed : ∀ left right, left ∈ closedNodes → (left,right) ∈ graph.edges → right ∈ closedNodes)
    (originMember : origin ∈ closedNodes) (path : PathWitness graph origin target) : target ∈ closedNodes := by
  obtain ⟨prefixNodes,valid,starts⟩ := path
  exact closedAlongPath graph.edges closedNodes closed (prefixNodes ++ [target]) origin starts originMember
    ((pathMeaning graph _).mp valid).2.2 target (memAppendRight _ _ _ (List.Mem.head []))

theorem pathWitnessReachable (graph : GeneratedGraph) (origin target : String)
    (path : PathWitness graph origin target) : reachable graph origin target = true := by
  unfold reachable
  by_cases same : origin = target
  · rw [ite_eq_left same]
    cases same
    exact (hasIff _ _).mpr (pathWitnessTarget graph origin origin path)
  · rw [ite_eq_right same]
    cases result : searchLoop graph.edges target (initialSearch graph.edges origin) with
    | true => rfl
    | false =>
      obtain ⟨exhausted,_,frontier,absent,closed⟩ := searchFailureCertificate graph.edges target
        (initialSearch graph.edges origin) (fun h => by cases h) (fun _ _ h => by cases h) result
      exact False.elim (absent (pathWitnessInClosedSet graph origin target exhausted closed
        (frontier origin (List.Mem.head [])) path))

theorem admittedReachabilityIffPath (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) (origin target : String) :
    reachable graph origin target = true ↔ PathWitness graph origin target :=
  ⟨admittedReachabilityHasPath nodes edges graph accepted origin target,pathWitnessReachable graph origin target⟩

theorem composePathWitnesses (graph : GeneratedGraph) (origin middle target : String)
    (first : PathWitness graph origin middle) (second : PathWitness graph middle target) :
    PathWitness graph origin target := by
  obtain ⟨firstPrefix,firstValid,firstHead⟩ := first
  obtain ⟨secondPrefix,secondValid,secondHead⟩ := second
  cases secondPrefix with
  | nil =>
    have same : target = middle := Option.some.inj secondHead
    cases same
    exact ⟨firstPrefix,firstValid,firstHead⟩
  | cons head rest =>
    have same : head = middle := Option.some.inj secondHead
    cases same
    refine ⟨firstPrefix ++ middle::rest,?_,?_⟩
    · rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative]
      exact (pathCompositionIff graph firstPrefix (rest ++ [target]) middle).mpr ⟨firstValid,secondValid⟩
    · cases firstPrefix with
      | nil => exact firstHead
      | cons head rest => exact firstHead

theorem reachableReflexiveIff (graph : GeneratedGraph) (node : String) :
    reachable graph node node = true ↔ node ∈ graph.nodes := by
  rw [reachableIdentity]
  exact hasIff _ _

theorem admittedReachabilityTransitive (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) (origin middle target : String)
    (first : reachable graph origin middle = true) (second : reachable graph middle target = true) :
    reachable graph origin target = true :=
  pathWitnessReachable graph origin target (composePathWitnesses graph origin middle target
    (admittedReachabilityHasPath nodes edges graph accepted origin middle first)
    (admittedReachabilityHasPath nodes edges graph accepted middle target second))

end SFT.Mathematics.GraphOperations
