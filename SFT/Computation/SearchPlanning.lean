import SFT.Computation.StateExtension
namespace SFT.Computation.SearchPlanning
open SFT.Computation.StateTransition
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
structure Model where
  system : System
  initial : String
  goals : List String
  plans : List (List String)

def terminal (initial : String) : List String → String
 | [] => initial
 | state :: rest => terminal state rest

def accepted (m : Model) (plan : List String) : Bool :=
  match run m.system m.initial plan with
  | .error _ => false
  | .ok trace => has m.goals (terminal m.initial trace)
def selected (m : Model) : List (List String) := m.plans.filter (accepted m)
def failures (m : Model) : List (List String) := m.plans.filter (fun p => !accepted m p)
def ledger (m : Model) : List (List String × Except String (List String)) :=
  m.plans.map (fun p => (p,run m.system m.initial p))
def resources (m : Model) : List (List String × Nat) := m.plans.map (fun p => (p,p.length))

theorem acceptedMeaning (m : Model) (plan : List String) : accepted m plan = true ↔
    ∃ trace, run m.system m.initial plan = .ok trace ∧ terminal m.initial trace ∈ m.goals := by
  unfold accepted
  cases result : run m.system m.initial plan with
  | error e =>
    constructor
    · intro bad; cases bad
    · intro ⟨trace,bad,_⟩; cases bad
  | ok trace =>
    constructor
    · intro yes; exact ⟨trace,rfl,(hasIff _ _).mp yes⟩
    · intro ⟨other,same,goal⟩; cases same; exact (hasIff _ _).mpr goal

theorem selectionMeaning (m : Model) (plan : List String) : plan ∈ selected m ↔
    plan ∈ m.plans ∧ ∃ trace, run m.system m.initial plan = .ok trace ∧ terminal m.initial trace ∈ m.goals := by
  constructor
  · intro held; have p := (filterMemberIff _ _ _).mp held; exact ⟨p.1,(acceptedMeaning _ _).mp p.2⟩
  · intro held; exact (filterMemberIff _ _ _).mpr ⟨held.1,(acceptedMeaning _ _).mpr held.2⟩

theorem selectedExecution (m : Model) (plan : List String) (held : plan ∈ selected m) :
    ∃ trace, m.initial ∈ m.system.states ∧ Execution m.system m.initial plan trace ∧ terminal m.initial trace ∈ m.goals := by
  obtain ⟨_,trace,ran,goal⟩ := (selectionMeaning _ _).mp held
  have p := (runAdmission _ _ _ _).mp ran
  exact ⟨trace,p.1,(runFromMeaning _ _ _ _).mp p.2,goal⟩

theorem exhaustive (m : Model) (plan : List String) (held : plan ∈ m.plans) :
    plan ∈ selected m ∨ plan ∈ failures m := by
  cases checked : accepted m plan with
  | true => exact .inl ((filterMemberIff _ _ _).mpr ⟨held,checked⟩)
  | false => exact .inr ((filterMemberIff _ _ _).mpr ⟨held,(notTrue _).mpr checked⟩)

theorem disjoint (m : Model) (plan : List String) (held : plan ∈ selected m) : plan ∉ failures m := by
  intro bad
  have yes := ((filterMemberIff _ _ _).mp held).2
  have no := (notTrue _).mp ((filterMemberIff _ _ _).mp bad).2
  rw [yes] at no; cases no

theorem runFailure (m : Model) (plan : List String) (error : String)
    (failed : run m.system m.initial plan = .error error) : accepted m plan = false := by
  unfold accepted; rw [failed]
theorem ledgerComplete (m : Model) (plan : List String) :
    (plan,run m.system m.initial plan) ∈ ledger m ↔ plan ∈ m.plans := by
  constructor
  · intro held
    obtain ⟨original,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
    have identity := congrArg Prod.fst same
    dsimp only at identity
    cases identity
    exact member
  · intro held; exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem resourceComplete (m : Model) (plan : List String) :
    (plan,plan.length) ∈ resources m ↔ plan ∈ m.plans := by
  constructor
  · intro held
    obtain ⟨original,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
    have identity := congrArg Prod.fst same
    dsimp only at identity
    cases identity
    exact member
  · intro held; exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

structure Extension (first second : Model) where
  initial : first.initial = second.initial
  admitted : create second.system.states second.system.actions second.system.transitions = .ok second.system
  states : ∀ s, s ∈ first.system.states → s ∈ second.system.states
  rows : ∀ r, r ∈ first.system.transitions → r ∈ second.system.transitions
  goals : ∀ g, g ∈ first.goals → g ∈ second.goals
  plans : ∀ p, p ∈ first.plans → p ∈ second.plans

theorem selectedExtension (first second : Model) (extension : Extension first second)
    (plan : List String) (held : plan ∈ selected first) : plan ∈ selected second := by
  obtain ⟨member,trace,ran,goal⟩ := (selectionMeaning _ _).mp held
  apply (selectionMeaning _ _).mpr
  refine ⟨extension.plans _ member,trace,?_,?_⟩
  · rw [← extension.initial]
    exact SFT.Computation.StateExtension.extendRun _ _ extension.admitted extension.states extension.rows _ _ _ ran
  · rw [← extension.initial]
    exact extension.goals _ goal
theorem terminalAppend (initial last : String) (before : List String) :
    terminal initial (before ++ [last]) = last := by
  induction before generalizing initial with
  | nil => rfl
  | cons head rest ih => exact ih head

theorem planComposition (m : Model) (middle last : String) (left right before after : List String)
    (initial : m.initial ∈ m.system.states)
    (first : SFT.Computation.StateComposition.Path m.system m.initial left before middle)
    (second : SFT.Computation.StateComposition.Path m.system middle right after last)
    (supported : left ++ right ∈ m.plans) (goal : last ∈ m.goals) :
    left ++ right ∈ selected m := by
  apply (selectionMeaning _ _).mpr
  refine ⟨supported,(before ++ after) ++ [last],?_,?_⟩
  · exact SFT.Computation.StateComposition.nativeComposition _ _ _ _ _ _ _ _ initial first second
  · rw [terminalAppend]; exact goal
end SFT.Computation.SearchPlanning
