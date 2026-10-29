import SFT.Computation.Replication
namespace SFT.Computation.FaultModel
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

structure Transition where
  component : String
  label : String
  before : String
  after : String
  deriving DecidableEq

structure Fault where
  identity : String
  action : Transition
  observation : String
  deriving DecidableEq

structure Model where
  nominal : List (Transition × String)
  generated : List Fault
  recovery : List Transition

def deviation (m : Model) (f : Fault) : Bool :=
  has m.generated f && !has (m.nominal.map Prod.fst) f.action

def detected (m : Model) (f : Fault) : Bool := !has (m.nominal.map Prod.snd) f.observation

def matching (f : Fault) (r : Transition) : Bool :=
  decide (r.component = f.action.component ∧ r.before = f.action.after)

def recoveryRows (m : Model) (f : Fault) : List Transition := m.recovery.filter (matching f)

inductive Result where
  | outside
  | uncorrectable
  | recoverable (rows : List Transition)
  deriving DecidableEq

def classify (m : Model) (f : Fault) : Result :=
  if has m.generated f then
    match recoveryRows m f with
    | [] => .uncorrectable
    | row :: rest => .recoverable (row :: rest)
  else .outside

theorem deviationMeaning (m : Model) (f : Fault) : deviation m f = true ↔
    f ∈ m.generated ∧ f.action ∉ m.nominal.map Prod.fst := by
  constructor
  · intro h; have p := (andTrue _ _).mp h
    refine ⟨(hasIff _ _).mp p.1,?_⟩
    intro held; have yes := (hasIff _ _).mpr held; rw [yes] at p; cases p.2
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(hasIff _ _).mpr h.1,?_⟩
    cases test : has (m.nominal.map Prod.fst) f.action with
    | false => rfl
    | true => exact False.elim (h.2 ((hasIff _ _).mp test))

theorem detectionMeaning (m : Model) (f : Fault) : detected m f = true ↔
    f.observation ∉ m.nominal.map Prod.snd := by
  constructor
  · intro h held; have yes := (hasIff _ _).mpr held; unfold detected at h; rw [yes] at h; cases h
  · intro h
    unfold detected
    cases test : has (m.nominal.map Prod.snd) f.observation with
    | false => rfl
    | true => exact False.elim (h ((hasIff _ _).mp test))

theorem indistinguishableNominal (m : Model) (f : Fault) (normal : Transition × String)
    (_held : normal ∈ m.nominal) (same : f.observation = normal.2) (decision : String → Bool) :
    decision f.observation = decision normal.2 := congrArg decision same

theorem matchingMeaning (f : Fault) (r : Transition) : matching f r = true ↔
    r.component = f.action.component ∧ r.before = f.action.after :=
  ⟨of_decide_eq_true,decide_eq_true⟩

theorem recoveryMeaning (m : Model) (f : Fault) (row : Transition) : row ∈ recoveryRows m f ↔
    row ∈ m.recovery ∧ row.component = f.action.component ∧ row.before = f.action.after := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(matchingMeaning _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(matchingMeaning _ _).mpr h.2⟩

theorem outsideMeaning (m : Model) (f : Fault) : classify m f = .outside ↔ f ∉ m.generated := by
  unfold classify
  cases test : has m.generated f with
  | false =>
    constructor
    · intro _ held; have yes := (hasIff _ _).mpr held; rw [test] at yes; cases yes
    · intro _; rfl
  | true =>
    constructor
    · intro h; cases rows : recoveryRows m f <;> rw [rows] at h <;> cases h
    · intro absent; exact False.elim (absent ((hasIff _ _).mp test))

theorem uncorrectableMeaning (m : Model) (f : Fault) : classify m f = .uncorrectable ↔
    f ∈ m.generated ∧ recoveryRows m f = [] := by
  unfold classify
  cases test : has m.generated f with
  | false =>
    constructor
    · intro h; cases h
    · intro h; have yes := (hasIff _ _).mpr h.1; rw [test] at yes; cases yes
  | true =>
    constructor
    · intro h
      cases rows : recoveryRows m f with
      | nil => exact ⟨(hasIff _ _).mp test,rfl⟩
      | cons row rest => rw [rows] at h; cases h
    · intro h; rw [h.2]; rfl

theorem recoverableMeaning (m : Model) (f : Fault) (rows : List Transition) :
    classify m f = .recoverable rows ↔ f ∈ m.generated ∧ rows = recoveryRows m f ∧ rows ≠ [] := by
  unfold classify
  cases test : has m.generated f with
  | false =>
    constructor
    · intro h; cases h
    · intro h; have yes := (hasIff _ _).mpr h.1; rw [test] at yes; cases yes
  | true =>
    cases result : recoveryRows m f with
    | nil =>
      constructor
      · intro h; cases h
      · intro h; exact False.elim (h.2.2 h.2.1)
    | cons row rest =>
      constructor
      · intro h; cases h; exact ⟨(hasIff _ _).mp test,rfl,fun h => nomatch h⟩
      · intro h; rw [h.2.1]; rfl

def correctable (m : Model) (f : Fault) : Bool := m.recovery.any (matching f)
def allGeneratedCorrectable (m : Model) : Bool := m.generated.all (correctable m)

theorem correctableMeaning (m : Model) (f : Fault) : correctable m f = true ↔
    ∃ row, row ∈ m.recovery ∧ row.component = f.action.component ∧ row.before = f.action.after := by
  constructor
  · intro h; obtain ⟨row,held,matched⟩ := (anyTrueIff _ _).mp h
    exact ⟨row,held,(matchingMeaning _ _).mp matched⟩
  · intro ⟨row,held,matched⟩; exact (anyTrueIff _ _).mpr ⟨row,held,(matchingMeaning _ _).mpr matched⟩

theorem exactGuarantee (m : Model) : allGeneratedCorrectable m = true ↔
    ∀ f, f ∈ m.generated → ∃ row, row ∈ recoveryRows m f := by
  constructor
  · intro h f held
    obtain ⟨row,source,matched⟩ := (correctableMeaning _ _).mp (allTrueAtMember _ _ h f held)
    exact ⟨row,(recoveryMeaning _ _ _).mpr ⟨source,matched⟩⟩
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro f held; obtain ⟨row,hr⟩ := h f held
    exact (correctableMeaning _ _).mpr ⟨row,(recoveryMeaning _ _ _).mp hr⟩

inductive RecoveryTrace (m : Model) (component : String) : String → List Transition → String → Prop where
  | identity (state : String) : RecoveryTrace m component state [] state
  | next (row : Transition) (rest : List Transition) (last : String)
      (held : row ∈ m.recovery) (same : row.component = component)
      (tail : RecoveryTrace m component row.after rest last) :
      RecoveryTrace m component row.before (row :: rest) last

theorem recoveryTraceProvenance (m : Model) (component first last : String) (rows : List Transition)
    (trace : RecoveryTrace m component first rows last) (row : Transition) (held : row ∈ rows) :
    row ∈ m.recovery ∧ row.component = component := by
  induction trace with
  | identity => cases held
  | next head rest last source same tail ih =>
    cases held with
    | head => exact ⟨source,same⟩
    | tail _ member => exact ih member

theorem serialRecovery (m : Model) (component a b c : String) (xs ys : List Transition)
    (first : RecoveryTrace m component a xs b) (second : RecoveryTrace m component b ys c) :
    RecoveryTrace m component a (xs ++ ys) c := by
  induction first with
  | identity => exact second
  | next row rest last held same tail ih => exact .next row _ _ held same (ih second)

theorem recoveryRowTrace (m : Model) (f : Fault) (row : Transition) (held : row ∈ recoveryRows m f) :
    RecoveryTrace m f.action.component f.action.after [row] row.after := by
  have h := (recoveryMeaning _ _ _).mp held
  have trace := RecoveryTrace.next row [] row.after h.1 h.2.1 (.identity row.after)
  rw [h.2.2] at trace
  exact trace

def extend (a b : Model) : Model := ⟨a.nominal ++ b.nominal,a.generated ++ b.generated,a.recovery ++ b.recovery⟩

theorem recoveryExtension (a b : Model) (f : Fault) (row : Transition)
    (held : row ∈ recoveryRows a f) : row ∈ recoveryRows (extend a b) f := by
  have h := (recoveryMeaning _ _ _).mp held
  exact (recoveryMeaning _ _ _).mpr ⟨memAppendLeft _ _ _ h.1,h.2⟩

theorem earlierFaultRetained (a b : Model) (f : Fault) (held : f ∈ a.generated) :
    f ∈ (extend a b).generated := memAppendLeft _ _ _ held

theorem composedGuarantee (a b : Model)
    (ha : allGeneratedCorrectable a = true) (hb : allGeneratedCorrectable b = true) :
    allGeneratedCorrectable (extend a b) = true := by
  apply (exactGuarantee _).mpr
  intro f held
  cases memAppendCases _ _ _ held with
  | inl h =>
    obtain ⟨row,hr⟩ := (exactGuarantee _).mp ha f h
    exact ⟨row,recoveryExtension _ _ _ _ hr⟩
  | inr h =>
    obtain ⟨row,hr⟩ := (exactGuarantee _).mp hb f h
    have q := (recoveryMeaning _ _ _).mp hr
    exact ⟨row,(recoveryMeaning _ _ _).mpr ⟨memAppendRight _ _ _ q.1,q.2⟩⟩

end SFT.Computation.FaultModel
