import SFT.Foundation.Count
import SFT.Foundation.OneDerivation
/-! Native finite trace syntax for count.py::closure_record base/successor clauses.
There is a structural-One base and a newly generated terminal at each extension.
Positions identify generated occurrences by their place in this finite syntax;
there is no interpretation as an imported numerical count or completed infinity.
This encodes the source prose, separately from its ten-class record grammar. -/
namespace SFT.Foundation.Count.TraceDerivation

inductive Trace where
  | base
  | extend : Trace → Trace

inductive Position : Trace → Type where
  | base : Position .base
  | prior {t : Trace} : Position t → Position (.extend t)
  | terminal {t : Trace} : Position (.extend t)

def occurrenceShape {t : Trace} (_ : Position t) : One.Candidate := One.survivor

def complete : (t : Trace) → List (Position t)
  | .base => [.base]
  | .extend t => (complete t).map Position.prior ++ [.terminal]

def previous {t : Trace} (xs : List (Position t)) : List (Position (.extend t)) :=
  xs.map Position.prior

theorem generatedOccurrenceIsStructuralOne {t : Trace} (p : Position t) :
    One.survives (occurrenceShape p) = true := rfl

theorem memAppendLeft {α : Type} (x : α) (xs ys : List α) (h : x ∈ xs) : x ∈ xs ++ ys := by
  induction xs with
  | nil => cases h
  | cons a xs ih =>
    cases h with
    | head => exact List.Mem.head _
    | tail _ hx => exact List.Mem.tail _ (ih hx)

theorem memAppendRight {α : Type} (x : α) (xs ys : List α) (h : x ∈ ys) : x ∈ xs ++ ys := by
  induction xs with
  | nil => exact h
  | cons a xs ih => exact List.Mem.tail _ ih

theorem memMap {α β : Type} (f : α → β) (x : α) (xs : List α) (h : x ∈ xs) :
    f x ∈ xs.map f := by
  induction xs with
  | nil => cases h
  | cons a xs ih =>
    cases h with
    | head => exact List.Mem.head _
    | tail _ hx => exact List.Mem.tail _ (ih hx)

theorem memMapPreimage {α β : Type} (f : α → β) (b : β) (xs : List α)
    (h : b ∈ xs.map f) : ∃ a, a ∈ xs ∧ f a = b := by
  induction xs with
  | nil => cases h
  | cons a xs ih =>
    cases h with
    | head => exact ⟨a, List.Mem.head _, rfl⟩
    | tail _ h =>
      obtain ⟨x,hx,eq⟩ := ih h
      exact ⟨x,List.Mem.tail _ hx,eq⟩

theorem everyGeneratedPositionRetained (t : Trace) (p : Position t) : p ∈ complete t := by
  induction p with
  | base => exact List.Mem.head _
  | prior p ih => exact memAppendLeft _ _ _ (memMap _ _ _ ih)
  | terminal => exact memAppendRight _ _ _ (List.Mem.head _)

theorem terminalAbsentFromPrevious {t : Trace} (xs : List (Position t)) :
    Position.terminal ∉ previous xs := by
  intro h
  obtain ⟨p,_,eq⟩ := memMapPreimage Position.prior Position.terminal xs h
  cases eq

theorem priorEmbeddingInjective {t : Trace} (a b : Position t)
    (h : Position.prior a = Position.prior b) : a = b := by
  cases h
  rfl

theorem baseRetainsOne : complete .base = [Position.base] := rfl

theorem successorRetainsPreviousAndTerminal (t : Trace) :
    complete (.extend t) = previous (complete t) ++ [Position.terminal] := rfl

theorem previousCoverageIsProper (t : Trace) :
    (∀ p, p ∈ previous (complete t) → p ∈ complete (.extend t)) ∧
    (Position.terminal ∈ complete (.extend t) ∧ Position.terminal ∉ previous (complete t)) :=
  ⟨fun p h => memAppendLeft p _ _ h,
   everyGeneratedPositionRetained (.extend t) Position.terminal,
   terminalAbsentFromPrevious (complete t)⟩

theorem completeNonempty (t : Trace) : complete t ≠ [] := by
  cases t with
  | base => intro h; cases h
  | extend t =>
    intro h
    have member := everyGeneratedPositionRetained (.extend t) Position.terminal
    rw [h] at member
    cases member

theorem memAppendCases {α : Type} (x : α) (xs ys : List α)
    (h : x ∈ xs ++ ys) : x ∈ xs ∨ x ∈ ys := by
  induction xs with
  | nil => exact Or.inr h
  | cons a xs ih =>
    cases h with
    | head => exact Or.inl (List.Mem.head _)
    | tail _ hx =>
      cases ih hx with
      | inl left => exact Or.inl (List.Mem.tail _ left)
      | inr right => exact Or.inr right

theorem nodupMapInjective {α β : Type} (f : α → β)
    (inj : ∀ a b, f a = f b → a = b) (xs : List α) (h : xs.Nodup) :
    (xs.map f).Nodup := by
  induction xs with
  | nil => exact List.Pairwise.nil
  | cons a xs ih =>
    cases h with
    | cons distinct rest =>
      apply List.Pairwise.cons
      · intro y hy eq
        obtain ⟨x,hx,eqx⟩ := memMapPreimage f y xs hy
        exact distinct x hx (inj a x (eq.trans eqx.symm))
      · exact ih rest

theorem nodupAppendFresh {α : Type} (xs : List α) (b : α)
    (h : xs.Nodup) (fresh : b ∉ xs) : (xs ++ [b]).Nodup := by
  induction xs with
  | nil => exact List.Pairwise.cons (fun _ hm => by cases hm) List.Pairwise.nil
  | cons a xs ih =>
    cases h with
    | cons distinct rest =>
      apply List.Pairwise.cons
      · intro y hy eq
        cases memAppendCases y xs [b] hy with
        | inl hx => exact distinct y hx eq
        | inr hb =>
          cases hb with
          | head => cases eq; exact fresh (List.Mem.head _)
          | tail _ impossible => cases impossible
      · exact ih rest (fun hb => fresh (List.Mem.tail _ hb))

theorem everyGeneratedPositionRetainedOnce (t : Trace) : (complete t).Nodup := by
  induction t with
  | base => exact List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
  | extend t ih =>
    exact nodupAppendFresh _ _
      (nodupMapInjective Position.prior priorEmbeddingInjective (complete t) ih)
      (terminalAbsentFromPrevious (complete t))

theorem nodupAppendRequiresFresh {α : Type} (xs : List α) (b : α)
    (h : (xs ++ [b]).Nodup) : b ∉ xs := by
  induction xs with
  | nil => intro impossible; cases impossible
  | cons a xs ih =>
    cases h with
    | cons distinct rest =>
      intro member
      cases member with
      | head => exact distinct b (memAppendRight b xs [b] (List.Mem.head _)) rfl
      | tail _ hb => exact ih rest hb

theorem repeatingGeneratedOccurrenceBreaksExactMultiplicity (t : Trace) (p : Position t) :
    ¬ (complete t ++ [p]).Nodup := by
  intro h
  exact nodupAppendRequiresFresh _ _ h (everyGeneratedPositionRetained t p)

theorem removingGeneratedOccurrenceLosesCompleteness (t : Trace) (p : Position t)
    (remaining : List (Position t)) (absent : p ∉ remaining) :
    ¬ (∀ q : Position t, q ∈ remaining) := by
  intro completeCoverage
  exact absent (completeCoverage p)

theorem finiteGenerationPreservesExactRetention (t : Trace) :
    complete t ≠ [] ∧ (∀ p : Position t, p ∈ complete t) ∧ (complete t).Nodup :=
  ⟨completeNonempty t, everyGeneratedPositionRetained t, everyGeneratedPositionRetainedOnce t⟩

-- The two source generation clauses retain the base once, then retain the
-- existing prefix and the newly generated terminal once at each extension.
inductive FollowsCompleteGeneration : (t : Trace) → List (Position t) → Prop where
  | base : FollowsCompleteGeneration .base [Position.base]
  | extend {t : Trace} {xs : List (Position t)} : FollowsCompleteGeneration t xs →
      FollowsCompleteGeneration (.extend t) (previous xs ++ [Position.terminal])

theorem completeFollowsGeneration (t : Trace) : FollowsCompleteGeneration t (complete t) := by
  induction t with
  | base => exact FollowsCompleteGeneration.base
  | extend t ih => exact FollowsCompleteGeneration.extend ih

theorem completeGenerationDeterminesIdentity {t : Trace} {xs : List (Position t)}
    (h : FollowsCompleteGeneration t xs) : xs = complete t := by
  induction h with
  | base => rfl
  | extend h ih => rw [ih]; rfl

theorem uniqueCompleteGeneratedTrace (t : Trace) :
    ∃ xs : List (Position t), FollowsCompleteGeneration t xs ∧
      ∀ ys, FollowsCompleteGeneration t ys → ys = xs :=
  ⟨complete t, completeFollowsGeneration t, fun _ h => completeGenerationDeterminesIdentity h⟩

end SFT.Foundation.Count.TraceDerivation
