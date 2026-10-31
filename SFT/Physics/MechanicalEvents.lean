import SFT.Physics.QuantityCarrier
import SFT.Physics.ReferenceRealization
namespace SFT.Physics.MechanicalEvents
open SFT.Physics.QuantityCarrier SFT.Host.Canonical
-- mechanics_laws.py EVENT_CHANGE. State is the held source carrier; the
-- construction is uniform in it and never replaces its contents with a scalar.
abbrev Event (State : Type) := Observation State

structure Change {State : Type} (before after : Event State) where
  sourceIdentity : String
  actionRecord : Value

structure Row (State : Type) where
  before : Event State
  after : Event State
  sourceIdentity : String
  actionRecord : Value

def row {State : Type} {a b : Event State} (c : Change a b) : Row State :=
  ⟨a,b,c.sourceIdentity,c.actionRecord⟩

inductive Path {State : Type} : Event State → Event State → Type where
  | one (a : Event State) : Path a a
  | append {a b c : Event State} : Path a b → Change b c → Path a c

def events {State : Type} {a b : Event State} : Path a b → List (Event State)
  | .one _ => [a]
  | .append prior _ => events prior ++ [b]

def changes {State : Type} {a b : Event State} : Path a b → List (Row State)
  | .one _ => []
  | .append prior step => changes prior ++ [row step]

def sourceRecords {State : Type} {a b : Event State} : Path a b → List (String × Value)
  | .one _ => []
  | .append prior step => sourceRecords prior ++ [(step.sourceIdentity,step.actionRecord)]

def count {State : Type} {a b : Event State} (p : Path a b) := (changes p).length

theorem oneEvent {State : Type} (a : Event State) : events (.one a) = [a] := rfl

theorem oneHasNoTransition {State : Type} (a : Event State) : changes (.one a) = [] := rfl

theorem successorRetainsEvents {State : Type} {a b c : Event State}
    (p : Path a b) (step : Change b c) : events (.append p step) = events p ++ [c] := rfl

theorem successorRetainsChanges {State : Type} {a b c : Event State}
    (p : Path a b) (step : Change b c) :
    changes (.append p step) = changes p ++ [row step] := rfl

theorem successorAddsOne {State : Type} {a b c : Event State}
    (p : Path a b) (step : Change b c) : count (.append p step) = count p + 1 :=
  SFT.Physics.ReferenceRealization.lengthAppendOne _ _

theorem completeEventCount {State : Type} {a b : Event State} (p : Path a b) :
    (events p).length = count p + 1 := by
  induction p with
  | one => rfl
  | append prior step ih =>
    rw [successorRetainsEvents,SFT.Physics.ReferenceRealization.lengthAppendOne,ih,successorAddsOne]

theorem traceNonempty {State : Type} {a b : Event State} (p : Path a b) :
    events p ≠ [] := by
  intro empty
  have h := completeEventCount p
  rw [empty] at h
  exact Nat.noConfusion h

theorem rowRetainsBothStates {State : Type} {a b : Event State} (step : Change a b) :
    (row step).before = a ∧ (row step).after = b := ⟨rfl,rfl⟩

theorem rowRetainsBothObservations {State : Type} {a b : Event State} (step : Change a b) :
    (row step).before.record = a.record ∧ (row step).after.record = b.record := ⟨rfl,rfl⟩

theorem rowRetainsAction {State : Type} {a b : Event State} (step : Change a b) :
    (row step).sourceIdentity = step.sourceIdentity ∧
    (row step).actionRecord = step.actionRecord := ⟨rfl,rfl⟩

theorem allSourceRecordsRetained {State : Type} {a b : Event State} (p : Path a b) :
    (changes p).map (fun r => (r.sourceIdentity,r.actionRecord)) = sourceRecords p := by
  induction p with
  | one => rfl
  | append prior step ih =>
    change (changes prior ++ [row step]).map _ = sourceRecords prior ++ [_]
    rw [SFT.Physics.ReferenceRealization.mapAppendOne,ih]
    rfl

theorem changedEndpointDistinguished {State : Type} (left right : Row State)
    (changed : left.before ≠ right.before ∨ left.after ≠ right.after) : left ≠ right := by
  intro equal
  cases changed with
  | inl h => exact h (congrArg Row.before equal)
  | inr h => exact h (congrArg Row.after equal)

theorem changedSourceDistinguished {State : Type} (left right : Row State)
    (changed : left.sourceIdentity ≠ right.sourceIdentity) : left ≠ right :=
  fun equal => changed (congrArg Row.sourceIdentity equal)

theorem changedActionDistinguished {State : Type} (left right : Row State)
    (changed : left.actionRecord ≠ right.actionRecord) : left ≠ right :=
  fun equal => changed (congrArg Row.actionRecord equal)

theorem fullRowReconstruction {State : Type} (r : Row State) :
    (⟨r.before,r.after,r.sourceIdentity,r.actionRecord⟩ : Row State) = r := rfl
end SFT.Physics.MechanicalEvents
