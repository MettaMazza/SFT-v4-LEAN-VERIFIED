import SFT.Computation.SecurityPartition
namespace SFT.Computation.Integrity
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

structure Record where
  identity : String
  content : String
  deriving DecidableEq

structure Change where
  identity : String
  before : Record
  after : Record
  deriving DecidableEq

structure Model where
  records : List Record
  allowed : List Change
  changes : List Change
  verification : List (Record × Record)

def supported (m : Model) (c : Change) : Bool := has m.changes c && has m.records c.before
def verifies (m : Model) (c : Change) : Bool := has m.verification (c.before,c.after)
def accepts (m : Model) (c : Change) : Bool := supported m c && verifies m c

def accepted (m : Model) : List Change := m.changes.filter (accepts m)
def rejected (m : Model) : List Change := m.changes.filter (fun c => supported m c && !verifies m c)
def falseAccepts (m : Model) : List Change := (accepted m).filter (fun c => !has m.allowed c)

theorem supportedMeaning (m : Model) (c : Change) : supported m c = true ↔
    c ∈ m.changes ∧ c.before ∈ m.records := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; exact ⟨(hasIff _ _).mp p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,(hasIff _ _).mpr h.2⟩

theorem acceptanceMeaning (m : Model) (c : Change) : accepts m c = true ↔
    c ∈ m.changes ∧ c.before ∈ m.records ∧ (c.before,c.after) ∈ m.verification := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; have q := (supportedMeaning _ _).mp p.1
    exact ⟨q.1,q.2,(hasIff _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(supportedMeaning _ _).mpr ⟨h.1,h.2.1⟩,(hasIff _ _).mpr h.2.2⟩

theorem acceptedMeaning (m : Model) (c : Change) : c ∈ accepted m ↔ accepts m c = true := by
  constructor
  · intro h; exact ((filterMemberIff _ _ _).mp h).2
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨((acceptanceMeaning _ _).mp h).1,h⟩

def integrity (m : Model) : Bool := (accepted m).all (has m.allowed)

theorem exactIntegrity (m : Model) : integrity m = true ↔
    ∀ c, accepts m c = true → c ∈ m.allowed := by
  constructor
  · intro h c hc; exact (hasIff _ _).mp (allTrueAtMember _ _ h c ((acceptedMeaning _ _).mpr hc))
  · intro h; exact (allTrueIffMembers _ _).mpr (fun c hc => (hasIff _ _).mpr (h c ((acceptedMeaning _ _).mp hc)))

theorem rejectsUnauthorized (m : Model) (verified : integrity m = true) (c : Change) (unauthorized : c ∉ m.allowed) :
    accepts m c ≠ true := fun h => unauthorized ((exactIntegrity _).mp verified c h)

theorem failedIntegrityWitness (m : Model) (c : Change) (accepted : accepts m c = true) (unauthorized : c ∉ m.allowed) :
    integrity m ≠ true := fun h => rejectsUnauthorized m h c unauthorized accepted

inductive Trace (m : Model) : Record → List Change → Record → Prop where
  | identity (r) : Trace m r [] r
  | next (a b c) (row : Change) (rows : List Change) :
      row.before = a → row.after = b → accepts m row = true → Trace m b rows c → Trace m a (row::rows) c

theorem traceProvenance (m : Model) (a b : Record) (rows : List Change) (h : Trace m a rows b) :
    ∀ c, c ∈ rows → accepts m c = true := by
  induction h with
  | identity => intro c h; cases h
  | next a b c row rows before after accept rest ih =>
    intro x held; cases held with
    | head => exact accept
    | tail _ held => exact ih x held

theorem traceAuthorized (m : Model) (verified : integrity m = true) (a b : Record) (rows : List Change)
    (h : Trace m a rows b) : ∀ c, c ∈ rows → c ∈ m.allowed :=
  fun c hc => (exactIntegrity m).mp verified c (traceProvenance _ _ _ _ h c hc)

theorem serial (m : Model) (a b c : Record) (xs ys : List Change)
    (first : Trace m a xs b) (second : Trace m b ys c) : Trace m a (xs++ys) c := by
  induction first with
  | identity => exact second
  | next a b c row rows before after accept rest ih => exact .next _ _ _ _ _ before after accept (ih second)

theorem rejectedMeaning (m : Model) (c : Change) : c ∈ rejected m ↔ supported m c = true ∧ verifies m c = false := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    have q := (andTrue _ _).mp p.2
    exact ⟨q.1,(notTrue _).mp q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr
      ⟨((supportedMeaning _ _).mp h.1).1,(andTrue _ _).mpr ⟨h.1,(notTrue _).mpr h.2⟩⟩

theorem falseAcceptanceMeaning (m : Model) (c : Change) : c ∈ falseAccepts m ↔
    accepts m c = true ∧ c ∉ m.allowed := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    refine ⟨(acceptedMeaning _ _).mp p.1,?_⟩
    intro held
    have yes := (hasIff _ _).mpr held
    rw [yes] at p; cases p.2
  · intro h
    have absent : has m.allowed c = false := by
      cases test : has m.allowed c with
      | false => rfl
      | true => exact False.elim (h.2 ((hasIff _ _).mp test))
    exact (filterMemberIff _ _ _).mpr ⟨(acceptedMeaning _ _).mpr h.1,(notTrue _).mpr absent⟩

theorem verdictExhaustion (m : Model) (c : Change) (held : supported m c = true) :
    c ∈ accepted m ∨ c ∈ rejected m := by
  cases test : verifies m c with
  | false => exact .inr ((rejectedMeaning _ _).mpr ⟨held,test⟩)
  | true => exact .inl ((acceptedMeaning _ _).mpr ((andTrue _ _).mpr ⟨held,test⟩))

theorem verdictDisjoint (m : Model) (c : Change) (accepted : c ∈ accepted m) : c ∉ rejected m := by
  intro rejected
  have yes := ((andTrue _ _).mp ((acceptedMeaning _ _).mp accepted)).2
  have no := ((rejectedMeaning _ _).mp rejected).2
  cases no.symm.trans yes

structure Extension (first second : Model) : Prop where
  records : ∀ r, r ∈ first.records → r ∈ second.records
  changes : ∀ c, c ∈ first.changes → c ∈ second.changes
  allowed : ∀ c, c ∈ first.allowed → c ∈ second.allowed
  verification : ∀ pair, pair ∈ first.verification → pair ∈ second.verification

theorem acceptanceExtension (first second : Model) (inc : Extension first second) (c : Change)
    (h : accepts first c = true) : accepts second c = true := by
  have p := (acceptanceMeaning _ _).mp h
  exact (acceptanceMeaning _ _).mpr ⟨inc.changes c p.1,inc.records _ p.2.1,inc.verification _ p.2.2⟩

theorem traceExtension (first second : Model) (inc : Extension first second)
    (a b : Record) (rows : List Change) (h : Trace first a rows b) : Trace second a rows b := by
  induction h with
  | identity => exact .identity _
  | next a b c row rows before after accept rest ih =>
    exact .next _ _ _ _ _ before after (acceptanceExtension _ _ inc row accept) ih

end SFT.Computation.Integrity
