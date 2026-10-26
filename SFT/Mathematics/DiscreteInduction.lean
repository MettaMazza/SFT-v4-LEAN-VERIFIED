import SFT.Mathematics.DiscreteSuccession
namespace SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

theorem distinctSnocParts {α : Type} [DecidableEq α] (xs : List α) (last : α)
    (h : distinct (xs ++ [last]) = true) : distinct xs = true ∧ has xs last = false := by
  induction xs with
  | nil => exact ⟨rfl,rfl⟩
  | cons x xs ih =>
    have parts := (distinctCons x (xs ++ [last])).mp h
    have tail := ih parts.2
    have absent := (absentIff (xs ++ [last]) x).mp parts.1
    have noHead : has xs x = false := (absentIff xs x).mpr (fun hx => absent (memAppendLeft _ _ _ hx))
    have neq : x ≠ last := by
      intro eq
      cases eq
      exact absent (memAppendRight _ _ _ (List.Mem.head _))
    constructor
    · exact (distinctCons x xs).mpr ⟨noHead,tail.1⟩
    · rw [has,ite_eq_right neq]
      exact tail.2

theorem snocInduction {α : Type} (P : List α → Prop) (base : P [])
    (step : ∀ xs a, P xs → P (xs ++ [a])) : ∀ xs, P xs := by
  have extend : ∀ suffix initial, P initial → P (initial ++ suffix) := by
    intro suffix
    induction suffix with
    | nil =>
      intro initial h
      have eq : initial ++ [] = initial := by
        clear h
        induction initial with
        | nil => rfl
        | cons x xs ih => exact congrArg (List.cons x) ih
      rw [eq]
      exact h
    | cons x xs ih =>
      intro initial h
      have result := ih (initial ++ [x]) (step initial x h)
      rw [ExactTraceArithmetic.appendAssociative] at result
      exact result
  intro xs
  exact extend xs [] base

theorem uniqueNonemptyTraceInduction (P : Collection → Prop)
    (base : ∀ form, P [form])
    (step : ∀ collection fresh, collection ≠ [] → distinct collection = true →
      has collection fresh = false → P collection → P (collection ++ [fresh]))
    (collection : Collection) (nonempty : collection ≠ []) (unique : distinct collection = true) :
    P collection := by
  have all : ∀ xs : Collection, xs ≠ [] → distinct xs = true → P xs := by
    apply snocInduction (fun xs : Collection => xs ≠ [] → distinct xs = true → P xs)
    · intro impossible _
      exact False.elim (impossible rfl)
    · intro xs fresh ih _ hd
      have parts := distinctSnocParts xs fresh hd
      cases xs with
      | nil => exact base fresh
      | cons x tail =>
        have ne : x::tail ≠ [] := by intro h; cases h
        exact step (x::tail) fresh ne parts.1 parts.2 (ih ne parts.1)
  exact all collection nonempty unique

theorem acceptedCollectionNonempty (collection : Collection)
    (h : generatedCollection collection = .ok collection) : collection ≠ [] := by
  intro eq
  cases eq
  cases h

theorem generatedCollectionInduction (P : Collection → Prop)
    (base : ∀ form, P [form])
    (step : ∀ collection fresh, generatedCollection collection = .ok collection →
      has collection fresh = false → P collection → P (collection ++ [fresh]))
    (collection : Collection) (accepted : generatedCollection collection = .ok collection) :
    P collection := by
  apply uniqueNonemptyTraceInduction P base
  · intro xs fresh hn hd hp ih
    have hx : generatedCollection xs = .ok xs := by
      cases xs with
      | nil => exact False.elim (hn rfl)
      | cons x tail => unfold generatedCollection; rw [hd]; rfl
    exact step xs fresh hx hp ih
  · exact acceptedCollectionNonempty collection accepted
  · exact successfulCollectionDistinct collection accepted

inductive CollectionTrace : Collection → Prop where
  | single (form : Form) : CollectionTrace [form]
  | successor (collection : Collection) (fresh : Form)
      (prior : CollectionTrace collection) (freshness : has collection fresh = false) :
      CollectionTrace (collection ++ [fresh])

theorem singletonCollectionAccepted (form : Form) : generatedCollection [form] = .ok [form] := rfl

theorem traceCollectionAccepted (collection : Collection) (trace : CollectionTrace collection) :
    generatedCollection collection = .ok collection := by
  induction trace with
  | single form => exact singletonCollectionAccepted form
  | successor xs fresh prior hf ih => exact freshSuccessorCollection xs fresh ih hf

theorem acceptedCollectionTrace (collection : Collection)
    (h : generatedCollection collection = .ok collection) : CollectionTrace collection :=
  generatedCollectionInduction CollectionTrace CollectionTrace.single
    (fun xs fresh _ hf prior => CollectionTrace.successor xs fresh prior hf) collection h

theorem acceptedIffConstructionTrace (collection : Collection) :
    generatedCollection collection = .ok collection ↔ CollectionTrace collection :=
  ⟨acceptedCollectionTrace collection, traceCollectionAccepted collection⟩

end SFT.Mathematics.DiscreteObjects
