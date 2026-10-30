import SFT.Computation.SecurityPartition
import SFT.Computation.StateTransition
namespace SFT.Computation.ZeroKnowledge
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure RealRow where
  statement : String
  witness : String
  transcript : String
  deriving DecidableEq
structure SimRow where
  statement : String
  initial : String
  actions : List String
  trace : List String
  transcript : String
  deriving DecidableEq
structure Model where
  statements : List String
  witnesses : List (String × String)
  real : List RealRow
  simulator : StateTransition.System
  simulated : List SimRow
  observations : List (String × String)
  accepted : List String

def supported (m : Model) (r : RealRow) : Bool :=
  has m.statements r.statement && has m.witnesses (r.statement,r.witness)
def realRows (m : Model) : List RealRow := m.real.filter (supported m)
def views (m : Model) (transcript : String) : List String :=
  (m.observations.filter (fun row => decide (row.1 = transcript))).map Prod.snd

theorem viewMeaning (m : Model) (transcript view : String) : view ∈ views m transcript ↔
    (transcript,view) ∈ m.observations := by
  constructor
  · intro h
    obtain ⟨row,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ h
    have p := (filterMemberIff _ _ _).mp held
    have first := of_decide_eq_true p.2
    cases row with
    | mk a b => dsimp at first same; cases first; cases same; exact p.1
  · intro h
    exact SFT.Foundation.Count.TraceDerivation.memMap _ (transcript,view) _
      ((filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩)

def observationMatch (m : Model) (r : RealRow) (s : SimRow) : Bool :=
  decide (r.statement = s.statement) &&
  (views m r.transcript).all (fun v => has (views m s.transcript) v) &&
  (views m s.transcript).all (fun v => has (views m r.transcript) v)

theorem matchMeaning (m : Model) (r : RealRow) (s : SimRow) : observationMatch m r s = true ↔
    r.statement = s.statement ∧ ∀ v, (r.transcript,v) ∈ m.observations ↔ (s.transcript,v) ∈ m.observations := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; have q := (andTrue _ _).mp p.1
    refine ⟨of_decide_eq_true q.1,fun v => ⟨?_,?_⟩⟩
    · intro held; exact (viewMeaning _ _ _).mp ((hasIff _ _).mp (allTrueAtMember _ _ q.2 v ((viewMeaning _ _ _).mpr held)))
    · intro held; exact (viewMeaning _ _ _).mp ((hasIff _ _).mp (allTrueAtMember _ _ p.2 v ((viewMeaning _ _ _).mpr held)))
  · intro h; apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨decide_eq_true h.1,?_⟩,?_⟩
    · exact (allTrueIffMembers _ _).mpr (fun v held => (hasIff _ _).mpr ((viewMeaning _ _ _).mpr ((h.2 v).mp ((viewMeaning _ _ _).mp held))))
    · exact (allTrueIffMembers _ _).mpr (fun v held => (hasIff _ _).mpr ((viewMeaning _ _ _).mpr ((h.2 v).mpr ((viewMeaning _ _ _).mp held))))

def simulations (m : Model) (r : RealRow) : List SimRow := m.simulated.filter (observationMatch m r)

theorem simulationMeaning (m : Model) (r : RealRow) (s : SimRow) : s ∈ simulations m r ↔
    s ∈ m.simulated ∧ r.statement = s.statement ∧
      ∀ v, (r.transcript,v) ∈ m.observations ↔ (s.transcript,v) ∈ m.observations := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(matchMeaning _ _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(matchMeaning _ _ _).mpr h.2⟩

def correct (m : Model) : Bool := (realRows m).all (fun r => has m.accepted r.transcript)
theorem exactCorrectness (m : Model) : correct m = true ↔
    ∀ r, r ∈ realRows m → r.transcript ∈ m.accepted := by
  constructor
  · intro h r held; exact (hasIff _ _).mp (allTrueAtMember _ _ h r held)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun r held => (hasIff _ _).mpr (h r held))

structure SimulationTrace (m : Model) where
  row : SimRow
  held : row ∈ m.simulated
  statementHeld : row.statement ∈ m.statements
  execution : StateTransition.run m.simulator row.initial row.actions = .ok row.trace
  terminal : row.trace.getLast? = some row.transcript

theorem simulatorExecution (m : Model) (s : SimulationTrace m) :
    StateTransition.Execution m.simulator s.row.initial s.row.actions s.row.trace :=
  (StateTransition.runFromMeaning _ _ _ _).mp ((StateTransition.runAdmission _ _ _ _).mp s.execution).2

def closed (m : Model) (a b : RealRow) : Prop :=
  a ∈ realRows m ∧ b ∈ realRows m ∧ a.statement = b.statement ∧ a.witness ≠ b.witness ∧
  ∀ v, (a.transcript,v) ∈ m.observations ↔ (b.transcript,v) ∈ m.observations

theorem commonSimulation (m : Model) (a b : RealRow) (s : SimRow)
    (ha : a ∈ realRows m) (hb : b ∈ realRows m) (different : a.witness ≠ b.witness)
    (ma : observationMatch m a s = true) (mb : observationMatch m b s = true) : closed m a b := by
  have p := (matchMeaning _ _ _).mp ma; have q := (matchMeaning _ _ _).mp mb
  exact ⟨ha,hb,p.1.trans q.1.symm,different,fun v => ⟨fun h => (q.2 v).mpr ((p.2 v).mp h),fun h => (p.2 v).mpr ((q.2 v).mp h)⟩⟩

theorem noViewRecovery (m : Model) (a b : RealRow) (h : closed m a b) (v : String)
    (observed : (a.transcript,v) ∈ m.observations) :
    (b.transcript,v) ∈ m.observations ∧ ¬ ∃ decode : String → String, decode v = a.witness ∧ decode v = b.witness := by
  refine ⟨(h.2.2.2.2 v).mp observed,?_⟩
  intro ⟨decode,left,right⟩; exact h.2.2.2.1 (left.symm.trans right)

def simulatable (m : Model) (r : RealRow) : Bool := !(simulations m r).isEmpty

theorem exactSimulation (m : Model) (r : RealRow) : simulatable m r = true ↔
    ∃ s, s ∈ m.simulated ∧ observationMatch m r s = true := by
  constructor
  · intro h
    cases rows : simulations m r with
    | nil => unfold simulatable at h; rw [rows] at h; cases h
    | cons s ss =>
      have held : s ∈ simulations m r := by rw [rows]; exact .head _
      exact ⟨s,(filterMemberIff _ _ _).mp held⟩
  · intro ⟨s,held,matching⟩
    have row : s ∈ simulations m r := (filterMemberIff _ _ _).mpr ⟨held,matching⟩
    cases rows : simulations m r with
    | nil => rw [rows] at row; cases row
    | cons x xs => unfold simulatable; rw [rows]; rfl

def simulationCovered (m : Model) : Bool := (realRows m).all (simulatable m)
theorem exactCoverage (m : Model) : simulationCovered m = true ↔
    ∀ r, r ∈ realRows m → ∃ s, s ∈ m.simulated ∧ observationMatch m r s = true := by
  constructor
  · intro h r held; exact (exactSimulation _ _).mp (allTrueAtMember _ _ h r held)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun r held => (exactSimulation _ _).mpr (h r held))

def failures (m : Model) : List RealRow := (realRows m).filter (fun r => !simulatable m r)
theorem failureMeaning (m : Model) (r : RealRow) : r ∈ failures m ↔
    r ∈ realRows m ∧ simulatable m r = false := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(notTrue _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(notTrue _).mpr h.2⟩

theorem realMeaning (m : Model) (r : RealRow) : r ∈ realRows m ↔
    r ∈ m.real ∧ r.statement ∈ m.statements ∧ (r.statement,r.witness) ∈ m.witnesses := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    exact ⟨p.1,(hasIff _ _).mp q.1,(hasIff _ _).mp q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.2.1,(hasIff _ _).mpr h.2.2⟩⟩

structure Extension (first second : Model) : Prop where
  statements : ∀ x, x ∈ first.statements → x ∈ second.statements
  witnesses : ∀ x, x ∈ first.witnesses → x ∈ second.witnesses
  real : ∀ x, x ∈ first.real → x ∈ second.real
  simulated : ∀ x, x ∈ first.simulated → x ∈ second.simulated
  accepted : ∀ x, x ∈ first.accepted → x ∈ second.accepted
  observations : ∀ t v, (t,v) ∈ first.observations ↔ (t,v) ∈ second.observations
  runs : ∀ initial actions trace, StateTransition.run first.simulator initial actions = .ok trace → StateTransition.run second.simulator initial actions = .ok trace

theorem realExtension (first second : Model) (inc : Extension first second) (r : RealRow)
    (held : r ∈ realRows first) : r ∈ realRows second := by
  have p := (realMeaning _ _).mp held
  exact (realMeaning _ _).mpr ⟨inc.real _ p.1,inc.statements _ p.2.1,inc.witnesses _ p.2.2⟩

theorem matchExtension (first second : Model) (inc : Extension first second) (r : RealRow) (s : SimRow)
    (held : observationMatch first r s = true) : observationMatch second r s = true := by
  have p := (matchMeaning _ _ _).mp held
  exact (matchMeaning _ _ _).mpr ⟨p.1,fun v => ⟨fun h => (inc.observations _ _).mp ((p.2 v).mp ((inc.observations _ _).mpr h)),
    fun h => (inc.observations _ _).mp ((p.2 v).mpr ((inc.observations _ _).mpr h))⟩⟩

def extendSimulation (first second : Model) (inc : Extension first second) (s : SimulationTrace first) : SimulationTrace second :=
  ⟨s.row,inc.simulated _ s.held,inc.statements _ s.statementHeld,inc.runs _ _ _ s.execution,s.terminal⟩

def pairs (m : Model) : List (RealRow × RealRow) :=
  (realRows m).flatMap (fun a => (realRows m).map (fun b => (a,b)))

theorem pairMeaning (m : Model) (a b : RealRow) : (a,b) ∈ pairs m ↔ a ∈ realRows m ∧ b ∈ realRows m := by
  constructor
  · intro h
    obtain ⟨x,hx,hy⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ h
    obtain ⟨y,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ hy
    cases same; exact ⟨hx,held⟩
  · intro h
    exact SFT.Foundation.CommonRefinement.memFlatMap _ _ a (a,b) h.1
      (SFT.Foundation.Count.TraceDerivation.memMap _ b _ h.2)

def sameViews (m : Model) (a b : RealRow) : Bool :=
  (views m a.transcript).all (fun v => has (views m b.transcript) v) &&
  (views m b.transcript).all (fun v => has (views m a.transcript) v)

def closedLedger (m : Model) : List (RealRow × RealRow) :=
  (pairs m).filter (fun p => decide (p.1.statement = p.2.statement) && decide (p.1.witness ≠ p.2.witness) && sameViews m p.1 p.2)

def retainedLedger (m : Model) : List (RealRow × RealRow) :=
  (pairs m).filter (fun p => decide (p.1.statement = p.2.statement) && decide (p.1.witness ≠ p.2.witness) && !sameViews m p.1 p.2)

theorem sameViewsMeaning (m : Model) (a b : RealRow) : sameViews m a b = true ↔
    ∀ v, (a.transcript,v) ∈ m.observations ↔ (b.transcript,v) ∈ m.observations := by
  constructor
  · intro h; have p := (andTrue _ _).mp h
    intro v; constructor
    · intro hv; exact (viewMeaning _ _ _).mp ((hasIff _ _).mp (allTrueAtMember _ _ p.1 v ((viewMeaning _ _ _).mpr hv)))
    · intro hv; exact (viewMeaning _ _ _).mp ((hasIff _ _).mp (allTrueAtMember _ _ p.2 v ((viewMeaning _ _ _).mpr hv)))
  · intro h; exact (andTrue _ _).mpr ⟨
      (allTrueIffMembers _ _).mpr (fun v hv => (hasIff _ _).mpr ((viewMeaning _ _ _).mpr ((h v).mp ((viewMeaning _ _ _).mp hv)))),
      (allTrueIffMembers _ _).mpr (fun v hv => (hasIff _ _).mpr ((viewMeaning _ _ _).mpr ((h v).mpr ((viewMeaning _ _ _).mp hv))))⟩

theorem closedLedgerMeaning (m : Model) (a b : RealRow) : (a,b) ∈ closedLedger m ↔ closed m a b := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2; have z := (andTrue _ _).mp q.1
    have held := (pairMeaning _ _ _).mp p.1
    exact ⟨held.1,held.2,of_decide_eq_true z.1,of_decide_eq_true z.2,(sameViewsMeaning _ _ _).mp q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨(pairMeaning _ _ _).mpr ⟨h.1,h.2.1⟩,
      (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨decide_eq_true h.2.2.1,decide_eq_true h.2.2.2.1⟩,(sameViewsMeaning _ _ _).mpr h.2.2.2.2⟩⟩

theorem retainedLedgerMeaning (m : Model) (a b : RealRow) : (a,b) ∈ retainedLedger m ↔
    a ∈ realRows m ∧ b ∈ realRows m ∧ a.statement = b.statement ∧ a.witness ≠ b.witness ∧ sameViews m a b = false := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2; have z := (andTrue _ _).mp q.1
    have held := (pairMeaning _ _ _).mp p.1
    exact ⟨held.1,held.2,of_decide_eq_true z.1,of_decide_eq_true z.2,(notTrue _).mp q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨(pairMeaning _ _ _).mpr ⟨h.1,h.2.1⟩,
      (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨decide_eq_true h.2.2.1,decide_eq_true h.2.2.2.1⟩,(notTrue _).mpr h.2.2.2.2⟩⟩

theorem distinctionDisjoint (m : Model) (a b : RealRow) (h : (a,b) ∈ closedLedger m) : (a,b) ∉ retainedLedger m := by
  intro bad
  have yes := (sameViewsMeaning _ _ _).mpr ((closedLedgerMeaning _ _ _).mp h).2.2.2.2
  have no := ((retainedLedgerMeaning _ _ _).mp bad).2.2.2.2
  rw [yes] at no; cases no

theorem distinctionExhaustion (m : Model) (a b : RealRow) (ha : a ∈ realRows m) (hb : b ∈ realRows m)
    (statement : a.statement = b.statement) (different : a.witness ≠ b.witness) :
    (a,b) ∈ closedLedger m ∨ (a,b) ∈ retainedLedger m := by
  cases h : sameViews m a b with
  | false => exact .inr ((retainedLedgerMeaning _ _ _).mpr ⟨ha,hb,statement,different,h⟩)
  | true => exact .inl ((closedLedgerMeaning _ _ _).mpr ⟨ha,hb,statement,different,(sameViewsMeaning _ _ _).mp h⟩)

end SFT.Computation.ZeroKnowledge
