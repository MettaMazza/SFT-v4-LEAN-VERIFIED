import SFT.Mathematics.GraphInduction
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem graphConstructorChecks (nodes : List String) (edges : List Edge) :
    makeGraph nodes edges = .ok ⟨nodes,edges⟩ ↔
      (nodes.isEmpty || !distinct nodes) = false ∧ distinct edges = true ∧
      edges.any (fun edge => !has nodes edge.1 || !has nodes edge.2) = false := by
  constructor
  · intro accepted
    unfold makeGraph at accepted
    cases guard : nodes.isEmpty || !distinct nodes <;> rw [guard] at accepted
    · cases unique : distinct edges <;> rw [unique] at accepted
      · cases accepted
      · cases outside : edges.any (fun edge => !has nodes edge.1 || !has nodes edge.2) <;> rw [outside] at accepted
        · exact ⟨rfl,rfl,rfl⟩
        · cases accepted
    · cases accepted
  · intro h
    unfold makeGraph
    rw [h.1,h.2.1,h.2.2]
    rfl

theorem graphConstructorMeaning (nodes : List String) (edges : List Edge) :
    makeGraph nodes edges = .ok ⟨nodes,edges⟩ ↔
      nodes.isEmpty = false ∧ distinct nodes = true ∧ distinct edges = true ∧
      (∀ edge, edge ∈ edges → edge.1 ∈ nodes ∧ edge.2 ∈ nodes) := by
  constructor
  · intro accepted
    have checks := (graphConstructorChecks nodes edges).mp accepted
    have carrier : nodes.isEmpty = false ∧ distinct nodes = true := by
      cases empty : nodes.isEmpty <;> cases unique : distinct nodes <;> rw [empty,unique] at checks
      all_goals try cases checks.1
      exact ⟨rfl,rfl⟩
    exact ⟨carrier.1,carrier.2,checks.2.1,acceptedGraphEndpoints nodes edges _ accepted⟩
  · intro h
    apply (graphConstructorChecks nodes edges).mpr
    refine ⟨?_,h.2.2.1,?_⟩
    · rw [h.1,h.2.1]; rfl
    · apply anyFalseOfMembers
      intro edge member
      have endpoints := h.2.2.2 edge member
      rw [(hasIff _ _).mpr endpoints.1,(hasIff _ _).mpr endpoints.2]
      rfl

theorem freshEdgesDisjoint (nodes : List String) (edges added : List Edge) (fresh : String)
    (endpoints : ∀ edge, edge ∈ edges → edge.1 ∈ nodes ∧ edge.2 ∈ nodes)
    (absent : ¬ fresh ∈ nodes)
    (touchFresh : ∀ edge, edge ∈ added → edge.1 = fresh ∨ edge.2 = fresh) :
    ∀ edge, edge ∈ edges → ¬ edge ∈ added := by
  intro edge oldMember newMember
  have old := endpoints edge oldMember
  cases touchFresh edge newMember with
  | inl h => rw [h] at old; exact absent old.1
  | inr h => rw [h] at old; exact absent old.2

theorem freshGraphAccepted (nodes : List String) (edges added : List Edge) (fresh : String)
    (accepted : makeGraph nodes edges = .ok ⟨nodes,edges⟩)
    (absent : has nodes fresh = false) (uniqueAdded : distinct added = true)
    (addedEndpoints : ∀ edge, edge ∈ added → edge.1 ∈ nodes ++ [fresh] ∧ edge.2 ∈ nodes ++ [fresh])
    (touchFresh : ∀ edge, edge ∈ added → edge.1 = fresh ∨ edge.2 = fresh) :
    makeGraph (nodes ++ [fresh]) (edges ++ added) = .ok ⟨nodes ++ [fresh],edges ++ added⟩ := by
  have old := (graphConstructorMeaning nodes edges).mp accepted
  have absentProp := (absentIff nodes fresh).mp absent
  apply (graphConstructorMeaning _ _).mpr
  refine ⟨?_,freshAppendDistinct nodes fresh old.2.1 absent,
    appendDistinct edges added old.2.2.1 uniqueAdded (freshEdgesDisjoint nodes edges added fresh old.2.2.2 absentProp touchFresh),?_⟩
  · cases nodes <;> rfl
  · intro edge member
    cases memAppendCases edge edges added member with
    | inl h =>
      have ends := old.2.2.2 edge h
      exact ⟨memAppendLeft _ _ _ ends.1,memAppendLeft _ _ _ ends.2⟩
    | inr h => exact addedEndpoints edge h

theorem cutSelectionValid (graph : GeneratedGraph) (held : List String) (result : List Edge)
    (success : crossingCut graph held = .ok result) :
    held.isEmpty = false ∧ ∀ node, node ∈ held → node ∈ graph.nodes := by
  unfold crossingCut at success
  cases empty : held.isEmpty <;> rw [empty] at success
  · cases outside : held.any (fun node => !has graph.nodes node) <;> rw [outside] at success
    · refine ⟨rfl,?_⟩
      intro node member
      have check := anyFalseAtMember _ _ outside node member
      cases present : has graph.nodes node with
      | false => rw [present] at check; cases check
      | true => exact (hasIff _ _).mp present
    · cases success
  · cases success

theorem validCutResult (graph : GeneratedGraph) (held : List String)
    (nonempty : held.isEmpty = false) (within : ∀ node, node ∈ held → node ∈ graph.nodes) :
    crossingCut graph held = .ok (graph.edges.filter (fun edge => has held edge.1 != has held edge.2)) := by
  have outside : held.any (fun node => !has graph.nodes node) = false := by
    apply anyFalseOfMembers
    intro node member
    rw [(hasIff _ _).mpr (within node member)]
    rfl
  unfold crossingCut
  rw [nonempty,outside]
  rfl

theorem cutUnderFreshExtension (graph : GeneratedGraph) (fresh : String) (added : List Edge)
    (held : List String) (prior : List Edge) (computed : crossingCut graph held = .ok prior) :
    crossingCut ⟨graph.nodes ++ [fresh],graph.edges ++ added⟩ held =
      .ok (prior ++ added.filter (fun edge => has held edge.1 != has held edge.2)) := by
  have valid := cutSelectionValid graph held prior computed
  rw [validCutResult _ held valid.1 (fun node member => memAppendLeft _ _ _ (valid.2 node member))]
  change Except.ok ((graph.edges ++ added).filter _) = _
  rw [filterAppendExact,← cutResult graph held prior computed]

theorem balancePairedExtension (incoming outgoing : List (List String)) (newIn newOut : List String)
    (balanced : internalBalance incoming outgoing = true)
    (freshIn : has incoming newIn = false) (freshOut : has outgoing newOut = false) :
    internalBalance (incoming ++ [newIn]) (outgoing ++ [newOut]) = true := by
  have old := (balanceMeaning incoming outgoing).mp balanced
  apply (balanceMeaning _ _).mpr
  refine ⟨?_,?_,freshAppendDistinct incoming newIn old.2.2.1 freshIn,
    freshAppendDistinct outgoing newOut old.2.2.2 freshOut⟩
  · cases incoming <;> rfl
  · rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,old.2.1]
    rfl

theorem freshGraphPairSupportOrder (nodes : List String) (fresh : String) :
    (nodes ++ [fresh]).flatMap (fun left => (nodes ++ [fresh]).map (fun right => (left,right))) =
      nodes.flatMap (fun left => nodes.map (fun right => (left,right)) ++ [(left,fresh)]) ++
      (nodes.map (fun right => (fresh,right)) ++ [(fresh,fresh)]) := by
  have flatAppend {α β : Type} (f : α → List β) (xs ys : List α) :
      (xs ++ ys).flatMap f = xs.flatMap f ++ ys.flatMap f := by
    induction xs with
    | nil => rfl
    | cons x xs ih =>
      change f x ++ (xs ++ ys).flatMap f = (f x ++ xs.flatMap f) ++ ys.flatMap f
      rw [ih,ExactTraceArithmetic.appendAssociative]
  have distribute (items : List String) :
      items.flatMap (fun left => (nodes ++ [fresh]).map (fun right => (left,right))) =
      items.flatMap (fun left => nodes.map (fun right => (left,right)) ++ [(left,fresh)]) := by
    induction items with
    | nil => rfl
    | cons left rest ih =>
      change (nodes ++ [fresh]).map (fun right => (left,right)) ++
        rest.flatMap (fun left => (nodes ++ [fresh]).map (fun right => (left,right))) =
        (nodes.map (fun right => (left,right)) ++ [(left,fresh)]) ++
        rest.flatMap (fun left => nodes.map (fun right => (left,right)) ++ [(left,fresh)])
      rw [ExactTraceArithmetic.mapAppend,ih]
      rfl
  rw [flatAppend,distribute nodes]
  apply congrArg (List.append _)
  change ((nodes ++ [fresh]).map (fun right => (fresh,right))) ++ [] = _
  rw [ExactTraceArithmetic.mapAppend]
  have appendNil (xs : List Edge) : xs ++ [] = xs := by
    induction xs with
    | nil => rfl
    | cons x xs ih => exact congrArg (List.cons x) ih
  rw [appendNil]
  rfl

end SFT.Mathematics.GraphOperations
