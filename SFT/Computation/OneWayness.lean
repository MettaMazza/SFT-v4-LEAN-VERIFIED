import SFT.Computation.StateTransition
import SFT.InformationScience.MutualObservation
namespace SFT.Computation.OneWayness
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.GeometryTopology
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

structure Forward where
  support : List String
  mapping : Observation
  total : ∀ x, x ∈ support → ∃ y, image mapping x = some y

structure Attempt where
  identity : String
  observed : String
  proposed : String
  actions : List String
  states : List String
  deriving DecidableEq

structure Grammar where
  machine : StateTransition.System
  initial : String
  attempts : List Attempt
  bound : Nat

def admitted (g : Grammar) (a : Attempt) : Prop :=
  a ∈ g.attempts ∧ StateTransition.run g.machine g.initial a.actions = .ok a.states ∧ a.actions.length ≤ g.bound

def success (f : Forward) (a : Attempt) : Bool :=
  has f.support a.proposed && belongs f.mapping a.observed a.proposed

def successLedger (f : Forward) (g : Grammar) : List (String × Bool) :=
  g.attempts.map (fun a => (a.identity,success f a))

theorem successMeaning (f : Forward) (a : Attempt) : success f a = true ↔
    a.proposed ∈ f.support ∧ image f.mapping a.proposed = some a.observed := by
  constructor
  · intro h; have p := (andTrue _ _).mp h
    exact ⟨(hasIff _ _).mp p.1,(belongsMeaning _ _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,(belongsMeaning _ _ _).mpr h.2⟩

theorem successFibre (f : Forward) (a : Attempt) :
    success f a = true ↔ a.proposed ∈ fibre f.support f.mapping a.observed := by
  constructor
  · intro h; exact (fibreMembership _ _ _ _).mpr ((successMeaning _ _).mp h)
  · intro h; exact (successMeaning _ _).mpr ((fibreMembership _ _ _ _).mp h)

theorem everyForwardImageHasPredecessor (f : Forward) (x : String) (held : x ∈ f.support) :
    ∃ y, x ∈ fibre f.support f.mapping y := by
  obtain ⟨y,h⟩ := f.total x held
  exact ⟨y,(fibreMembership _ _ _ _).mpr ⟨held,h⟩⟩

theorem exhaustiveInverseContainsSource (f : Forward) (x y : String)
    (held : x ∈ f.support) (mapped : image f.mapping x = some y) : x ∈ fibre f.support f.mapping y :=
  (fibreMembership _ _ _ _).mpr ⟨held,mapped⟩

theorem ledgerComplete (f : Forward) (g : Grammar) (a : Attempt) (held : a ∈ g.attempts) :
    (a.identity,success f a) ∈ successLedger f g := memMap _ _ _ held

theorem ledgerProvenance (f : Forward) (g : Grammar) (row : String × Bool)
    (held : row ∈ successLedger f g) : ∃ a, a ∈ g.attempts ∧ (a.identity,success f a) = row :=
  memMapPreimage _ _ _ held

def boundedFailure (f : Forward) (g : Grammar) : Prop :=
  ∀ a, admitted g a → success f a = false

theorem noAdmittedSuccess (f : Forward) (g : Grammar) (failed : boundedFailure f g) :
    ¬ ∃ a, admitted g a ∧ success f a = true := by
  intro ⟨a,held,succeeded⟩
  have both := (failed a held).symm.trans succeeded
  cases both

theorem outOfGrammar (g : Grammar) (a : Attempt) (missing : a ∉ g.attempts) : ¬ admitted g a :=
  fun h => missing h.1

theorem overBudget (g : Grammar) (a : Attempt) (over : ¬ a.actions.length ≤ g.bound) : ¬ admitted g a :=
  fun h => over h.2.2

theorem extendedGrammarRetains (first second : Grammar)
    (sameMachine : first.machine = second.machine) (sameInitial : first.initial = second.initial)
    (included : ∀ a, a ∈ first.attempts → a ∈ second.attempts)
    (budget : first.bound ≤ second.bound) (a : Attempt) (held : admitted first a) : admitted second a := by
  refine ⟨included a held.1,?_,Nat.le_trans held.2.2 budget⟩
  rw [← sameMachine,← sameInitial]; exact held.2.1

def traceMatches (g : Grammar) (a : Attempt) : Bool :=
  match StateTransition.run g.machine g.initial a.actions with
  | .error _ => false
  | .ok states => decide (states = a.states)

theorem traceMatchesMeaning (g : Grammar) (a : Attempt) : traceMatches g a = true ↔
    StateTransition.run g.machine g.initial a.actions = .ok a.states := by
  unfold traceMatches
  cases h : StateTransition.run g.machine g.initial a.actions with
  | error e => constructor <;> intro h <;> cases h
  | ok states =>
    constructor
    · intro h; exact congrArg Except.ok (of_decide_eq_true h)
    · intro h; cases h; exact decide_eq_true rfl

def boundedAttempts (g : Grammar) : List Attempt :=
  g.attempts.filter (fun a => traceMatches g a && decide (a.actions.length ≤ g.bound))

theorem boundedAttemptsMeaning (g : Grammar) (a : Attempt) : a ∈ boundedAttempts g ↔ admitted g a := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    exact ⟨p.1,(traceMatchesMeaning _ _).mp q.1,of_decide_eq_true q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr
      ⟨h.1,(andTrue _ _).mpr ⟨(traceMatchesMeaning _ _).mpr h.2.1,decide_eq_true h.2.2⟩⟩

def allBoundedFail (f : Forward) (g : Grammar) : Bool :=
  (boundedAttempts g).all (fun a => !success f a)

theorem exactBoundedFailure (f : Forward) (g : Grammar) : allBoundedFail f g = true ↔ boundedFailure f g := by
  constructor
  · intro h a admitted
    have no := allTrueAtMember _ _ h a ((boundedAttemptsMeaning _ _).mpr admitted)
    cases result : success f a with
    | false => rfl
    | true => rw [result] at no; cases no
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro a held
    rw [h a ((boundedAttemptsMeaning _ _).mp held)]
    rfl

theorem computedNoAdmittedSuccess (f : Forward) (g : Grammar) (checked : allBoundedFail f g = true) :
    ¬ ∃ a, admitted g a ∧ success f a = true := noAdmittedSuccess f g ((exactBoundedFailure _ _).mp checked)

end SFT.Computation.OneWayness
