import SFT.Computation.OptimizationTrace
namespace SFT.Computation.Reinforcement
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
abbrev Interaction := String × String × String × String
abbrev Policy := String × List (String × String)
structure Model where
  states : List String
  actions : List String
  outcomes : List String
  environment : List Interaction
  policies : List Policy
  initial : String
  trajectories : List (List Interaction)
  comparison : SFT.Mathematics.OptimizationSelection.Preference

def rowAdmitted (m : Model) (p : Policy) (state : String) (row : Interaction) : Bool :=
  decide (row.1 = state) && has m.states row.1 && has m.states row.2.2.1 &&
  has m.actions row.2.1 && has m.outcomes row.2.2.2 && has m.environment row && has p.2 (row.1,row.2.1)

def replay (m : Model) (p : Policy) (state : String) : List Interaction → Bool
 | [] => has m.states state
 | row :: rest => rowAdmitted m p state row && replay m p row.2.2.1 rest

def retained (m : Model) (p : Policy) : List (List Interaction) := m.trajectories.filter (replay m p m.initial)
def rejected (m : Model) (p : Policy) : List (List Interaction) := m.trajectories.filter (fun t => !replay m p m.initial t)
def labels (trace : List Interaction) : List String := trace.map (fun row => row.2.2.2)
def evaluations (m : Model) : List (Policy × List (List Interaction)) := m.policies.map (fun p => (p,retained m p))

inductive Trace (m : Model) (p : Policy) : String → List Interaction → Prop where
 | base (state) (held : state ∈ m.states) : Trace m p state []
 | next (state row rest) (admitted : rowAdmitted m p state row = true)
     (tail : Trace m p row.2.2.1 rest) : Trace m p state (row::rest)

theorem replayMeaning (m : Model) (p : Policy) (state : String) (rows : List Interaction) :
    replay m p state rows = true ↔ Trace m p state rows := by
  induction rows generalizing state with
  | nil =>
    constructor
    · intro h; exact .base _ ((hasIff _ _).mp h)
    · intro h; cases h with | base _ held => exact (hasIff _ _).mpr held
  | cons row rest ih =>
    constructor
    · intro h; have h' := (andTrue _ _).mp h; exact .next _ _ _ h'.1 ((ih _).mp h'.2)
    · intro h; cases h with | next _ _ _ admitted tail => exact (andTrue _ _).mpr ⟨admitted,(ih _).mpr tail⟩

theorem retainedMeaning (m : Model) (p : Policy) (trace : List Interaction) :
    trace ∈ retained m p ↔ trace ∈ m.trajectories ∧ Trace m p m.initial trace := by
  constructor
  · intro h; have q := (filterMemberIff _ _ _).mp h; exact ⟨q.1,(replayMeaning _ _ _ _).mp q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(replayMeaning _ _ _ _).mpr h.2⟩

theorem exhaustion (m : Model) (p : Policy) (trace : List Interaction) (held : trace ∈ m.trajectories) :
    trace ∈ retained m p ∨ trace ∈ rejected m p := by
  cases result : replay m p m.initial trace with
  | true => exact .inl ((filterMemberIff _ _ _).mpr ⟨held,result⟩)
  | false => exact .inr ((filterMemberIff _ _ _).mpr ⟨held,(notTrue _).mpr result⟩)
theorem rowMeaning (m : Model) (p : Policy) (state : String) (row : Interaction) :
    rowAdmitted m p state row = true ↔
    row.1 = state ∧ row.1 ∈ m.states ∧ row.2.2.1 ∈ m.states ∧ row.2.1 ∈ m.actions ∧
    row.2.2.2 ∈ m.outcomes ∧ row ∈ m.environment ∧ (row.1,row.2.1) ∈ p.2 := by
  constructor
  · intro h
    have a := (andTrue _ _).mp h
    have b := (andTrue _ _).mp a.1
    have c := (andTrue _ _).mp b.1
    have d := (andTrue _ _).mp c.1
    have e := (andTrue _ _).mp d.1
    have f := (andTrue _ _).mp e.1
    exact ⟨of_decide_eq_true f.1,(hasIff _ _).mp f.2,(hasIff _ _).mp e.2,
      (hasIff _ _).mp d.2,(hasIff _ _).mp c.2,(hasIff _ _).mp b.2,(hasIff _ _).mp a.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨decide_eq_true h.1,(hasIff _ _).mpr h.2.1⟩,
      (hasIff _ _).mpr h.2.2.1⟩,(hasIff _ _).mpr h.2.2.2.1⟩,(hasIff _ _).mpr h.2.2.2.2.1⟩,
      (hasIff _ _).mpr h.2.2.2.2.2.1⟩,(hasIff _ _).mpr h.2.2.2.2.2.2⟩

def compared (m : Model) : List String := SFT.Computation.OptimizationTrace.scan m.comparison [] (m.policies.map Prod.fst)
theorem comparisonMeaning (m : Model) (name : String) : name ∈ compared m ↔
    name ∈ m.policies.map Prod.fst ∧ ∀ better, ¬ (better,name) ∈ m.comparison :=
  SFT.Computation.OptimizationTrace.survivorCertificate _ _ _

theorem evaluationComplete (m : Model) (p : Policy) : (p,retained m p) ∈ evaluations m ↔ p ∈ m.policies := by
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
  states : ∀ s, s ∈ first.states → s ∈ second.states
  actions : ∀ a, a ∈ first.actions → a ∈ second.actions
  outcomes : ∀ o, o ∈ first.outcomes → o ∈ second.outcomes
  environment : ∀ r, r ∈ first.environment → r ∈ second.environment
  trajectories : ∀ t, t ∈ first.trajectories → t ∈ second.trajectories

theorem rowExtension (first second : Model) (extension : Extension first second) (p : Policy)
    (state : String) (row : Interaction) (held : rowAdmitted first p state row = true) :
    rowAdmitted second p state row = true := by
  have h := (rowMeaning _ _ _ _).mp held
  exact (rowMeaning _ _ _ _).mpr ⟨h.1,extension.states _ h.2.1,extension.states _ h.2.2.1,
    extension.actions _ h.2.2.2.1,extension.outcomes _ h.2.2.2.2.1,
    extension.environment _ h.2.2.2.2.2.1,h.2.2.2.2.2.2⟩

theorem traceExtension (first second : Model) (extension : Extension first second) (p : Policy)
    (state : String) (rows : List Interaction) (trace : Trace first p state rows) : Trace second p state rows := by
  induction trace with
  | base state held => exact .base _ (extension.states _ held)
  | next state row rest admitted tail ih => exact .next _ _ _ (rowExtension _ _ extension _ _ _ admitted) ih

theorem retainedExtension (first second : Model) (extension : Extension first second) (p : Policy)
    (rows : List Interaction) (held : rows ∈ retained first p) : rows ∈ retained second p := by
  have h := (retainedMeaning _ _ _).mp held
  apply (retainedMeaning _ _ _).mpr
  refine ⟨extension.trajectories _ h.1,?_⟩
  rw [← extension.initial]
  exact traceExtension _ _ extension _ _ _ h.2
def finalState (state : String) : List Interaction → String
 | [] => state
 | row :: rest => finalState row.2.2.1 rest

theorem traceComposition (m : Model) (p : Policy) (state : String) (first second : List Interaction)
    (left : Trace m p state first) (right : Trace m p (finalState state first) second) :
    Trace m p state (first ++ second) := by
  induction left with
  | base state held => exact right
  | next state row rest admitted tail ih => exact .next _ _ _ admitted (ih right)

theorem labelComposition (first second : List Interaction) : labels (first ++ second) = labels first ++ labels second := by
  induction first with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.2.2.2) ih

theorem disjoint (m : Model) (p : Policy) (trace : List Interaction) (held : trace ∈ retained m p) :
    trace ∉ rejected m p := by
  intro bad
  have yes := ((filterMemberIff _ _ _).mp held).2
  have no := (notTrue _).mp ((filterMemberIff _ _ _).mp bad).2
  rw [yes] at no; cases no
end SFT.Computation.Reinforcement
