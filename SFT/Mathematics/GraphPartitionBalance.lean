import SFT.Mathematics.GraphExtension
import SFT.Mathematics.DiscreteInduction
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem edgeFilterCongruent (first second : Edge → Bool) (edges : List Edge)
    (same : ∀ edge, edge ∈ edges → first edge = second edge) : edges.filter first = edges.filter second := by
  induction edges with
  | nil => rfl
  | cons edge rest ih =>
    have agree := same edge (List.Mem.head rest)
    have tail := ih (fun cell h => same cell (List.Mem.tail edge h))
    cases tested : first edge with
    | false =>
      have other : second edge = false := agree.symm.trans tested
      rw [List.filter_cons_of_neg (p := first) (by rw [tested]; intro h; cases h),
        List.filter_cons_of_neg (p := second) (by rw [other]; intro h; cases h)]
      exact tail
    | true =>
      have other : second edge = true := agree.symm.trans tested
      rw [List.filter_cons_of_pos (p := first) tested,List.filter_cons_of_pos (p := second) other]
      exact congrArg (List.cons edge) tail

theorem cutCheckHeldAppend (held : List String) (added : String) (edge : Edge) :
    (has (held ++ [added]) edge.1 != has (held ++ [added]) edge.2) =
      ((has held edge.1 || has [added] edge.1) != (has held edge.2 || has [added] edge.2)) := by
  rw [hasAppend,hasAppend]

theorem cutHeldSelectionExtension (graph : GeneratedGraph) (held : List String) (prior : List Edge)
    (computed : crossingCut graph held = .ok prior) (added : String) (member : added ∈ graph.nodes) :
    crossingCut graph (held ++ [added]) = .ok (graph.edges.filter (fun edge =>
      (has held edge.1 || has [added] edge.1) != (has held edge.2 || has [added] edge.2))) := by
  have valid := cutSelectionValid graph held prior computed
  have nonempty : (held ++ [added]).isEmpty = false := by cases held <;> rfl
  have within : ∀ node, node ∈ held ++ [added] → node ∈ graph.nodes := by
    intro node h
    cases memAppendCases node held [added] h with
    | inl h => exact valid.2 node h
    | inr h =>
      cases h with
      | head => exact member
      | tail _ h => cases h
  rw [validCutResult graph (held ++ [added]) nonempty within]
  exact congrArg Except.ok (edgeFilterCongruent _ _ graph.edges (fun edge _ => cutCheckHeldAppend held added edge))

theorem cutCheckUnchangedAway (held : List String) (added : String) (edge : Edge)
    (left : edge.1 ≠ added) (right : edge.2 ≠ added) :
    (has (held ++ [added]) edge.1 != has (held ++ [added]) edge.2) = (has held edge.1 != has held edge.2) := by
  rw [cutCheckHeldAppend]
  have first : has [added] edge.1 = false := by
    unfold has
    rw [ite_eq_right (fun h => left h.symm)]
    rfl
  have second : has [added] edge.2 = false := by
    unfold has
    rw [ite_eq_right (fun h => right h.symm)]
    rfl
  rw [first,second]
  cases has held edge.1 <;> cases has held edge.2 <;> rfl

theorem freshHeldCutUpdate (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (accepted : makeGraph nodes edges = .ok graph) (fresh : String) (addedEdges : List Edge)
    (absent : ¬ fresh ∈ graph.nodes) (held : List String) (prior : List Edge)
    (computed : crossingCut graph held = .ok prior) :
    crossingCut ⟨graph.nodes ++ [fresh],graph.edges ++ addedEdges⟩ (held ++ [fresh]) =
      .ok (prior ++ addedEdges.filter (fun edge => has (held ++ [fresh]) edge.1 != has (held ++ [fresh]) edge.2)) := by
  have valid := cutSelectionValid graph held prior computed
  have endpoints := acceptedGraphEndpoints nodes edges graph accepted
  have nonempty : (held ++ [fresh]).isEmpty = false := by cases held <;> rfl
  have within : ∀ node, node ∈ held ++ [fresh] → node ∈ graph.nodes ++ [fresh] := by
    intro node member
    cases memAppendCases node held [fresh] member with
    | inl h => exact memAppendLeft _ _ _ (valid.2 node h)
    | inr h => exact memAppendRight _ _ _ h
  rw [validCutResult _ _ nonempty within]
  change Except.ok ((graph.edges ++ addedEdges).filter _) = _
  rw [filterAppendExact]
  have retained : graph.edges.filter (fun edge => has (held ++ [fresh]) edge.1 != has (held ++ [fresh]) edge.2) =
      graph.edges.filter (fun edge => has held edge.1 != has held edge.2) := by
    apply edgeFilterCongruent
    intro edge member
    have ends := endpoints edge member
    apply cutCheckUnchangedAway
    · intro h; rw [h] at ends; exact absent ends.1
    · intro h; rw [h] at ends; exact absent ends.2
  rw [retained,← cutResult graph held prior computed]

theorem balancePairedExtensionIff (incoming outgoing : List (List String)) (newIn newOut : List String) :
    internalBalance (incoming ++ [newIn]) (outgoing ++ [newOut]) = true ↔
      incoming.length = outgoing.length ∧ distinct incoming = true ∧ distinct outgoing = true ∧
      has incoming newIn = false ∧ has outgoing newOut = false := by
  constructor
  · intro balanced
    have result := (balanceMeaning _ _).mp balanced
    have incomingParts := distinctSnocParts incoming newIn result.2.2.1
    have outgoingParts := distinctSnocParts outgoing newOut result.2.2.2
    have counts := result.2.1
    rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength] at counts
    exact ⟨Nat.succ.inj counts,incomingParts.1,outgoingParts.1,incomingParts.2,outgoingParts.2⟩
  · intro conditions
    apply (balanceMeaning _ _).mpr
    refine ⟨?_,?_,freshAppendDistinct incoming newIn conditions.2.1 conditions.2.2.2.1,
      freshAppendDistinct outgoing newOut conditions.2.2.1 conditions.2.2.2.2⟩
    · cases incoming <;> rfl
    · rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,conditions.1]
      rfl

theorem balancedPairRequiresFreshTokens (incoming outgoing : List (List String)) (newIn newOut : List String)
    (balanced : internalBalance incoming outgoing = true) :
    internalBalance (incoming ++ [newIn]) (outgoing ++ [newOut]) = true ↔
      has incoming newIn = false ∧ has outgoing newOut = false := by
  constructor
  · intro extended
    exact ((balancePairedExtensionIff incoming outgoing newIn newOut).mp extended).2.2.2
  · intro fresh
    exact balancePairedExtension incoming outgoing newIn newOut balanced fresh.1 fresh.2

theorem firstTokenPairBalanced (incoming outgoing : List String) :
    internalBalance [incoming] [outgoing] = true := rfl

end SFT.Mathematics.GraphOperations
