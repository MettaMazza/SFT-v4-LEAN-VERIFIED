import SFT.Mathematics.ArrangementSuccessor
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Mathematics.CombinatorialArrangements
open DiscreteObjects SFT.Foundation.Count.TraceDerivation
open SFT.Foundation.CommonRefinement

theorem arrangementTraceNonempty (items : List String) (nonempty : items ≠ [])
    (unique : distinct items = true) : (arrangementsCore items).isEmpty = false := by
  have member := everyPermutationGenerated items nonempty unique items (List.Perm.refl _)
  cases h : arrangementsCore items with
  | nil => rw [h] at member; cases member
  | cons x xs => rfl

theorem heldTraceNonempty (items : List String) (held : String)
    (nonempty : items ≠ []) (unique : distinct items = true) :
    ((arrangementsCore items).map (List.cons held)).isEmpty = false := by
  have h := arrangementTraceNonempty items nonempty unique
  cases eq : arrangementsCore items with
  | nil => rw [eq] at h; cases h
  | cons x xs => rfl

theorem heldTraceDisjoint (held : String) (suffixes : List Form)
    (others : List String) (branches : String → List Form) (absent : ¬ held ∈ others) :
    ∀ form, form ∈ suffixes.map (List.cons held) →
      ¬ form ∈ others.flatMap (fun label => (branches label).map (List.cons label)) := by
  intro form first rest
  obtain ⟨suffix,_,eq⟩ := memMapPreimage _ _ _ first
  obtain ⟨label,member,branch⟩ := memFlatMapOrigin _ _ _ rest
  obtain ⟨otherSuffix,_,otherEq⟩ := memMapPreimage _ _ _ branch
  have same := (List.cons.inj (eq.trans otherEq.symm)).1
  cases same
  exact absent member

theorem disjointTraceGuard (left right : List Form)
    (disjoint : ∀ form, form ∈ left → ¬ form ∈ right) :
    left.any (ExactTraceArithmetic.contains right) = false := by
  apply anyFalseOfMembers
  intro form member
  apply anyFalseOfMembers
  intro other otherMember
  change decide (form = other) = false
  apply decide_eq_false
  intro eq
  cases eq
  exact disjoint form member otherMember

theorem heldChoiceArithmeticJunction (first second : String) (rest : List String)
    (unique : distinct (first :: second :: rest) = true) :
    ExactTraceArithmetic.disjointJunction
      ((arrangementsCore (remainder (first::second::rest) first)).map (List.cons first))
      ((second::rest).flatMap (fun held =>
        (arrangementsCore (remainder (first::second::rest) held)).map (List.cons held))) =
      .ok (arrangementsCore (first::second::rest)) := by
  have firstGuards := recursiveRemainderAdmitted first second rest first unique (List.Mem.head _)
  have secondGuards := recursiveRemainderAdmitted first second rest second unique
    (List.Mem.tail _ (List.Mem.head _))
  rw [arrangementsStepByValues]
  apply ExactTraceArithmetic.disjointJunctionAdmitted
  · exact heldTraceNonempty _ first firstGuards.1 firstGuards.2
  · have positive := heldTraceNonempty _ second secondGuards.1 secondGuards.2
    change (((arrangementsCore (remainder (first::second::rest) second)).map (List.cons second)) ++
      rest.flatMap (fun held => (arrangementsCore (remainder (first::second::rest) held)).map (List.cons held))).isEmpty = false
    cases eq : (arrangementsCore (remainder (first::second::rest) second)).map (List.cons second) with
    | nil => rw [eq] at positive; cases positive
    | cons x xs => rfl
  · apply disjointTraceGuard
    exact heldTraceDisjoint _ _ _ _ ((absentIff _ _).mp ((distinctCons _ _).mp unique).1)

theorem heldBranchCount (labels : List String) (branches : String → List Form) :
    (labels.flatMap (fun held => (branches held).map (List.cons held))).length =
      labels.foldr (fun held total => (branches held).length + total) 0 := by
  induction labels with
  | nil => rfl
  | cons label rest ih =>
    change ((branches label).map (List.cons label) ++
      rest.flatMap (fun held => (branches held).map (List.cons held))).length = _
    rw [appendLength,mapLength,ih]
    rfl

theorem arrangementCountRecurrence (first second : String) (rest : List String) :
    (arrangementsCore (first::second::rest)).length =
      (first::second::rest).foldr
        (fun held total => (arrangementsCore (remainder (first::second::rest) held)).length + total) 0 := by
  rw [arrangementsStepByValues]
  exact heldBranchCount _ _

theorem arrangementCountBase (label : String) : (arrangementsCore [label]).length = 1 := by
  rw [arrangementsSingle]
  rfl

end SFT.Mathematics.CombinatorialArrangements
