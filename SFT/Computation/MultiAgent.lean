import SFT.Computation.StateExtension
import SFT.Computation.OptimizationTrace
namespace SFT.Computation.MultiAgent
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
structure JointRow where
  source : String
  target : String
  actions : List (String × String)
  outcome : String
  deriving DecidableEq
structure Model where
  agents : List String
  states : List String
  actionSupport : List (String × String)
  observations : List (String × String × String)
  outcomes : List String
  jointRelation : List JointRow
  communication : SFT.Computation.StateTransition.System

def actionSupported (m : Model) (action : String × String) : Bool := has m.agents action.1 && has m.actionSupport action
def rowAdmitted (m : Model) (row : JointRow) : Bool :=
  has m.states row.source && has m.states row.target && has m.outcomes row.outcome &&
  row.actions.all (actionSupported m)
def rows (m : Model) : List JointRow := m.jointRelation.filter (rowAdmitted m)
def localObservations (m : Model) (agent state : String) : List (String × String × String) :=
  m.observations.filter (fun r => decide (r.1 = agent) && decide (r.2.1 = state))

theorem observationMeaning (m : Model) (agent state : String) (r : String × String × String) :
    r ∈ localObservations m agent state ↔ r ∈ m.observations ∧ r.1 = agent ∧ r.2.1 = state := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have a := (andTrue _ _).mp p.2
    exact ⟨p.1,of_decide_eq_true a.1,of_decide_eq_true a.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨decide_eq_true h.2.1,decide_eq_true h.2.2⟩⟩

theorem actionMeaning (m : Model) (a : String × String) : actionSupported m a = true ↔ a.1 ∈ m.agents ∧ a ∈ m.actionSupport := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; exact ⟨(hasIff _ _).mp p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,(hasIff _ _).mpr h.2⟩

theorem recordedActionsSupported (m : Model) (row : JointRow) (held : row ∈ rows m) :
    ∀ action, action ∈ row.actions → action.1 ∈ m.agents ∧ action ∈ m.actionSupport := by
  have p := (filterMemberIff _ _ _).mp held
  have a := (andTrue _ _).mp p.2
  intro action member
  exact (actionMeaning _ _).mp (allTrueAtMember _ _ a.2 action member)
theorem rowMeaning (m : Model) (row : JointRow) : row ∈ rows m ↔
    row ∈ m.jointRelation ∧ row.source ∈ m.states ∧ row.target ∈ m.states ∧ row.outcome ∈ m.outcomes ∧
    ∀ a, a ∈ row.actions → a.1 ∈ m.agents ∧ a ∈ m.actionSupport := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    have a := (andTrue _ _).mp p.2
    have b := (andTrue _ _).mp a.1
    have c := (andTrue _ _).mp b.1
    exact ⟨p.1,(hasIff _ _).mp c.1,(hasIff _ _).mp c.2,(hasIff _ _).mp b.2,recordedActionsSupported _ _ h⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.2.1,(hasIff _ _).mpr h.2.2.1⟩,(hasIff _ _).mpr h.2.2.2.1⟩,
      (allTrueIffMembers _ _).mpr (fun a held => (actionMeaning _ _).mpr (h.2.2.2.2 a held))⟩⟩

inductive JointTrace (m : Model) : String → List JointRow → String → Prop where
 | base (state) (held : state ∈ m.states) : JointTrace m state [] state
 | next (row rest last) (held : row ∈ rows m) (tail : JointTrace m row.target rest last) :
     JointTrace m row.source (row :: rest) last

theorem jointComposition (m : Model) (initial middle last : String) (left right : List JointRow)
    (first : JointTrace m initial left middle) (second : JointTrace m middle right last) :
    JointTrace m initial (left ++ right) last := by
  induction first with
  | base state held => exact second
  | next row rest endState held tail ih => exact .next _ _ _ held (ih second)

def communication (m : Model) (initial : String) (actions : List String) :=
  SFT.Computation.StateTransition.run m.communication initial actions

theorem communicationMeaning (m : Model) (initial : String) (actions trace : List String)
    (ran : communication m initial actions = .ok trace) :
    initial ∈ m.communication.states ∧ SFT.Computation.StateTransition.Execution m.communication initial actions trace := by
  have p := (SFT.Computation.StateTransition.runAdmission _ _ _ _).mp ran
  exact ⟨p.1,(SFT.Computation.StateTransition.runFromMeaning _ _ _ _).mp p.2⟩
def finalState (state : String) : List JointRow → String
 | [] => state
 | row :: rest => finalState row.target rest

def replay (m : Model) (state : String) : List JointRow → Bool
 | [] => has m.states state
 | row :: rest => (decide (row.source = state) && has (rows m) row) && replay m row.target rest

theorem replayMeaning (m : Model) (state : String) (path : List JointRow) :
    replay m state path = true ↔ JointTrace m state path (finalState state path) := by
  induction path generalizing state with
  | nil =>
    constructor
    · intro h; exact .base _ ((hasIff _ _).mp h)
    · intro h; cases h with | base _ held => exact (hasIff _ _).mpr held
  | cons row rest ih =>
    constructor
    · intro h
      have a := (andTrue _ _).mp h
      have b := (andTrue _ _).mp a.1
      have same : row.source = state := of_decide_eq_true b.1
      cases same
      exact .next _ _ _ ((hasIff _ _).mp b.2) ((ih _).mp a.2)
    · intro h
      cases h with
      | next row rest last held tail =>
        exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨decide_eq_true rfl,(hasIff _ _).mpr held⟩,(ih _).mpr tail⟩
def cycleCheck (m : Model) (initial : String) (path : List JointRow) : Bool :=
  replay m initial path && decide (finalState initial path = initial)
def cycleLedger (m : Model) (paths : List (String × List JointRow)) : List (String × List JointRow) :=
  paths.filter (fun p => cycleCheck m p.1 p.2)

theorem traceEnd (m : Model) (initial last : String) (path : List JointRow)
    (trace : JointTrace m initial path last) : finalState initial path = last := by
  induction trace with
  | base state held => rfl
  | next row rest last held tail ih => exact ih

theorem cycleMeaning (m : Model) (initial : String) (path : List JointRow) :
    cycleCheck m initial path = true ↔ JointTrace m initial path initial := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have trace := (replayMeaning _ _ _).mp p.1
    have same : finalState initial path = initial := of_decide_eq_true p.2
    rw [same] at trace; exact trace
  · intro trace
    have same := traceEnd _ _ _ _ trace
    apply (andTrue _ _).mpr
    refine ⟨(replayMeaning _ _ _).mpr ?_,decide_eq_true same⟩
    rw [same]; exact trace

theorem cycleLedgerMeaning (m : Model) (paths : List (String × List JointRow)) (initial : String) (path : List JointRow) :
    (initial,path) ∈ cycleLedger m paths ↔ (initial,path) ∈ paths ∧ JointTrace m initial path initial := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(cycleMeaning _ _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(cycleMeaning _ _ _).mpr h.2⟩

structure Extension (first second : Model) where
  agents : ∀ x, x ∈ first.agents → x ∈ second.agents
  states : ∀ x, x ∈ first.states → x ∈ second.states
  actions : ∀ x, x ∈ first.actionSupport → x ∈ second.actionSupport
  outcomes : ∀ x, x ∈ first.outcomes → x ∈ second.outcomes
  relation : ∀ x, x ∈ first.jointRelation → x ∈ second.jointRelation

theorem rowExtension (first second : Model) (extension : Extension first second) (row : JointRow)
    (held : row ∈ rows first) : row ∈ rows second := by
  have p := (rowMeaning _ _).mp held
  exact (rowMeaning _ _).mpr ⟨extension.relation _ p.1,extension.states _ p.2.1,
    extension.states _ p.2.2.1,extension.outcomes _ p.2.2.2.1,
    fun a member => ⟨extension.agents _ (p.2.2.2.2 a member).1,extension.actions _ (p.2.2.2.2 a member).2⟩⟩

theorem traceExtension (first second : Model) (extension : Extension first second)
    (initial last : String) (path : List JointRow) (trace : JointTrace first initial path last) :
    JointTrace second initial path last := by
  induction trace with
  | base state held => exact .base _ (extension.states _ held)
  | next row rest last held tail ih => exact .next _ _ _ (rowExtension _ _ extension _ held) ih
end SFT.Computation.MultiAgent
