import SFT.Mathematics.GraphCycleTrace
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem oneGraphAccepted : makeGraph ["One"] [] = .ok ⟨["One"],[]⟩ := rfl

theorem oneIdentityPath : pathIsValid ⟨["One"],[]⟩ ["One"] = true := rfl

theorem oneIdentityReachable : reachable ⟨["One"],[]⟩ "One" "One" = true := by
  rw [reachableIdentity]
  rfl

theorem oneHasNoCycle : directedCycleExists ⟨["One"],[]⟩ = false := edgelessGraphHasNoCycle _

theorem retainedPathValid (old extended : GeneratedGraph)
    (nodesRetained : ∀ node, node ∈ old.nodes → node ∈ extended.nodes)
    (edgesRetained : ∀ edge, edge ∈ old.edges → edge ∈ extended.edges)
    (path : List String) (valid : pathIsValid old path = true) : pathIsValid extended path = true := by
  have meaning := (pathMeaning old path).mp valid
  exact (pathMeaning extended path).mpr ⟨meaning.1,
    fun node member => nodesRetained node (meaning.2.1 node member),
    fun edge member => edgesRetained edge (meaning.2.2 edge member)⟩

theorem retainedPathWitness (old extended : GeneratedGraph)
    (nodesRetained : ∀ node, node ∈ old.nodes → node ∈ extended.nodes)
    (edgesRetained : ∀ edge, edge ∈ old.edges → edge ∈ extended.edges)
    (origin target : String) (witness : PathWitness old origin target) : PathWitness extended origin target := by
  obtain ⟨prefixNodes,valid,starts⟩ := witness
  exact ⟨prefixNodes,retainedPathValid old extended nodesRetained edgesRetained _ valid,starts⟩

theorem retainedReachability (nodes : List String) (edges : List Edge) (old extended : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok old)
    (nodesRetained : ∀ node, node ∈ old.nodes → node ∈ extended.nodes)
    (edgesRetained : ∀ edge, edge ∈ old.edges → edge ∈ extended.edges)
    (origin target : String) (prior : reachable old origin target = true) : reachable extended origin target = true :=
  pathWitnessReachable extended origin target (retainedPathWitness old extended nodesRetained edgesRetained origin target
    (admittedReachabilityHasPath nodes edges old accepted origin target prior))

theorem retainedReturnTrace (oldEdges extendedEdges : List Edge)
    (retained : ∀ edge, edge ∈ oldEdges → edge ∈ extendedEdges)
    (node : String) (held trace : List String) (prior : ReturnTrace oldEdges node held trace) :
    ReturnTrace extendedEdges node held trace := by
  induction prior with
  | closes node held target edge returned => exact ReturnTrace.closes node held target (retained _ edge) returned
  | advances node held next trace edge fresh continued ih => exact ReturnTrace.advances node held next trace (retained _ edge) fresh ih

theorem retainedCycle (old extended : GeneratedGraph)
    (nodesRetained : ∀ node, node ∈ old.nodes → node ∈ extended.nodes)
    (edgesRetained : ∀ edge, edge ∈ old.edges → edge ∈ extended.edges)
    (prior : directedCycleExists old = true) : directedCycleExists extended = true := by
  obtain ⟨node,member,trace,witness⟩ := (directedCycleIffReturnTrace old).mp prior
  exact (directedCycleIffReturnTrace extended).mpr
    ⟨node,nodesRetained node member,trace,retainedReturnTrace old.edges extended.edges edgesRetained node [node] trace witness⟩

theorem freshNodeRetainsPaths (graph : GeneratedGraph) (fresh : String) (addedEdges : List Edge)
    (path : List String) (valid : pathIsValid graph path = true) :
    pathIsValid ⟨graph.nodes ++ [fresh],graph.edges ++ addedEdges⟩ path = true :=
  retainedPathValid graph _ (fun _ h => memAppendLeft _ _ _ h) (fun _ h => memAppendLeft _ _ _ h) path valid

theorem freshNodeRetainsCycles (graph : GeneratedGraph) (fresh : String) (addedEdges : List Edge)
    (prior : directedCycleExists graph = true) :
    directedCycleExists ⟨graph.nodes ++ [fresh],graph.edges ++ addedEdges⟩ = true :=
  retainedCycle graph _ (fun _ h => memAppendLeft _ _ _ h) (fun _ h => memAppendLeft _ _ _ h) prior

theorem newPathOnOldNodesUsesAddedEdge (graph : GeneratedGraph) (fresh : String) (addedEdges : List Edge)
    (path : List String) (oldNodes : ∀ node, node ∈ path → node ∈ graph.nodes)
    (extendedValid : pathIsValid ⟨graph.nodes ++ [fresh],graph.edges ++ addedEdges⟩ path = true)
    (oldInvalid : pathIsValid graph path = false) :
    ∃ edge, edge ∈ adjacentPairs path ∧ edge ∈ addedEdges ∧ ¬ edge ∈ graph.edges := by
  have meaning := (pathMeaning ⟨graph.nodes ++ [fresh],graph.edges ++ addedEdges⟩ path).mp extendedValid
  cases missing : (adjacentPairs path).any (fun edge => !has graph.edges edge) with
  | true =>
    obtain ⟨edge,member,absentCheck⟩ := (anyTrueWitness (adjacentPairs path) _).mp missing
    have absent : ¬ edge ∈ graph.edges := by
      intro found
      have present := (hasIff _ _).mpr found
      rw [present] at absentCheck
      cases absentCheck
    have extendedMember := meaning.2.2 edge member
    cases memAppendCases edge graph.edges addedEdges extendedMember with
    | inl oldMember => exact False.elim (absent oldMember)
    | inr addedMember => exact ⟨edge,member,addedMember,absent⟩
  | false =>
    have allOld : ∀ edge, edge ∈ adjacentPairs path → edge ∈ graph.edges := by
      intro edge member
      have noMissing := anyFalseAtMember (fun edge => !has graph.edges edge) (adjacentPairs path) missing edge member
      cases present : has graph.edges edge with
      | false => rw [present] at noMissing; cases noMissing
      | true => exact (hasIff _ _).mp present
    have oldValid := (pathMeaning graph path).mpr ⟨meaning.1,oldNodes,allOld⟩
    rw [oldInvalid] at oldValid
    cases oldValid

theorem adjacentEndpointsInPath (path : List String) (edge : Edge) (member : edge ∈ adjacentPairs path) :
    edge.1 ∈ path ∧ edge.2 ∈ path := by
  induction path with
  | nil => cases member
  | cons first rest ih =>
    cases rest with
    | nil => cases member
    | cons second tail =>
      cases member with
      | head => exact ⟨List.Mem.head _,List.Mem.tail first (List.Mem.head _)⟩
      | tail _ h =>
        have endpoints := ih h
        exact ⟨List.Mem.tail first endpoints.1,List.Mem.tail first endpoints.2⟩

theorem freshOnlyEdgesPreserveOldPathDecision (graph : GeneratedGraph) (fresh : String) (addedEdges : List Edge)
    (absent : ¬ fresh ∈ graph.nodes)
    (touchFresh : ∀ edge, edge ∈ addedEdges → edge.1 = fresh ∨ edge.2 = fresh)
    (path : List String) (oldNodes : ∀ node, node ∈ path → node ∈ graph.nodes) :
    pathIsValid ⟨graph.nodes ++ [fresh],graph.edges ++ addedEdges⟩ path = pathIsValid graph path := by
  cases old : pathIsValid graph path with
  | true => exact freshNodeRetainsPaths graph fresh addedEdges path old
  | false =>
    cases extended : pathIsValid ⟨graph.nodes ++ [fresh],graph.edges ++ addedEdges⟩ path with
    | false => rfl
    | true =>
      obtain ⟨edge,member,added,_⟩ := newPathOnOldNodesUsesAddedEdge graph fresh addedEdges path oldNodes extended old
      have endpoints := adjacentEndpointsInPath path edge member
      cases touchFresh edge added with
      | inl left =>
        have inOld := oldNodes edge.1 endpoints.1
        rw [left] at inOld
        exact False.elim (absent inOld)
      | inr right =>
        have inOld := oldNodes edge.2 endpoints.2
        rw [right] at inOld
        exact False.elim (absent inOld)

end SFT.Mathematics.GraphOperations
