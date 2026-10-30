import SFT.Computation.SecurityPartition
import SFT.Computation.StateTransition
namespace SFT.Computation.Multiparty
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure Input where
  party : String
  value : String
  deriving DecidableEq
structure Row where
  inputs : List Input
  output : String
  localViews : List (String × String)
  deriving DecidableEq
structure Model where
  parties : List String
  privateInputs : List Input
  jointRelation : List Row
  communication : StateTransition.System
  corruptions : List (List String)

def supported (m : Model) (r : Row) : Bool :=
  r.inputs.all (fun i => has m.parties i.party && has m.privateInputs i) &&
  r.localViews.all (fun v => has m.parties v.1)
def rows (m : Model) : List Row := m.jointRelation.filter (supported m)

theorem rowMeaning (m : Model) (r : Row) : r ∈ rows m ↔
    r ∈ m.jointRelation ∧
    (∀ i, i ∈ r.inputs → i.party ∈ m.parties ∧ i ∈ m.privateInputs) ∧
    (∀ v, v ∈ r.localViews → v.1 ∈ m.parties) := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2
    refine ⟨p.1,?_,?_⟩
    · intro i held; have a := (andTrue _ _).mp (allTrueAtMember _ _ q.1 i held)
      exact ⟨(hasIff _ _).mp a.1,(hasIff _ _).mp a.2⟩
    · intro v held; exact (hasIff _ _).mp (allTrueAtMember _ _ q.2 v held)
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr ⟨
      (allTrueIffMembers _ _).mpr (fun i held => (andTrue _ _).mpr ⟨(hasIff _ _).mpr (h.2.1 i held).1,(hasIff _ _).mpr (h.2.1 i held).2⟩),
      (allTrueIffMembers _ _).mpr (fun v held => (hasIff _ _).mpr (h.2.2 v held))⟩⟩

def corruptedInputs (coalition : List String) (r : Row) : List Input :=
  r.inputs.filter (fun i => has coalition i.party)
def coalitionViews (coalition : List String) (r : Row) : List (String × String) :=
  r.localViews.filter (fun v => has coalition v.1)

theorem corruptionInputMeaning (coalition : List String) (r : Row) (i : Input) : i ∈ corruptedInputs coalition r ↔
    i ∈ r.inputs ∧ i.party ∈ coalition := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

theorem coalitionViewMeaning (coalition : List String) (r : Row) (v : String × String) : v ∈ coalitionViews coalition r ↔
    v ∈ r.localViews ∧ v.1 ∈ coalition := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

def pairs (m : Model) : List (Row × Row) := (rows m).flatMap (fun a => (rows m).map (fun b => (a,b)))
theorem pairMeaning (m : Model) (a b : Row) : (a,b) ∈ pairs m ↔ a ∈ rows m ∧ b ∈ rows m := by
  constructor
  · intro h
    obtain ⟨x,hx,hy⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ h
    obtain ⟨y,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ hy
    cases same; exact ⟨hx,held⟩
  · intro h; exact SFT.Foundation.CommonRefinement.memFlatMap _ _ a (a,b) h.1
      (SFT.Foundation.Count.TraceDerivation.memMap _ b _ h.2)

def samePublic (coalition : List String) (a b : Row) : Bool :=
  decide (a.output = b.output) && decide (corruptedInputs coalition a = corruptedInputs coalition b)
def leaks (coalition : List String) (a b : Row) : Bool :=
  samePublic coalition a b && decide (coalitionViews coalition a ≠ coalitionViews coalition b)
def leakageLedger (m : Model) (coalition : List String) : List (Row × Row) :=
  (pairs m).filter (fun p => leaks coalition p.1 p.2)

theorem leakageMeaning (m : Model) (coalition : List String) (a b : Row) : (a,b) ∈ leakageLedger m coalition ↔
    a ∈ rows m ∧ b ∈ rows m ∧ a.output = b.output ∧
    corruptedInputs coalition a = corruptedInputs coalition b ∧ coalitionViews coalition a ≠ coalitionViews coalition b := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; have q := (andTrue _ _).mp p.2; have z := (andTrue _ _).mp q.1
    have held := (pairMeaning _ _ _).mp p.1
    exact ⟨held.1,held.2,of_decide_eq_true z.1,of_decide_eq_true z.2,of_decide_eq_true q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨(pairMeaning _ _ _).mpr ⟨h.1,h.2.1⟩,
      (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨decide_eq_true h.2.2.1,decide_eq_true h.2.2.2.1⟩,decide_eq_true h.2.2.2.2⟩⟩

structure Execution (m : Model) where
  row : Row
  source : row ∈ rows m
  coalition : List String
  boundary : coalition ∈ m.corruptions
  initial : String
  actions : List String
  trace : List String
  communicationRun : StateTransition.run m.communication initial actions = .ok trace

theorem executionTrace (m : Model) (e : Execution m) :
    StateTransition.Execution m.communication e.initial e.actions e.trace :=
  (StateTransition.runFromMeaning _ _ _ _).mp ((StateTransition.runAdmission _ _ _ _).mp e.communicationRun).2

theorem excludedCorruption (m : Model) (coalition : List String) (absent : coalition ∉ m.corruptions) :
    ¬ ∃ e : Execution m, e.coalition = coalition := by
  intro ⟨e,same⟩; exact absent (same ▸ e.boundary)

def privateFor (m : Model) (coalition : List String) : Bool :=
  (pairs m).all (fun p => if samePublic coalition p.1 p.2 then decide (coalitionViews coalition p.1 = coalitionViews coalition p.2) else true)

theorem exactPrivacy (m : Model) (coalition : List String) : privateFor m coalition = true ↔
    ∀ a b, a ∈ rows m → b ∈ rows m → a.output = b.output →
    corruptedInputs coalition a = corruptedInputs coalition b → coalitionViews coalition a = coalitionViews coalition b := by
  constructor
  · intro h a b ha hb output inputs
    have checked := allTrueAtMember _ _ h (a,b) ((pairMeaning _ _ _).mpr ⟨ha,hb⟩)
    have same : samePublic coalition a b = true := (andTrue _ _).mpr ⟨decide_eq_true output,decide_eq_true inputs⟩
    rw [same] at checked; exact of_decide_eq_true checked
  · intro h; apply (allTrueIffMembers _ _).mpr
    intro p held; have rowsHeld := (pairMeaning _ _ _).mp held
    cases same : samePublic coalition p.1 p.2 with
    | false => rfl
    | true =>
      have q := (andTrue _ _).mp same
      exact decide_eq_true (h _ _ rowsHeld.1 rowsHeld.2 (of_decide_eq_true q.1) (of_decide_eq_true q.2))

theorem noLeakage (m : Model) (coalition : List String) (checked : privateFor m coalition = true) (a b : Row) :
    (a,b) ∉ leakageLedger m coalition := by
  intro bad; have p := (leakageMeaning _ _ _ _).mp bad
  exact p.2.2.2.2 ((exactPrivacy _ _).mp checked a b p.1 p.2.1 p.2.2.1 p.2.2.2.1)

def secure (m : Model) : Bool := m.corruptions.all (privateFor m)
theorem exactSecurity (m : Model) : secure m = true ↔ ∀ coalition, coalition ∈ m.corruptions → privateFor m coalition = true :=
  allTrueIffMembers _ _

theorem registeredPrivacy (m : Model) (checked : secure m = true) (e : Execution m) : privateFor m e.coalition = true :=
  (exactSecurity _).mp checked _ e.boundary

structure Extension (first second : Model) : Prop where
  parties : ∀ x, x ∈ first.parties → x ∈ second.parties
  privateInputs : ∀ x, x ∈ first.privateInputs → x ∈ second.privateInputs
  jointRelation : ∀ x, x ∈ first.jointRelation → x ∈ second.jointRelation
  corruptions : ∀ x, x ∈ first.corruptions → x ∈ second.corruptions
  runs : ∀ initial actions trace, StateTransition.run first.communication initial actions = .ok trace → StateTransition.run second.communication initial actions = .ok trace

theorem rowExtension (first second : Model) (inc : Extension first second) (r : Row) (held : r ∈ rows first) : r ∈ rows second := by
  have p := (rowMeaning _ _).mp held
  exact (rowMeaning _ _).mpr ⟨inc.jointRelation _ p.1,fun i hi => ⟨inc.parties _ (p.2.1 i hi).1,inc.privateInputs _ (p.2.1 i hi).2⟩,
    fun v hv => inc.parties _ (p.2.2 v hv)⟩

def extendExecution (first second : Model) (inc : Extension first second) (e : Execution first) : Execution second :=
  ⟨e.row,rowExtension _ _ inc _ e.source,e.coalition,inc.corruptions _ e.boundary,e.initial,e.actions,e.trace,inc.runs _ _ _ e.communicationRun⟩

theorem leakageExtension (first second : Model) (inc : Extension first second) (coalition : List String) (a b : Row)
    (h : (a,b) ∈ leakageLedger first coalition) : (a,b) ∈ leakageLedger second coalition := by
  have p := (leakageMeaning _ _ _ _).mp h
  exact (leakageMeaning _ _ _ _).mpr ⟨rowExtension _ _ inc _ p.1,rowExtension _ _ inc _ p.2.1,p.2.2⟩

end SFT.Computation.Multiparty
