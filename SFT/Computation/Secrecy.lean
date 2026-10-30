import SFT.Computation.SecurityPartition
namespace SFT.Computation.Secrecy
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

structure Row where
  message : String
  key : String
  ciphertext : String
  deriving DecidableEq

structure Model where
  messages : List String
  keys : List String
  transformations : List Row
  observation : Observation

def admitted (m : Model) (r : Row) : Prop :=
  r ∈ m.transformations ∧ r.message ∈ m.messages ∧ r.key ∈ m.keys ∧
  ∃ view, image m.observation r.ciphertext = some view

def possibleMessages (m : Model) (view : String) : List String :=
  (m.transformations.filter (fun r => has m.messages r.message && has m.keys r.key &&
    belongs m.observation view r.ciphertext)).map Row.message

theorem possibleMeaning (m : Model) (view message : String) : message ∈ possibleMessages m view ↔
    ∃ r, r ∈ m.transformations ∧ r.message = message ∧ r.message ∈ m.messages ∧ r.key ∈ m.keys ∧
      image m.observation r.ciphertext = some view := by
  constructor
  · intro h
    obtain ⟨r,held,eq⟩ := memMapPreimage _ _ _ h
    have p := (filterMemberIff _ _ _).mp held
    have a := (andTrue _ _).mp p.2
    have b := (andTrue _ _).mp a.1
    exact ⟨r,p.1,eq,(hasIff _ _).mp b.1,(hasIff _ _).mp b.2,(belongsMeaning _ _ _).mp a.2⟩
  · intro ⟨r,held,eq,hm,hk,obs⟩
    have row := memMap Row.message r _ ((filterMemberIff (fun r : Row => has m.messages r.message && has m.keys r.key && belongs m.observation view r.ciphertext) m.transformations r).mpr
      ⟨held,(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr hm,(hasIff _ _).mpr hk⟩,(belongsMeaning _ _ _).mpr obs⟩⟩)
    exact eq ▸ row

def closed (m : Model) (a b : Row) : Prop :=
  admitted m a ∧ admitted m b ∧ a.message ≠ b.message ∧
  image m.observation a.ciphertext = image m.observation b.ciphertext

theorem noObservationRecovery (m : Model) (a b : Row) (h : closed m a b) :
    ¬ ∃ decode : Option String → String,
      decode (image m.observation a.ciphertext) = a.message ∧
      decode (image m.observation b.ciphertext) = b.message := by
  intro ⟨decode,left,right⟩
  exact h.2.2.1 (left.symm.trans ((congrArg decode h.2.2.2).trans right))

theorem ambiguityWitness (m : Model) (a b : Row) (h : closed m a b) :
    ∃ view, a.message ∈ possibleMessages m view ∧ b.message ∈ possibleMessages m view ∧ a.message ≠ b.message := by
  obtain ⟨view,obs⟩ := h.1.2.2.2
  exact ⟨view,(possibleMeaning _ _ _).mpr ⟨a,h.1.1,rfl,h.1.2.1,h.1.2.2.1,obs⟩,
    (possibleMeaning _ _ _).mpr ⟨b,h.2.1.1,rfl,h.2.1.2.1,h.2.1.2.2.1,h.2.2.2.symm.trans obs⟩,h.2.2.1⟩

theorem missingTransformation (m : Model) (r : Row) (absent : r ∉ m.transformations) : ¬ admitted m r := fun h => absent h.1

theorem missingKey (m : Model) (r : Row) (absent : r.key ∉ m.keys) : ¬ admitted m r := fun h => absent h.2.2.1

def separated (m : Model) (a b : Row) : Prop :=
  admitted m a ∧ admitted m b ∧ a.message ≠ b.message ∧
  image m.observation a.ciphertext ≠ image m.observation b.ciphertext

theorem distinctionExhaustion (m : Model) (a b : Row) (ha : admitted m a) (hb : admitted m b)
    (different : a.message ≠ b.message) : closed m a b ∨ separated m a b := by
  cases decEq (image m.observation a.ciphertext) (image m.observation b.ciphertext) with
  | isTrue same => exact .inl ⟨ha,hb,different,same⟩
  | isFalse distinct => exact .inr ⟨ha,hb,different,distinct⟩

theorem distinctionDisjoint (m : Model) (a b : Row) (hidden : closed m a b) : ¬ separated m a b :=
  fun h => h.2.2.2 hidden.2.2.2

structure Extension (first second : Model) : Prop where
  messages : ∀ x, x ∈ first.messages → x ∈ second.messages
  keys : ∀ x, x ∈ first.keys → x ∈ second.keys
  transformations : ∀ r, r ∈ first.transformations → r ∈ second.transformations
  observation : ∀ r, r ∈ first.transformations → image second.observation r.ciphertext = image first.observation r.ciphertext

theorem admissionExtension (first second : Model) (inc : Extension first second) (r : Row)
    (h : admitted first r) : admitted second r := by
  obtain ⟨view,obs⟩ := h.2.2.2
  exact ⟨inc.transformations r h.1,inc.messages _ h.2.1,inc.keys _ h.2.2.1,
    ⟨view,(inc.observation r h.1).trans obs⟩⟩

theorem closedExtension (first second : Model) (inc : Extension first second) (a b : Row)
    (h : closed first a b) : closed second a b :=
  ⟨admissionExtension _ _ inc a h.1,admissionExtension _ _ inc b h.2.1,h.2.2.1,
    (inc.observation a h.1.1).trans (h.2.2.2.trans (inc.observation b h.2.1.1).symm)⟩

theorem possibleExtension (first second : Model) (inc : Extension first second) (view message : String)
    (h : message ∈ possibleMessages first view) : message ∈ possibleMessages second view := by
  obtain ⟨r,held,id,hm,hk,obs⟩ := (possibleMeaning _ _ _).mp h
  exact (possibleMeaning _ _ _).mpr ⟨r,inc.transformations r held,id,inc.messages _ hm,inc.keys _ hk,
    (inc.observation r held).trans obs⟩

def supported (m : Model) : List Row := m.transformations.filter (fun r =>
  has m.messages r.message && has m.keys r.key && (image m.observation r.ciphertext).isSome)

theorem supportedMeaning (m : Model) (r : Row) : r ∈ supported m ↔ admitted m r := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    have q := (andTrue _ _).mp p.2; have a := (andTrue _ _).mp q.1
    refine ⟨p.1,(hasIff _ _).mp a.1,(hasIff _ _).mp a.2,?_⟩
    cases obs : image m.observation r.ciphertext with
    | none => rw [obs] at q; cases q.2
    | some v => exact ⟨v,rfl⟩
  · intro h; obtain ⟨view,obs⟩ := h.2.2.2
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.2.1,(hasIff _ _).mpr h.2.2.1⟩,by rw [obs]; rfl⟩⟩

def pairRows (m : Model) : List (Row × Row) :=
  (supported m).flatMap (fun a => (supported m).map (fun b => (a,b)))

theorem pairMeaning (m : Model) (a b : Row) : (a,b) ∈ pairRows m ↔ admitted m a ∧ admitted m b := by
  constructor
  · intro h
    obtain ⟨x,hx,h⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ h
    obtain ⟨y,hy,eq⟩ := memMapPreimage _ _ _ h
    have xa := congrArg Prod.fst eq; have yb := congrArg Prod.snd eq
    cases xa; cases yb
    exact ⟨(supportedMeaning _ _).mp hx,(supportedMeaning _ _).mp hy⟩
  · intro h
    exact SFT.Foundation.CommonRefinement.memFlatMap _ _ a (a,b) ((supportedMeaning _ _).mpr h.1)
      (memMap (fun b => (a,b)) b _ ((supportedMeaning _ _).mpr h.2))

def closedLedger (m : Model) : List (Row × Row) := (pairRows m).filter (fun pair =>
  decide (pair.1.message ≠ pair.2.message) &&
  decide (image m.observation pair.1.ciphertext = image m.observation pair.2.ciphertext))

theorem closedLedgerMeaning (m : Model) (a b : Row) : (a,b) ∈ closedLedger m ↔ closed m a b := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    have q := (pairMeaning _ _ _).mp p.1; have r := (andTrue _ _).mp p.2
    exact ⟨q.1,q.2,of_decide_eq_true r.1,of_decide_eq_true r.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨(pairMeaning _ _ _).mpr ⟨h.1,h.2.1⟩,
      (andTrue _ _).mpr ⟨decide_eq_true h.2.2.1,decide_eq_true h.2.2.2⟩⟩

theorem downstreamObservationClosed (m : Model) (a b : Row) (h : closed m a b)
    (next : Option String → Option String) :
    next (image m.observation a.ciphertext) = next (image m.observation b.ciphertext) := congrArg next h.2.2.2

def disclosedView (m : Model) (extra : Row → Option String) (r : Row) :=
  (image m.observation r.ciphertext,extra r)

theorem disclosureBoundary (m : Model) (a b : Row) (extra : Row → Option String) (different : extra a ≠ extra b) :
    disclosedView m extra a ≠ disclosedView m extra b := fun h => different (congrArg Prod.snd h)

end SFT.Computation.Secrecy
