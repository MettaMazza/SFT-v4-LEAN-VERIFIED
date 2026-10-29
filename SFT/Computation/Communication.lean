import SFT.Computation.Synchronization
import SFT.InformationScience.ConservationComposition
namespace SFT.Computation.Communication
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open SFT.Mathematics.GeometryTopology SFT.Mathematics.DiscreteObjects

-- V3 Communication carrier: both endpoint events and the actual channel row.
structure Event where
  identity : String
  process : String
  message : String
  content : String
  deriving DecidableEq

structure ChannelRow where
  sender : String
  receiver : String
  input : String
  output : String
  deriving DecidableEq

structure Delivery where
  sent : Event
  received : Event
  channel : ChannelRow
  deriving DecidableEq

-- Reliability, ordering and delay are not inferred from a channel row.
def compatible (d : Delivery) : Bool := decide
  (d.sent.process = d.channel.sender ∧ d.received.process = d.channel.receiver ∧
   d.sent.content = d.channel.input ∧ d.received.content = d.channel.output ∧
   d.sent.message = d.received.message)

def candidates (sends receives : List Event) (rows : List ChannelRow) : List Delivery :=
  sends.flatMap (fun s => receives.flatMap (fun t => rows.map (fun r => ⟨s,t,r⟩)))

def deliveries (sends receives : List Event) (rows : List ChannelRow) : List Delivery :=
  (candidates sends receives rows).filter compatible

def Admitted (sends receives : List Event) (rows : List ChannelRow) (d : Delivery) : Prop :=
  d.sent ∈ sends ∧ d.received ∈ receives ∧ d.channel ∈ rows ∧ compatible d = true

theorem candidateMeaning (sends receives : List Event) (rows : List ChannelRow) (d : Delivery) :
    d ∈ candidates sends receives rows ↔ d.sent ∈ sends ∧ d.received ∈ receives ∧ d.channel ∈ rows := by
  constructor
  · intro h
    obtain ⟨s,hs,hinner⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨t,ht,hmapped⟩ := memFlatMapOrigin _ _ _ hinner
    obtain ⟨r,hr,eq⟩ := memMapPreimage (fun r => Delivery.mk s t r) d rows hmapped
    cases eq
    exact ⟨hs,ht,hr⟩
  · intro ⟨hs,ht,hr⟩
    apply memFlatMap _ _ d.sent _ hs
    apply memFlatMap _ _ d.received _ ht
    exact memMap (fun r => Delivery.mk d.sent d.received r) d.channel rows hr

theorem deliveryMeaning (sends receives : List Event) (rows : List ChannelRow) (d : Delivery) :
    d ∈ deliveries sends receives rows ↔ Admitted sends receives rows d := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    have q := (candidateMeaning _ _ _ _).mp p.1
    exact ⟨q.1,q.2.1,q.2.2,p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨(candidateMeaning _ _ _ _).mpr ⟨h.1,h.2.1,h.2.2.1⟩,h.2.2.2⟩

theorem endpointMeaning (d : Delivery) (h : compatible d = true) :
    d.sent.process = d.channel.sender ∧ d.received.process = d.channel.receiver ∧
    d.sent.content = d.channel.input ∧ d.received.content = d.channel.output ∧
    d.sent.message = d.received.message := of_decide_eq_true h

theorem messageRetained (sends receives : List Event) (rows : List ChannelRow) (d : Delivery)
    (h : d ∈ deliveries sends receives rows) : d.sent.message = d.received.message :=
  (endpointMeaning d ((deliveryMeaning _ _ _ _).mp h).2.2.2).2.2.2.2

theorem missingSendRejected (sends receives : List Event) (rows : List ChannelRow) (d : Delivery)
    (absent : d.sent ∉ sends) : d ∉ deliveries sends receives rows :=
  fun h => absent ((deliveryMeaning _ _ _ _).mp h).1

theorem missingReceiveRejected (sends receives : List Event) (rows : List ChannelRow) (d : Delivery)
    (absent : d.received ∉ receives) : d ∉ deliveries sends receives rows :=
  fun h => absent ((deliveryMeaning _ _ _ _).mp h).2.1

theorem missingChannelRejected (sends receives : List Event) (rows : List ChannelRow) (d : Delivery)
    (absent : d.channel ∉ rows) : d ∉ deliveries sends receives rows :=
  fun h => absent ((deliveryMeaning _ _ _ _).mp h).2.2.1

-- Every earlier row survives extension of any of the held source ledgers.
theorem extensionRetains (sends receives : List Event) (rows : List ChannelRow)
    (moreSends moreReceives : List Event) (moreRows : List ChannelRow) (d : Delivery)
    (held : d ∈ deliveries sends receives rows) :
    d ∈ deliveries (sends ++ moreSends) (receives ++ moreReceives) (rows ++ moreRows) := by
  have h := (deliveryMeaning _ _ _ _).mp held
  exact (deliveryMeaning _ _ _ _).mpr
    ⟨memAppendLeft _ _ _ h.1,memAppendLeft _ _ _ h.2.1,memAppendLeft _ _ _ h.2.2.1,h.2.2.2⟩

-- A delivery trace is the retained sequence, not only its terminal event.
inductive Trace (sends receives : List Event) (rows : List ChannelRow) : Event → List Delivery → Event → Prop where
  | identity (event : Event) : Trace sends receives rows event [] event
  | next (d : Delivery) (rest : List Delivery) (last : Event)
      (admitted : Admitted sends receives rows d)
      (tail : Trace sends receives rows d.received rest last) :
      Trace sends receives rows d.sent (d :: rest) last

theorem traceRows (sends receives : List Event) (rows : List ChannelRow)
    (first last : Event) (trace : List Delivery) (h : Trace sends receives rows first trace last)
    (d : Delivery) (held : d ∈ trace) : Admitted sends receives rows d := by
  induction h with
  | identity => cases held
  | next row rest last admitted tail ih =>
    cases held with
    | head => exact admitted
    | tail _ member => exact ih member

theorem serialComposition (sends receives : List Event) (rows : List ChannelRow)
    (first middle last : Event) (a b : List Delivery)
    (ha : Trace sends receives rows first a middle) (hb : Trace sends receives rows middle b last) :
    Trace sends receives rows first (a ++ b) last := by
  induction ha with
  | identity => exact hb
  | next d rest last admitted tail ih => exact .next d _ _ admitted (ih hb)

theorem traceMessage (sends receives : List Event) (rows : List ChannelRow)
    (first last : Event) (trace : List Delivery) (h : Trace sends receives rows first trace last) :
    first.message = last.message := by
  induction h with
  | identity => rfl
  | next d rest last admitted tail ih =>
    exact (endpointMeaning d admitted.2.2.2).2.2.2.2.trans ih

-- Parallel ledgers retain whole delivery records, including endpoint identities.
def parallel (a b : List Delivery) : List Delivery := a ++ b

theorem parallelLeft (a b : List Delivery) (d : Delivery) (h : d ∈ a) : d ∈ parallel a b :=
  memAppendLeft _ _ _ h

theorem parallelRight (a b : List Delivery) (d : Delivery) (h : d ∈ b) : d ∈ parallel a b :=
  memAppendRight _ _ _ h

-- Distinction accounting is inherited from V3's admitted Information carriers.
-- Applying it to the recorded transformation preserves the complete loss ledger.
def recordedTransformation (trace : List Delivery) : SFT.Mathematics.ProbabilityObservations.Observation :=
  trace.map (fun d => (d.sent.content,d.received.content))

def distinctionLedger (source : List String) (trace : List Delivery) :=
  SFT.InformationScience.ConservationLedger.transformationLedger source (recordedTransformation trace)

theorem transformationRow (trace : List Delivery) (d : Delivery) (h : d ∈ trace) :
    (d.sent.content,d.received.content) ∈ recordedTransformation trace :=
  memMap _ _ _ h

theorem transformationProvenance (trace : List Delivery) (pair : String × String)
    (h : pair ∈ recordedTransformation trace) :
    ∃ d, d ∈ trace ∧ (d.sent.content,d.received.content) = pair :=
  memMapPreimage _ _ _ h

-- All actual delivery-pair distinctions, including relational channels, are retained.
def pairs : List Delivery → List (Delivery × Delivery)
  | [] => []
  | d :: rest => rest.map (fun e => (d,e)) ++ pairs rest

def retained (trace : List Delivery) : List (Delivery × Delivery) :=
  (pairs trace).filter (fun p => decide (p.1.sent.content ≠ p.2.sent.content ∧
    p.1.received.content ≠ p.2.received.content))

def lost (trace : List Delivery) : List (Delivery × Delivery) :=
  (pairs trace).filter (fun p => decide (p.1.sent.content ≠ p.2.sent.content ∧
    p.1.received.content = p.2.received.content))

theorem retainedMeaning (trace : List Delivery) (p : Delivery × Delivery) :
    p ∈ retained trace ↔ p ∈ pairs trace ∧ p.1.sent.content ≠ p.2.sent.content ∧
      p.1.received.content ≠ p.2.received.content := by
  constructor
  · intro h; have q := (filterMemberIff _ _ _).mp h
    exact ⟨q.1,of_decide_eq_true q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem lostMeaning (trace : List Delivery) (p : Delivery × Delivery) :
    p ∈ lost trace ↔ p ∈ pairs trace ∧ p.1.sent.content ≠ p.2.sent.content ∧
      p.1.received.content = p.2.received.content := by
  constructor
  · intro h; have q := (filterMemberIff _ _ _).mp h
    exact ⟨q.1,of_decide_eq_true q.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem deliveryDistinctionExhaustion (trace : List Delivery) (p : Delivery × Delivery)
    (held : p ∈ pairs trace) (distinct : p.1.sent.content ≠ p.2.sent.content) :
    p ∈ retained trace ∨ p ∈ lost trace := by
  by_cases eq : p.1.received.content = p.2.received.content
  · exact Or.inr ((lostMeaning _ _).mpr ⟨held,distinct,eq⟩)
  · exact Or.inl ((retainedMeaning _ _).mpr ⟨held,distinct,eq⟩)

theorem deliveryDistinctionDisjoint (trace : List Delivery) (p : Delivery × Delivery)
    (hr : p ∈ retained trace) (hl : p ∈ lost trace) : False :=
  ((retainedMeaning _ _).mp hr).2.2 (((lostMeaning _ _).mp hl).2.2)

theorem pairEndpoints (trace : List Delivery) (p : Delivery × Delivery) (h : p ∈ pairs trace) :
    p.1 ∈ trace ∧ p.2 ∈ trace := by
  induction trace with
  | nil => cases h
  | cons d rest ih =>
    cases memAppendCases _ _ _ h with
    | inl first =>
      obtain ⟨e,he,eq⟩ := memMapPreimage (fun e => (d,e)) p rest first
      cases eq; exact ⟨List.Mem.head _,List.Mem.tail _ he⟩
    | inr tail => have q := ih tail; exact ⟨List.Mem.tail _ q.1,List.Mem.tail _ q.2⟩

theorem pairSuccessor (trace : List Delivery) (next : Delivery) (p : Delivery × Delivery)
    (h : p ∈ pairs trace) : p ∈ pairs (trace ++ [next]) := by
  induction trace with
  | nil => cases h
  | cons d rest ih =>
    cases memAppendCases _ _ _ h with
    | inl first =>
      obtain ⟨e,he,eq⟩ := memMapPreimage (fun e => (d,e)) p rest first
      cases eq
      exact memAppendLeft _ _ _ (memMap (fun e => (d,e)) e _ (memAppendLeft _ _ _ he))
    | inr tail => exact memAppendRight _ _ _ (ih tail)

theorem retainedSuccessor (trace : List Delivery) (next : Delivery) (p : Delivery × Delivery)
    (h : p ∈ retained trace) : p ∈ retained (trace ++ [next]) := by
  have q := (retainedMeaning _ _).mp h
  exact (retainedMeaning _ _).mpr ⟨pairSuccessor _ _ _ q.1,q.2⟩

theorem lostSuccessor (trace : List Delivery) (next : Delivery) (p : Delivery × Delivery)
    (h : p ∈ lost trace) : p ∈ lost (trace ++ [next]) := by
  have q := (lostMeaning _ _).mp h
  exact (lostMeaning _ _).mpr ⟨pairSuccessor _ _ _ q.1,q.2⟩

theorem distinctionExhaustion (source : List String)
    (mapping : SFT.Mathematics.ProbabilityObservations.Observation) (pair : String × String)
    (held : pair ∈ SFT.InformationScience.EncodingLoss.sourcePairs source) :
    pair ∈ SFT.InformationScience.ConservationLedger.retained source mapping ∨
    pair ∈ SFT.InformationScience.ConservationLedger.closed source mapping :=
  SFT.InformationScience.ConservationLedger.pairExhaustion source mapping pair held

theorem lossPreserved (source : List String)
    (first second : SFT.Mathematics.ProbabilityObservations.Observation) (pair : String × String)
    (lost : pair ∈ SFT.InformationScience.ConservationLedger.closed source first) :
    pair ∈ SFT.InformationScience.ConservationLedger.closed source
      (SFT.InformationScience.ConservationComposition.composedRows source first second) :=
  SFT.InformationScience.ConservationComposition.closedPersists source first second pair lost

end SFT.Computation.Communication
