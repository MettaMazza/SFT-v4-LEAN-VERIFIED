import SFT.Mathematics.DiscreteRelations
import SFT.Mathematics.DiscreteSuccession
namespace SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

theorem filterMemberIff {α : Type} (p : α → Bool) (xs : List α) (a : α) :
    a ∈ xs.filter p ↔ a ∈ xs ∧ p a = true := by
  induction xs with
  | nil => constructor <;> intro h; cases h; cases h.1
  | cons x xs ih =>
    cases hp : p x with
    | false =>
      rw [List.filter_cons_of_neg (by rw [hp]; intro impossible; cases impossible)]
      constructor
      · intro h; have ht := ih.mp h; exact ⟨List.Mem.tail _ ht.1,ht.2⟩
      · intro h
        cases h.1 with
        | head => rw [hp] at h; cases h.2
        | tail _ ht => exact ih.mpr ⟨ht,h.2⟩
    | true =>
      rw [List.filter_cons_of_pos hp]
      constructor
      · intro h
        cases h with
        | head => exact ⟨List.Mem.head _,hp⟩
        | tail _ ht => have t := ih.mp ht; exact ⟨List.Mem.tail _ t.1,t.2⟩
      · intro h
        cases h.1 with
        | head => exact List.Mem.head _
        | tail _ ht => exact List.Mem.tail _ (ih.mpr ⟨ht,h.2⟩)

theorem filterDistinct {α : Type} [DecidableEq α] (p : α → Bool) (xs : List α)
    (h : distinct xs = true) : distinct (xs.filter p) = true := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    have parts := (distinctCons x xs).mp h
    cases hp : p x with
    | false => rw [List.filter_cons_of_neg (by rw [hp]; intro impossible; cases impossible)]; exact ih parts.2
    | true =>
      rw [List.filter_cons_of_pos hp]
      apply (distinctCons x (xs.filter p)).mpr
      exact ⟨(absentIff _ _).mpr (fun hm => (absentIff xs x).mp parts.1 ((filterMemberIff p xs x).mp hm).1),ih parts.2⟩

def relationComplement (left right : Collection) (held : Relation) : Relation :=
  (completePairs left right).filter (fun pair => !has held pair)

theorem complementMemberIff (left right : Collection) (held : Relation) (pair : Form × Form) :
    pair ∈ relationComplement left right held ↔
      (pair.1 ∈ left ∧ pair.2 ∈ right) ∧ ¬ pair ∈ held := by
  constructor
  · intro h
    have parts := (filterMemberIff _ _ pair).mp h
    have absent : has held pair = false := by
      cases he : has held pair with
      | false => rfl
      | true => rw [he] at parts; cases parts.2
    exact ⟨(completePairIff left right pair.1 pair.2).mp parts.1,(absentIff held pair).mp absent⟩
  · intro h
    apply (filterMemberIff _ _ pair).mpr
    constructor
    · exact (completePairIff left right pair.1 pair.2).mpr h.1
    · rw [(absentIff held pair).mpr h.2]; rfl

theorem complementDisjoint (left right : Collection) (held : Relation) (pair : Form × Form)
    (h : pair ∈ relationComplement left right held) : ¬ pair ∈ held :=
  ((complementMemberIff left right held pair).mp h).2

theorem complementCoversSupport (left right : Collection) (held : Relation) (pair : Form × Form)
    (h : pair ∈ completePairs left right) : pair ∈ held ∨ pair ∈ relationComplement left right held := by
  cases he : has held pair with
  | true => exact Or.inl ((hasIff held pair).mp he)
  | false => exact Or.inr ((complementMemberIff left right held pair).mpr
      ⟨(completePairIff left right pair.1 pair.2).mp h,(absentIff held pair).mp he⟩)

theorem complementDistinct (left right : Collection) (held : Relation)
    (h : distinct (completePairs left right) = true) : distinct (relationComplement left right held) = true :=
  filterDistinct _ _ h

theorem anyFalseOfMembers {α : Type} (p : α → Bool) (xs : List α)
    (h : ∀ a, a ∈ xs → p a = false) : xs.any p = false := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    change (p x || xs.any p) = false
    rw [h x (List.Mem.head _),ih (fun a ha => h a (List.Mem.tail _ ha))]
    rfl

theorem complementAcceptedOnDistinctSupport (left right : Collection) (held : Relation)
    (h : distinct (completePairs left right) = true) :
    generatedRelation left right (relationComplement left right held) = .ok (relationComplement left right held) := by
  have unique := complementDistinct left right held h
  have inside : (relationComplement left right held).any (fun pair => !has (completePairs left right) pair) = false := by
    apply anyFalseOfMembers
    intro pair hp
    have hm := ((filterMemberIff _ _ pair).mp hp).1
    rw [(hasIff _ pair).mpr hm]
    rfl
  unfold generatedRelation
  rw [inside,unique]
  rfl

theorem mapDistinct {α β : Type} [DecidableEq α] [DecidableEq β]
    (f : α → β) (injective : ∀ a b, f a = f b → a = b) (xs : List α)
    (h : distinct xs = true) : distinct (xs.map f) = true := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    have parts := (distinctCons x xs).mp h
    apply (distinctCons (f x) (xs.map f)).mpr
    constructor
    · apply (absentIff _ _).mpr
      intro member
      obtain ⟨a,ha,eq⟩ := memMapPreimage f (f x) xs member
      have same := injective a x eq
      cases same
      exact (absentIff xs x).mp parts.1 ha
    · exact ih parts.2

theorem appendDistinct {α : Type} [DecidableEq α] (xs ys : List α)
    (hx : distinct xs = true) (hy : distinct ys = true)
    (disjoint : ∀ a, a ∈ xs → ¬ a ∈ ys) : distinct (xs ++ ys) = true := by
  induction xs with
  | nil => exact hy
  | cons x xs ih =>
    have parts := (distinctCons x xs).mp hx
    apply (distinctCons x (xs ++ ys)).mpr
    constructor
    · apply (absentIff _ _).mpr
      intro member
      cases memAppendCases x xs ys member with
      | inl first => exact (absentIff xs x).mp parts.1 first
      | inr second => exact disjoint x (List.Mem.head _) second
    · exact ih parts.2 (fun a ha => disjoint a (List.Mem.tail _ ha))

theorem completePairsDistinct (left right : Collection)
    (hl : distinct left = true) (hr : distinct right = true) :
    distinct (completePairs left right) = true := by
  induction left with
  | nil => rfl
  | cons x xs ih =>
    have parts := (distinctCons x xs).mp hl
    apply appendDistinct (right.map (fun y => (x,y))) (completePairs xs right)
    · exact mapDistinct (fun y => (x,y)) (fun a b eq => congrArg Prod.snd eq) right hr
    · exact ih parts.2
    · intro pair row remaining
      obtain ⟨y,hy,eq⟩ := memMapPreimage (fun y => (x,y)) pair right row
      cases eq
      exact (absentIff xs x).mp parts.1 ((completePairIff xs right x y).mp remaining).1

theorem complementOfGeneratedCollectionsAccepted (left right : Collection) (held : Relation)
    (hl : generatedCollection left = .ok left) (hr : generatedCollection right = .ok right) :
    generatedRelation left right (relationComplement left right held) = .ok (relationComplement left right held) :=
  complementAcceptedOnDistinctSupport left right held (completePairsDistinct left right
    (successfulCollectionDistinct left hl) (successfulCollectionDistinct right hr))

theorem doubleComplementMembership (left right : Collection) (held : Relation)
    (accepted : generatedRelation left right held = .ok held) (pair : Form × Form) :
    pair ∈ relationComplement left right (relationComplement left right held) ↔ pair ∈ held := by
  constructor
  · intro h
    have outer := (complementMemberIff left right _ pair).mp h
    cases he : has held pair with
    | true => exact (hasIff held pair).mp he
    | false =>
      exact False.elim (outer.2 ((complementMemberIff left right held pair).mpr
        ⟨outer.1,(absentIff held pair).mp he⟩))
  · intro h
    apply (complementMemberIff left right _ pair).mpr
    constructor
    · exact generatedRelationContained left right held held accepted pair h
    · intro hc
      exact complementDisjoint left right held pair hc h

end SFT.Mathematics.DiscreteObjects
