import SFT.Computation.SecurityPartition
import SFT.Computation.StateTransition
namespace SFT.Computation.Adversarial
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure Schedule where
  strategy : String
  initial : String
  actions : List String
  trace : List String
  finalState : String
  deriving DecidableEq
structure Model where
  system : StateTransition.System
  strategies : List String
  schedules : List Schedule
  resources : Nat
  secureStates : List String
  stoppingStates : List String

def admitted (m : Model) (s : Schedule) : Bool :=
  has m.strategies s.strategy && decide (s.actions.length ≤ m.resources)
def rows (m : Model) : List Schedule := m.schedules.filter (admitted m)
def favorable (m : Model) : List Schedule := (rows m).filter (fun s => has m.secureStates s.finalState)
def unfavorable (m : Model) : List Schedule := (rows m).filter (fun s => !has m.secureStates s.finalState)

theorem rowMeaning (m : Model) (s : Schedule) : s ∈ rows m ↔
    s ∈ m.schedules ∧ s.strategy ∈ m.strategies ∧ s.actions.length ≤ m.resources := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    exact ⟨p.1,(hasIff _ _).mp q.1,of_decide_eq_true q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.2.1,decide_eq_true h.2.2⟩⟩

theorem favorableMeaning (m : Model) (s : Schedule) : s ∈ favorable m ↔ s ∈ rows m ∧ s.finalState ∈ m.secureStates := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

theorem unfavorableMeaning (m : Model) (s : Schedule) : s ∈ unfavorable m ↔ s ∈ rows m ∧ s.finalState ∉ m.secureStates := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    refine ⟨p.1,?_⟩; intro held
    have yes := (hasIff _ _).mpr held; have no := (notTrue _).mp p.2
    rw [yes] at no; cases no
  · intro h
    have no : has m.secureStates s.finalState = false := by
      cases yes : has m.secureStates s.finalState with
      | false => rfl
      | true => exact False.elim (h.2 ((hasIff _ _).mp yes))
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(notTrue _).mpr no⟩

theorem outcomeExhaustion (m : Model) (s : Schedule) (held : s ∈ rows m) : s ∈ favorable m ∨ s ∈ unfavorable m := by
  cases h : has m.secureStates s.finalState with
  | false => exact .inr ((filterMemberIff _ _ _).mpr ⟨held,(notTrue _).mpr h⟩)
  | true => exact .inl ((favorableMeaning _ _).mpr ⟨held,(hasIff _ _).mp h⟩)

theorem outcomeDisjoint (m : Model) (s : Schedule) (h : s ∈ favorable m) : s ∉ unfavorable m :=
  fun bad => ((unfavorableMeaning _ _).mp bad).2 ((favorableMeaning _ _).mp h).2

def secure (m : Model) : Bool := (rows m).all (fun s => has m.secureStates s.finalState)
theorem exactSecurity (m : Model) : secure m = true ↔ ∀ s, s ∈ rows m → s.finalState ∈ m.secureStates := by
  constructor
  · intro h s held; exact (hasIff _ _).mp (allTrueAtMember _ _ h s held)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun s held => (hasIff _ _).mpr (h s held))

def stops (m : Model) (s : Schedule) : Bool := has m.stoppingStates s.finalState
structure Execution (m : Model) where
  schedule : Schedule
  source : schedule ∈ rows m
  execution : StateTransition.run m.system schedule.initial schedule.actions = .ok schedule.trace
  terminal : schedule.trace.getLast? = some schedule.finalState

structure StoppedExecution (m : Model) extends Execution m where
  stopped : stops m schedule = true

theorem executionMeaning (m : Model) (e : Execution m) :
    StateTransition.Execution m.system e.schedule.initial e.schedule.actions e.schedule.trace :=
  (StateTransition.runFromMeaning _ _ _ _).mp ((StateTransition.runAdmission _ _ _ _).mp e.execution).2

theorem actualSecurity (m : Model) (checked : secure m = true) (e : Execution m) : e.schedule.finalState ∈ m.secureStates :=
  (exactSecurity m).mp checked _ e.source

theorem undefinedAdversary (m : Model) (s : Schedule) (absent : s.strategy ∉ m.strategies) : s ∉ rows m :=
  fun h => absent ((rowMeaning _ _).mp h).2.1

theorem overBudget (m : Model) (s : Schedule) (over : ¬ s.actions.length ≤ m.resources) : s ∉ rows m :=
  fun h => over ((rowMeaning _ _).mp h).2.2

structure Extension (first second : Model) : Prop where
  strategies : ∀ x, x ∈ first.strategies → x ∈ second.strategies
  schedules : ∀ x, x ∈ first.schedules → x ∈ second.schedules
  resources : first.resources ≤ second.resources
  secureStates : ∀ x, x ∈ first.secureStates ↔ x ∈ second.secureStates
  stoppingStates : ∀ x, x ∈ first.stoppingStates → x ∈ second.stoppingStates
  runs : ∀ initial actions trace, StateTransition.run first.system initial actions = .ok trace → StateTransition.run second.system initial actions = .ok trace

theorem rowExtension (first second : Model) (inc : Extension first second) (s : Schedule) (held : s ∈ rows first) : s ∈ rows second := by
  have p := (rowMeaning _ _).mp held
  exact (rowMeaning _ _).mpr ⟨inc.schedules _ p.1,inc.strategies _ p.2.1,Nat.le_trans p.2.2 inc.resources⟩

theorem favorableExtension (first second : Model) (inc : Extension first second) (s : Schedule) (h : s ∈ favorable first) : s ∈ favorable second := by
  have p := (favorableMeaning _ _).mp h
  exact (favorableMeaning _ _).mpr ⟨rowExtension _ _ inc _ p.1,(inc.secureStates _).mp p.2⟩

theorem unfavorableExtension (first second : Model) (inc : Extension first second) (s : Schedule) (h : s ∈ unfavorable first) : s ∈ unfavorable second := by
  have p := (unfavorableMeaning _ _).mp h
  exact (unfavorableMeaning _ _).mpr ⟨rowExtension _ _ inc _ p.1,fun bad => p.2 ((inc.secureStates _).mpr bad)⟩

def extendExecution (first second : Model) (inc : Extension first second) (e : Execution first) : Execution second :=
  ⟨e.schedule,rowExtension _ _ inc _ e.source,inc.runs _ _ _ e.execution,e.terminal⟩

def extendStopped (first second : Model) (inc : Extension first second) (e : StoppedExecution first) : StoppedExecution second :=
  ⟨extendExecution _ _ inc e.toExecution,(hasIff _ _).mpr (inc.stoppingStates _ ((hasIff _ _).mp e.stopped))⟩

theorem retainedSchedule (first second : Model) (inc : Extension first second) (e : Execution first) :
    (extendExecution _ _ inc e).schedule = e.schedule := rfl

theorem noUnfavorable (m : Model) (checked : secure m = true) (s : Schedule) : s ∉ unfavorable m := by
  intro bad; have p := (unfavorableMeaning _ _).mp bad
  exact p.2 ((exactSecurity m).mp checked s p.1)

theorem counterexampleRejectsSecurity (m : Model) (s : Schedule) (h : s ∈ unfavorable m) : secure m ≠ true :=
  fun checked => noUnfavorable m checked s h

end SFT.Computation.Adversarial
