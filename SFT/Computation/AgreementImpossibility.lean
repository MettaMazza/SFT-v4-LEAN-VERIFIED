import SFT.Computation.Consensus
namespace SFT.Computation.AgreementImpossibility
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

-- The two executions and their original observation/scheduler records remain held.
structure Execution where
  predecessor : String
  trace : List String
  observation : List String
  requiredDecision : String
  schedule : List String
  deriving DecidableEq

structure Grammar where
  asynchronousBoundary : String
  faultBoundary : String
  executions : List Execution
  schedulerSupport : List (List String)

def supported (g : Grammar) (e : Execution) : Bool :=
  has g.executions e && has g.schedulerSupport e.schedule

def witness (g : Grammar) (a b : Execution) : Bool :=
  supported g a && supported g b && decide (a.observation = b.observation) &&
  decide (a.predecessor ≠ b.predecessor) && decide (a.requiredDecision ≠ b.requiredDecision)

def pairs (g : Grammar) : List (Execution × Execution) :=
  g.executions.flatMap (fun a => g.executions.map (fun b => (a,b)))

def witnesses (g : Grammar) : List (Execution × Execution) :=
  (pairs g).filter (fun p => witness g p.1 p.2)

theorem supportMeaning (g : Grammar) (e : Execution) : supported g e = true ↔
    e ∈ g.executions ∧ e.schedule ∈ g.schedulerSupport := by
  constructor
  · intro h; have p := (andTrue _ _).mp h
    exact ⟨(hasIff _ _).mp p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,(hasIff _ _).mpr h.2⟩

theorem witnessMeaning (g : Grammar) (a b : Execution) : witness g a b = true ↔
    supported g a = true ∧ supported g b = true ∧ a.observation = b.observation ∧
    a.predecessor ≠ b.predecessor ∧ a.requiredDecision ≠ b.requiredDecision := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    have r := (andTrue _ _).mp q.1
    have s := (andTrue _ _).mp r.1
    exact ⟨s.1,s.2,of_decide_eq_true r.2,of_decide_eq_true q.2,of_decide_eq_true p.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨h.1,h.2.1⟩,decide_eq_true h.2.2.1⟩,
      decide_eq_true h.2.2.2.1⟩,decide_eq_true h.2.2.2.2⟩

theorem pairMeaning (g : Grammar) (a b : Execution) :
    (a,b) ∈ pairs g ↔ a ∈ g.executions ∧ b ∈ g.executions := by
  constructor
  · intro h
    obtain ⟨x,hx,inner⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨y,hy,eq⟩ := memMapPreimage _ _ _ inner
    have first : x = a := congrArg Prod.fst eq
    have second : y = b := congrArg Prod.snd eq
    exact ⟨first ▸ hx,second ▸ hy⟩
  · intro h; exact memFlatMap _ _ a _ h.1 (memMap _ b _ h.2)

theorem enumerationComplete (g : Grammar) (a b : Execution) :
    (a,b) ∈ witnesses g ↔ witness g a b = true := by
  constructor
  · intro h; exact ((filterMemberIff _ _ _).mp h).2
  · intro h
    have p := (witnessMeaning _ _ _).mp h
    exact (filterMemberIff _ _ _).mpr ⟨(pairMeaning _ _ _).mpr
      ⟨((supportMeaning _ _).mp p.1).1,((supportMeaning _ _).mp p.2.1).1⟩,h⟩

def Correct (g : Grammar) (decideFromObservation : List String → String) : Prop :=
  ∀ e, supported g e = true → decideFromObservation e.observation = e.requiredDecision

theorem observationOnlyEquality (a b : Execution) (decision : List String → String)
    (same : a.observation = b.observation) : decision a.observation = decision b.observation :=
  congrArg decision same

theorem contradiction (g : Grammar) (a b : Execution) (held : witness g a b = true)
    (decision : List String → String) : ¬ Correct g decision := by
  intro correct
  have p := (witnessMeaning _ _ _).mp held
  have same := observationOnlyEquality a b decision p.2.2.1
  exact p.2.2.2.2 ((correct a p.1).symm.trans (same.trans (correct b p.2.1)))

theorem noObservationOnlySolver (g : Grammar) (a b : Execution) (held : witness g a b = true) :
    ¬ ∃ decision, Correct g decision := by
  intro ⟨decision,correct⟩
  exact contradiction g a b held decision correct

theorem hiddenPredecessor (g : Grammar) (a b : Execution) (held : witness g a b = true) :
    a.predecessor ≠ b.predecessor ∧ a.observation = b.observation :=
  ⟨((witnessMeaning _ _ _).mp held).2.2.2.1,((witnessMeaning _ _ _).mp held).2.2.1⟩

theorem schedulerBoundary (g : Grammar) (a b : Execution) (held : witness g a b = true) :
    a.schedule ∈ g.schedulerSupport ∧ b.schedule ∈ g.schedulerSupport :=
  ⟨((supportMeaning _ _).mp ((witnessMeaning _ _ _).mp held).1).2,
   ((supportMeaning _ _).mp ((witnessMeaning _ _ _).mp held).2.1).2⟩

theorem unsupportedScheduleRejects (g : Grammar) (a b : Execution)
    (absent : a.schedule ∉ g.schedulerSupport) : witness g a b ≠ true :=
  fun h => absent (schedulerBoundary _ _ _ h).1

-- No claim transfers to another grammar without its own support evidence.
theorem transferWithSupport (g other : Grammar) (a b : Execution)
    (held : witness g a b = true) (ha : supported other a = true) (hb : supported other b = true) :
    witness other a b = true := by
  have h := (witnessMeaning _ _ _).mp held
  exact (witnessMeaning _ _ _).mpr ⟨ha,hb,h.2.2⟩

def extend (g : Grammar) (executions : List Execution) (schedules : List (List String)) : Grammar :=
  {g with executions := g.executions ++ executions, schedulerSupport := g.schedulerSupport ++ schedules}

theorem supportExtension (g : Grammar) (executions : List Execution) (schedules : List (List String))
    (e : Execution) (held : supported g e = true) : supported (extend g executions schedules) e = true := by
  have h := (supportMeaning _ _).mp held
  exact (supportMeaning _ _).mpr ⟨memAppendLeft _ _ _ h.1,memAppendLeft _ _ _ h.2⟩

theorem witnessExtension (g : Grammar) (executions : List Execution) (schedules : List (List String))
    (a b : Execution) (held : witness g a b = true) : witness (extend g executions schedules) a b = true := by
  have h := (witnessMeaning _ _ _).mp held
  exact transferWithSupport _ _ _ _ held (supportExtension _ _ _ _ h.1) (supportExtension _ _ _ _ h.2.1)

def observedSuccessor (e : Execution) (event observation : String) : Execution :=
  {e with trace := e.trace ++ [event], observation := e.observation ++ [observation],schedule := e.schedule ++ [event]}

theorem sameObservationSuccessor (a b : Execution) (event observation : String)
    (same : a.observation = b.observation) :
    (observedSuccessor a event observation).observation = (observedSuccessor b event observation).observation :=
  congrArg (fun xs => xs ++ [observation]) same

theorem successorWitness (g : Grammar) (a b : Execution) (event observation : String)
    (same : a.observation = b.observation) (different : a.predecessor ≠ b.predecessor)
    (decisions : a.requiredDecision ≠ b.requiredDecision)
    (ha : supported g (observedSuccessor a event observation) = true)
    (hb : supported g (observedSuccessor b event observation) = true) :
    witness g (observedSuccessor a event observation) (observedSuccessor b event observation) = true :=
  (witnessMeaning _ _ _).mpr ⟨ha,hb,sameObservationSuccessor _ _ _ _ same,different,decisions⟩

theorem earlierTraceRetained (e : Execution) (event observation prior : String) (held : prior ∈ e.trace) :
    prior ∈ (observedSuccessor e event observation).trace := memAppendLeft _ _ _ held

theorem identityCannotConflict (g : Grammar) (e : Execution) : witness g e e ≠ true :=
  fun h => ((witnessMeaning _ _ _).mp h).2.2.2.2 rfl

end SFT.Computation.AgreementImpossibility
