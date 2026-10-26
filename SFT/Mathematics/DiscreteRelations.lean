import SFT.Mathematics.DiscreteObjects
namespace SFT.Mathematics.DiscreteObjects
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

theorem completePairIff (left right : Collection) (a b : Form) :
    (a,b) ∈ completePairs left right ↔ a ∈ left ∧ b ∈ right := by
  constructor
  · intro h
    obtain ⟨x,hx,row⟩ := memFlatMapOrigin (fun x => right.map (fun y => (x,y))) left (a,b) h
    obtain ⟨y,hy,eq⟩ := memMapPreimage (fun y => (x,y)) (a,b) right row
    cases eq
    exact ⟨hx,hy⟩
  · intro h
    exact memFlatMap _ left a (a,b) h.1 (memMap (fun y => (a,y)) b right h.2)

theorem generatedRelationContained (left right : Collection) (held result : Relation)
    (h : generatedRelation left right held = .ok result) (pair : Form × Form)
    (hp : pair ∈ result) : pair.1 ∈ left ∧ pair.2 ∈ right := by
  have same := generatedRelationPreserves left right held result h
  cases same
  unfold generatedRelation at h
  cases ha : held.any (fun p => !has (completePairs left right) p) with
  | true => rw [ha] at h; cases h
  | false =>
    have hn := anyFalseAtMember (fun p => !has (completePairs left right) p) held ha pair hp
    have hm : has (completePairs left right) pair = true := by
      cases he : has (completePairs left right) pair with
      | false => rw [he] at hn; cases hn
      | true => rfl
    exact (completePairIff left right pair.1 pair.2).mp ((hasIff _ _).mp hm)

theorem allTrueIffMembers {α : Type} (p : α → Bool) (xs : List α) :
    xs.all p = true ↔ ∀ a, a ∈ xs → p a = true := by
  induction xs with
  | nil =>
    constructor
    · intro _ a h; cases h
    · intro _; rfl
  | cons x xs ih =>
    constructor
    · intro h a ha
      have hx : p x = true := by
        cases he : p x with
        | false => simp only [List.all_cons, he, Bool.false_and] at h; cases h
        | true => rfl
      have ht : xs.all p = true := by
        change (p x && xs.all p) = true at h
        rw [hx] at h
        exact h
      cases ha with
      | head => exact hx
      | tail _ ha => exact ih.mp ht a ha
    · intro h
      have hx := h x (List.Mem.head xs)
      have ht := ih.mpr (fun a ha => h a (List.Mem.tail x ha))
      change (p x && xs.all p) = true
      rw [hx, ht]
      rfl

theorem totalSingleValuedIff (source : Collection) (relation : Relation) :
    isTotalSingleValued source relation = true ↔
      ∀ item, item ∈ source → (relation.filter (fun pair => decide (pair.1 = item))).length = 1 := by
  constructor
  · intro h item hi
    exact of_decide_eq_true ((allTrueIffMembers _ source).mp h item hi)
  · intro h
    exact (allTrueIffMembers _ source).mpr (fun item hi => decide_eq_true (h item hi))

theorem filterLengthOne {α : Type} (p : α → Bool) (xs : List α)
    (h : (xs.filter p).length = 1) : ∃ x, xs.filter p = [x] := by
  cases he : xs.filter p with
  | nil => rw [he] at h; cases h
  | cons x rest =>
    cases rest with
    | nil => exact ⟨x,rfl⟩
    | cons y ys =>
      rw [he] at h
      exact False.elim ((Nat.noConfusion (Nat.succ.inj h) : False))

theorem totalMapSingleRetainedPair (source : Collection) (relation : Relation)
    (h : isTotalSingleValued source relation = true) (item : Form) (hi : item ∈ source) :
    ∃ pair, relation.filter (fun p => decide (p.1 = item)) = [pair] :=
  filterLengthOne _ _ ((totalSingleValuedIff source relation).mp h item hi)

end SFT.Mathematics.DiscreteObjects
