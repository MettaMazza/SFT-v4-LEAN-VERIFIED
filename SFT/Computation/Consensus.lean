import SFT.Computation.Communication
namespace SFT.Computation.Consensus
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

-- A terminal common decision is checked under its declared boundary.
-- No termination guarantee for undeclared communication/fault models is added.
structure Record where
  inputs : List (String × String)
  decisions : List (String × Option String)
  sends : List Communication.Event
  receives : List Communication.Event
  channels : List Communication.ChannelRow
  messages : List Communication.Delivery
  communicationModel : String
  faultModel : String
  terminationDeclared : Bool

def processes (r : Record) : List String := r.inputs.map Prod.fst
def proposals (r : Record) : List String := r.inputs.map Prod.snd

def covered (r : Record) : Bool :=
  (processes r).all (fun p => r.decisions.any (fun d => decide (d.1 = p))) &&
  r.decisions.all (fun d => has (processes r) d.1)

def terminalAt (value : String) (states : List (String × Option String)) : Bool :=
  states.all (fun d => decide (d.2 = some value))

def messageValid (r : Record) (d : Communication.Delivery) : Bool :=
  has r.sends d.sent && has r.receives d.received && has r.channels d.channel && Communication.compatible d

def boundaryNamed (r : Record) : Bool :=
  decide (r.communicationModel ≠ "" ∧ r.faultModel ≠ "")

def accepts (r : Record) (value : String) : Bool :=
  boundaryNamed r && r.terminationDeclared && covered r && has (proposals r) value &&
  terminalAt value r.decisions && r.messages.all (messageValid r)

theorem coverageMeaning (r : Record) : covered r = true ↔
    (∀ p, p ∈ processes r → ∃ d, d ∈ r.decisions ∧ d.1 = p) ∧
    (∀ d, d ∈ r.decisions → d.1 ∈ processes r) := by
  constructor
  · intro h; have q := (andTrue _ _).mp h
    constructor
    · intro p hp
      obtain ⟨d,hd,eq⟩ := (anyTrueIff _ _).mp (allTrueAtMember _ _ q.1 p hp)
      exact ⟨d,hd,of_decide_eq_true eq⟩
    · intro d hd; exact (hasIff _ _).mp (allTrueAtMember _ _ q.2 d hd)
  · intro h
    apply (andTrue _ _).mpr
    constructor
    · apply (allTrueIffMembers _ _).mpr
      intro p hp; obtain ⟨d,hd,eq⟩ := h.1 p hp
      exact (anyTrueIff _ _).mpr ⟨d,hd,decide_eq_true eq⟩
    · exact (allTrueIffMembers _ _).mpr (fun d hd => (hasIff _ _).mpr (h.2 d hd))

theorem terminalMeaning (value : String) (states : List (String × Option String)) :
    terminalAt value states = true ↔ ∀ d, d ∈ states → d.2 = some value := by
  constructor
  · intro h d hd; exact of_decide_eq_true (allTrueAtMember _ _ h d hd)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun d hd => decide_eq_true (h d hd))

theorem messageMeaning (r : Record) (d : Communication.Delivery) :
    messageValid r d = true ↔ Communication.Admitted r.sends r.receives r.channels d := by
  constructor
  · intro h
    have a := (andTrue _ _).mp h
    have b := (andTrue _ _).mp a.1
    have c := (andTrue _ _).mp b.1
    exact ⟨(hasIff _ _).mp c.1,(hasIff _ _).mp c.2,(hasIff _ _).mp b.2,a.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(hasIff _ _).mpr h.1,(hasIff _ _).mpr h.2.1⟩,(hasIff _ _).mpr h.2.2.1⟩,h.2.2.2⟩

theorem acceptanceMeaning (r : Record) (value : String) : accepts r value = true ↔
    boundaryNamed r = true ∧ r.terminationDeclared = true ∧ covered r = true ∧
    value ∈ proposals r ∧ terminalAt value r.decisions = true ∧
    (∀ d, d ∈ r.messages → Communication.Admitted r.sends r.receives r.channels d) := by
  constructor
  · intro h
    have a := (andTrue _ _).mp h
    have b := (andTrue _ _).mp a.1
    have c := (andTrue _ _).mp b.1
    have d := (andTrue _ _).mp c.1
    have e := (andTrue _ _).mp d.1
    exact ⟨e.1,e.2,d.2,(hasIff _ _).mp c.2,b.2,
      fun row held => (messageMeaning _ _).mp (allTrueAtMember _ _ a.2 row held)⟩
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨h.1,h.2.1⟩,h.2.2.1⟩,(hasIff _ _).mpr h.2.2.2.1⟩,h.2.2.2.2.1⟩,?_⟩
    exact (allTrueIffMembers _ _).mpr (fun d hd => (messageMeaning _ _).mpr (h.2.2.2.2.2 d hd))

theorem proposalValidity (r : Record) (value : String) (h : accepts r value = true) :
    ∃ input, input ∈ r.inputs ∧ input.2 = value :=
  memMapPreimage Prod.snd value r.inputs ((acceptanceMeaning _ _).mp h).2.2.2.1

theorem agreement (r : Record) (value : String) (h : accepts r value = true)
    (a b : String × Option String) (ha : a ∈ r.decisions) (hb : b ∈ r.decisions) : a.2 = b.2 := by
  have terminal := (terminalMeaning _ _).mp ((acceptanceMeaning _ _).mp h).2.2.2.2.1
  exact (terminal a ha).trans (terminal b hb).symm

theorem everyProcessDecides (r : Record) (value : String) (h : accepts r value = true)
    (p : String) (hp : p ∈ processes r) : (p,some value) ∈ r.decisions := by
  obtain ⟨d,hd,eq⟩ := ((coverageMeaning _).mp ((acceptanceMeaning _ _).mp h).2.2.1).1 p hp
  have terminal := (terminalMeaning _ _).mp ((acceptanceMeaning _ _).mp h).2.2.2.2.1 d hd
  cases d with
  | mk process state => cases eq; cases terminal; exact hd

theorem boundaryExplicit (r : Record) (value : String) (h : accepts r value = true) :
    r.communicationModel ≠ "" ∧ r.faultModel ≠ "" :=
  of_decide_eq_true ((acceptanceMeaning _ _).mp h).1

theorem terminationExplicit (r : Record) (value : String) (h : accepts r value = true) :
    r.terminationDeclared = true := ((acceptanceMeaning _ _).mp h).2.1

theorem allMessagesReconstruct (r : Record) (value : String) (h : accepts r value = true)
    (d : Communication.Delivery) (held : d ∈ r.messages) :
    d ∈ Communication.deliveries r.sends r.receives r.channels :=
  (Communication.deliveryMeaning _ _ _ _).mpr (((acceptanceMeaning _ _).mp h).2.2.2.2.2 d held)

theorem pendingRejects (r : Record) (value process : String) (pending : (process,none) ∈ r.decisions) :
    accepts r value ≠ true := by
  intro h
  have impossible := (terminalMeaning _ _).mp ((acceptanceMeaning _ _).mp h).2.2.2.2.1 (process,none) pending
  cases impossible

theorem terminalAppend (value : String) (a b : List (String × Option String))
    (ha : terminalAt value a = true) (hb : terminalAt value b = true) : terminalAt value (a ++ b) = true := by
  apply (terminalMeaning _ _).mpr
  intro d hd
  cases memAppendCases _ _ _ hd with
  | inl h => exact (terminalMeaning _ _).mp ha d h
  | inr h => exact (terminalMeaning _ _).mp hb d h

theorem decisionSuccessor (value process : String) (states : List (String × Option String))
    (h : terminalAt value states = true) : terminalAt value (states ++ [(process,some value)]) = true :=
  terminalAppend _ _ _ h (by apply (terminalMeaning _ _).mpr; intro d hd; cases hd with | head => rfl | tail _ h => cases h)

def assemble (a b : Record) : Record :=
  ⟨a.inputs ++ b.inputs,a.decisions ++ b.decisions,a.sends ++ b.sends,
   a.receives ++ b.receives,a.channels ++ b.channels,a.messages ++ b.messages,
   a.communicationModel,a.faultModel,a.terminationDeclared && b.terminationDeclared⟩

theorem mappedAssembly {α β : Type} (f : α → β) (a b : List α) (x : β) :
    x ∈ (a ++ b).map f ↔ x ∈ a.map f ∨ x ∈ b.map f := by
  constructor
  · intro h; obtain ⟨row,held,eq⟩ := memMapPreimage f x _ h
    cases memAppendCases _ _ _ held with
    | inl ha => exact Or.inl (eq ▸ memMap f row a ha)
    | inr hb => exact Or.inr (eq ▸ memMap f row b hb)
  · intro h
    cases h with
    | inl ha =>
      obtain ⟨row,held,eq⟩ := memMapPreimage f x a ha
      exact eq ▸ memMap f row _ (memAppendLeft _ _ _ held)
    | inr hb =>
      obtain ⟨row,held,eq⟩ := memMapPreimage f x b hb
      exact eq ▸ memMap f row _ (memAppendRight _ _ _ held)

theorem assemblyCoverage (a b : Record) (ha : covered a = true) (hb : covered b = true) :
    covered (assemble a b) = true := by
  apply (coverageMeaning _).mpr
  constructor
  · intro p held
    cases (mappedAssembly Prod.fst a.inputs b.inputs p).mp held with
    | inl h =>
      obtain ⟨d,hd,eq⟩ := ((coverageMeaning _).mp ha).1 p h
      exact ⟨d,memAppendLeft _ _ _ hd,eq⟩
    | inr h =>
      obtain ⟨d,hd,eq⟩ := ((coverageMeaning _).mp hb).1 p h
      exact ⟨d,memAppendRight _ _ _ hd,eq⟩
  · intro d held
    apply (mappedAssembly Prod.fst a.inputs b.inputs d.1).mpr
    cases memAppendCases _ _ _ held with
    | inl h => exact Or.inl (((coverageMeaning _).mp ha).2 d h)
    | inr h => exact Or.inr (((coverageMeaning _).mp hb).2 d h)

theorem assemblyAcceptance (a b : Record) (value : String)
    (ha : accepts a value = true) (hb : accepts b value = true) :
    accepts (assemble a b) value = true := by
  have x := (acceptanceMeaning _ _).mp ha
  have y := (acceptanceMeaning _ _).mp hb
  apply (acceptanceMeaning _ _).mpr
  refine ⟨x.1,(andTrue _ _).mpr ⟨x.2.1,y.2.1⟩,assemblyCoverage _ _ x.2.2.1 y.2.2.1,
    (mappedAssembly Prod.snd _ _ _).mpr (Or.inl x.2.2.2.1),
    terminalAppend _ _ _ x.2.2.2.2.1 y.2.2.2.2.1,?_⟩
  intro d held
  cases memAppendCases _ _ _ held with
  | inl h =>
    have q := x.2.2.2.2.2 d h
    exact ⟨memAppendLeft _ _ _ q.1,memAppendLeft _ _ _ q.2.1,memAppendLeft _ _ _ q.2.2.1,q.2.2.2⟩
  | inr h =>
    have q := y.2.2.2.2.2 d h
    exact ⟨memAppendRight _ _ _ q.1,memAppendRight _ _ _ q.2.1,memAppendRight _ _ _ q.2.2.1,q.2.2.2⟩

-- Composition retains the declared boundary; incompatible declarations halt.
def compose (a b : Record) : Option Record :=
  if a.communicationModel = b.communicationModel ∧ a.faultModel = b.faultModel
  then some (assemble a b) else none

theorem compositionAccepted (a b : Record) (value : String)
    (same : a.communicationModel = b.communicationModel ∧ a.faultModel = b.faultModel)
    (ha : accepts a value = true) (hb : accepts b value = true) :
    compose a b = some (assemble a b) ∧ accepts (assemble a b) value = true := by
  constructor
  · unfold compose; rw [if_pos same]
  · exact assemblyAcceptance _ _ _ ha hb

theorem incompatibleBoundaryRejected (a b : Record)
    (different : ¬ (a.communicationModel = b.communicationModel ∧ a.faultModel = b.faultModel)) :
    compose a b = none := by unfold compose; rw [if_neg different]

def single (process value communication faults : String) : Record :=
  ⟨[(process,value)],[(process,some value)],[],[],[],[],communication,faults,true⟩

theorem singleAccepted (process value communication faults : String)
    (named : communication ≠ "" ∧ faults ≠ "") :
    accepts (single process value communication faults) value = true := by
  apply (acceptanceMeaning _ _).mpr
  refine ⟨decide_eq_true named,rfl,?_,List.Mem.head _,?_,?_⟩
  · apply (coverageMeaning _).mpr
    constructor
    · intro p hp; cases hp with
      | head => exact ⟨(process,some value),List.Mem.head _,rfl⟩
      | tail _ h => cases h
    · intro d hd; cases hd with
      | head => exact List.Mem.head _
      | tail _ h => cases h
  · apply (terminalMeaning _ _).mpr
    intro d hd; cases hd with
    | head => rfl
    | tail _ h => cases h
  · intro d hd; cases hd

theorem processSuccessor (r : Record) (value process : String) (h : accepts r value = true) :
    accepts (assemble r (single process value r.communicationModel r.faultModel)) value = true :=
  assemblyAcceptance _ _ _ h (singleAccepted _ _ _ _ (boundaryExplicit _ _ h))

theorem earlierInputsRetained (a b : Record) (row : String × String) (h : row ∈ a.inputs) :
    row ∈ (assemble a b).inputs := memAppendLeft _ _ _ h

theorem earlierMessagesRetained (a b : Record) (row : Communication.Delivery) (h : row ∈ a.messages) :
    row ∈ (assemble a b).messages := memAppendLeft _ _ _ h

end SFT.Computation.Consensus
