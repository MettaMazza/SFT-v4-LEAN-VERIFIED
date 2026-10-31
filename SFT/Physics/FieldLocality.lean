import SFT.Physics.FieldGaugeEquivalence
namespace SFT.Physics.FieldLocality
open MechanicalEvents

-- Adjacency is the generated support relation, not a metric distance rule.
inductive Propagation {State : Type} (adjacent : Event State → Event State → Prop) :
    Event State → Event State → Type where
  | one (a : Event State) : Propagation adjacent a a
  | append {a b c : Event State} : Propagation adjacent a b →
      Change b c → adjacent b c → Propagation adjacent a c

variable {State : Type} {adjacent : Event State → Event State → Prop}

def trace {a b : Event State} : Propagation adjacent a b → Path a b
  | .one _ => .one _
  | .append p change _ => .append (trace p) change

def join {a b c : Event State} (p : Propagation adjacent a b) :
    Propagation adjacent b c → Propagation adjacent a c
  | .one _ => p
  | .append q change h => .append (join p q) change h

theorem joinTrace {a b c : Event State} (p : Propagation adjacent a b) (q : Propagation adjacent b c) :
    trace (join p q) = MechanicalAngularMotion.join (trace p) (trace q) := by
  induction q with
  | one => rfl
  | append q change h ih => exact congrArg (fun path => Path.append path change) ih

theorem everyTransitionAdjacent {a b : Event State} (p : Propagation adjacent a b) :
    ∀ row ∈ changes (trace p), adjacent row.before row.after := by
  induction p with
  | one => intro row h; cases h
  | append p change h ih =>
    intro r member
    change r ∈ changes (trace p) ++ [MechanicalEvents.row change] at member
    have split {A : Type} (xs : List A) (x y : A) : y ∈ xs ++ [x] → y ∈ xs ∨ y = x := by
      induction xs with
      | nil => intro m; cases m with | head => exact Or.inr rfl | tail _ m => cases m
      | cons a xs ih =>
        intro m; cases m with
        | head => exact Or.inl (.head _)
        | tail _ m => cases ih m with
          | inl hm => exact Or.inl (.tail _ hm)
          | inr eq => exact Or.inr eq
    cases split _ _ _ member with
    | inl prior => exact ih _ prior
    | inr eq => cases eq; exact h

theorem nonInitialHasPredecessor {a b : Event State} (p : Propagation adjacent a b) (h : a ≠ b) :
    ∃ prior, adjacent prior b := by
  cases p with
  | one => exact False.elim (h rfl)
  | append p change edge => exact ⟨_,edge⟩

structure Arrival (adjacent : Event State → Event State → Prop) (source : Event State) where
  destination : Event State
  propagation : Propagation adjacent source destination

def accessible {source : Event State} (completed : List (Arrival adjacent source)) :=
  completed.map Arrival.destination

theorem completedExactlyReachable {source target : Event State}
    (completed : List (Arrival adjacent source)) (h : target ∈ accessible completed) :
    ∃ arrival ∈ completed, arrival.destination = target := by
  induction completed with
  | nil => cases h
  | cons a rest ih =>
    cases h with
    | head => exact ⟨a,.head _,rfl⟩
    | tail _ h =>
      obtain ⟨r,member,eq⟩ := ih h
      exact ⟨r,.tail _ member,eq⟩

theorem inaccessibleOutsideCompleted {source target : Event State}
    (completed : List (Arrival adjacent source)) (outside : target ∉ accessible completed) :
    ¬ ∃ arrival ∈ completed, arrival.destination = target := by
  intro ⟨a,member,eq⟩
  have mapped {A B : Type} (f : A → B) (xs : List A) (x : A) (h : x ∈ xs) : f x ∈ xs.map f := by
    induction h with
    | head => exact .head _
    | tail _ _ ih => exact .tail _ ih
  exact outside (eq ▸ mapped _ _ _ member)

theorem successorPreservesAccessibility {source : Event State}
    (completed : List (Arrival adjacent source)) (next : Arrival adjacent source) :
    accessible (completed ++ [next]) = accessible completed ++ [next.destination] :=
  ReferenceRealization.mapAppendOne _ _ _
end SFT.Physics.FieldLocality
