import SFT.Mathematics.DiscreteObjects
namespace SFT.Mathematics.DiscreteObjects

theorem hasAppend {α : Type} [DecidableEq α] (xs ys : List α) (a : α) :
    has (xs ++ ys) a = (has xs a || has ys a) := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    change (if x = a then true else has (xs ++ ys) a) =
      ((if x = a then true else has xs a) || has ys a)
    by_cases h : x = a
    · rw [ite_eq_left h, ite_eq_left h]
      rfl
    · rw [ite_eq_right h, ite_eq_right h]
      exact ih

theorem absentIff {α : Type} [DecidableEq α] (xs : List α) (a : α) :
    has xs a = false ↔ ¬ a ∈ xs := by
  constructor
  · intro h member
    have yes := (hasIff xs a).mpr member
    rw [h] at yes
    cases yes
  · intro h
    cases he : has xs a with
    | false => rfl
    | true => exact False.elim (h ((hasIff xs a).mp he))

theorem distinctCons {α : Type} [DecidableEq α] (x : α) (xs : List α) :
    distinct (x::xs) = true ↔ has xs x = false ∧ distinct xs = true := by
  change (!has xs x && distinct xs) = true ↔ has xs x = false ∧ distinct xs = true
  cases hh : has xs x <;> cases hd : distinct xs <;> decide

theorem freshAppendDistinct {α : Type} [DecidableEq α] (xs : List α) (fresh : α)
    (hd : distinct xs = true) (hf : has xs fresh = false) :
    distinct (xs ++ [fresh]) = true := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    have parts := (distinctCons x xs).mp hd
    have neq : x ≠ fresh := by
      intro he; cases he
      have yes := (hasIff (fresh::xs) fresh).mpr (List.Mem.head _)
      rw [hf] at yes; cases yes
    have tailFresh : has xs fresh = false := by
      rw [has, ite_eq_right neq] at hf
      exact hf
    apply (distinctCons x (xs ++ [fresh])).mpr
    constructor
    · rw [hasAppend, parts.1]
      have rev : fresh ≠ x := fun h => neq h.symm
      change has [fresh] x = false
      rw [has, ite_eq_right rev]
      rfl
    · exact ih parts.2 tailFresh

theorem successorPreservesDistinct (collection : Collection) (fresh : Form)
    (hd : distinct collection = true) (hf : has collection fresh = false) :
    distinct (collection ++ [fresh]) = true := freshAppendDistinct collection fresh hd hf

theorem successfulCollectionDistinct (collection : Collection)
    (h : generatedCollection collection = .ok collection) : distinct collection = true := by
  unfold generatedCollection at h
  cases hd : distinct collection with
  | false => rw [hd] at h; cases hi : collection.isEmpty <;> rw [hi] at h <;> cases h
  | true => rfl

theorem freshSuccessorCollection (collection : Collection) (fresh : Form)
    (h : generatedCollection collection = .ok collection) (hf : has collection fresh = false) :
    generatedCollection (collection ++ [fresh]) = .ok (collection ++ [fresh]) := by
  have hd := freshAppendDistinct collection fresh (successfulCollectionDistinct collection h) hf
  unfold generatedCollection
  cases collection with
  | nil => rw [hd]; rfl
  | cons x xs => rw [hd]; rfl

end SFT.Mathematics.DiscreteObjects
