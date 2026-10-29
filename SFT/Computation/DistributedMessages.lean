import SFT.Computation.DistributedReplay
namespace SFT.Computation.DistributedMessages
open DistributedReplay
open SFT.Mathematics DiscreteObjects GeometryTopology AlgebraOperations
open SFT.Foundation.Count.TraceDerivation
open SFT.InformationScience.EncodingMaps

structure Port where
  message : String
  event : String
  process : String
  payload : String

-- Separate sent and received ledgers retain sends with no declared receipt.
def bound (alphabet : List String) (events : List Event) (port : Port) : Bool :=
  has alphabet port.payload && events.any (fun event => decide (event.identity = port.event ∧ event.process = port.process))

def before (events : List Event) (send receive : String) : Bool :=
  match SearchTrace.scan send (events.map Event.identity) with
  | none => false
  | some i => match SearchTrace.scan receive (events.map Event.identity) with
    | none => false
    | some j => decide (i < j)

def matching (events : List Event) (send receive : Port) : Bool :=
  decide (send.message = receive.message ∧ send.payload = receive.payload) && before events send.event receive.event

def valid (alphabet : List String) (events : List Event) (sent received : List Port) : Bool :=
  sent.all (bound alphabet events) && received.all (bound alphabet events) &&
    received.all (fun receive => sent.any (fun send => matching events send receive))

theorem boundMeaning (alphabet : List String) (events : List Event) (port : Port) :
    bound alphabet events port = true ↔ port.payload ∈ alphabet ∧
      ∃ event, event ∈ events ∧ event.identity = port.event ∧ event.process = port.process := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    obtain ⟨event,held,same⟩ := (anyTrueIff _ _).mp p.2
    have eq := of_decide_eq_true same
    exact ⟨(hasIff _ _).mp p.1,event,held,eq.1,eq.2⟩
  · intro ⟨payload,event,held,identity,process⟩
    exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr payload,(anyTrueIff _ _).mpr
      ⟨event,held,decide_eq_true ⟨identity,process⟩⟩⟩

theorem beforeMeaning (events : List Event) (send receive : String) :
    before events send receive = true ↔ ∃ i j,
      SearchTrace.scan send (events.map Event.identity) = some i ∧
      SearchTrace.scan receive (events.map Event.identity) = some j ∧ i < j := by
  unfold before
  cases left : SearchTrace.scan send (events.map Event.identity) with
  | none =>
    constructor
    · intro h; cases h
    · intro ⟨i,j,h,_,_⟩; cases h
  | some i =>
    cases right : SearchTrace.scan receive (events.map Event.identity) with
    | none =>
      constructor
      · intro h; cases h
      · intro ⟨a,b,_,h,_⟩; cases h
    | some j =>
      constructor
      · intro h; exact ⟨i,j,rfl,rfl,of_decide_eq_true h⟩
      · intro ⟨a,b,one,two,lt⟩; cases one; cases two; exact decide_eq_true lt

theorem matchingMeaning (events : List Event) (send receive : Port) :
    matching events send receive = true ↔ send.message = receive.message ∧
      send.payload = receive.payload ∧ before events send.event receive.event = true := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have same := of_decide_eq_true p.1
    exact ⟨same.1,same.2,p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨decide_eq_true ⟨h.1,h.2.1⟩,h.2.2⟩

theorem completeReceiptProvenance (alphabet : List String) (events : List Event) (sent received : List Port)
    (accepted : valid alphabet events sent received = true) (receive : Port) (held : receive ∈ received) :
    bound alphabet events receive = true ∧ ∃ send, send ∈ sent ∧ bound alphabet events send = true ∧
      send.message = receive.message ∧ send.payload = receive.payload ∧ before events send.event receive.event = true := by
  have p := (andTrue _ _).mp accepted
  have ports := (andTrue _ _).mp p.1
  obtain ⟨send,member,matched⟩ := (anyTrueIff _ _).mp (allTrueAtMember _ _ p.2 receive held)
  exact ⟨allTrueAtMember _ _ ports.2 receive held,send,member,
    allTrueAtMember _ _ ports.1 send member,(matchingMeaning _ _ _).mp matched⟩

theorem validFromRows (alphabet : List String) (events : List Event) (sent received : List Port)
    (sends : ∀ send, send ∈ sent → bound alphabet events send = true)
    (receives : ∀ receive, receive ∈ received → bound alphabet events receive = true)
    (paired : ∀ receive, receive ∈ received → ∃ send, send ∈ sent ∧ matching events send receive = true) :
    valid alphabet events sent received = true :=
  (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr sends,
    (allTrueIffMembers _ _).mpr receives⟩,
    (allTrueIffMembers _ _).mpr (fun receive held => (anyTrueIff _ _).mpr (paired receive held))⟩

theorem unpairedReceiptRejected (alphabet : List String) (events : List Event) (sent received : List Port)
    (receive : Port) (held : receive ∈ received)
    (missing : ∀ send, send ∈ sent → matching events send receive ≠ true) :
    valid alphabet events sent received ≠ true := by
  intro accepted
  obtain ⟨_,send,member,_,same,payload,causal⟩ := completeReceiptProvenance _ _ _ _ accepted receive held
  exact missing send member ((matchingMeaning _ _ _).mpr ⟨same,payload,causal⟩)

theorem noSelfCause (events : List Event) (identity : String) : before events identity identity ≠ true := by
  intro h
  obtain ⟨i,j,one,two,lt⟩ := (beforeMeaning _ _ _).mp h
  have eq := Option.some.inj (one.symm.trans two)
  cases eq; exact Nat.lt_irrefl _ lt

theorem causalTransitive (events : List Event) (first middle last : String)
    (one : before events first middle = true) (two : before events middle last = true) :
    before events first last = true := by
  obtain ⟨i,j,hi,hj,ij⟩ := (beforeMeaning _ _ _).mp one
  obtain ⟨k,l,hk,hl,kl⟩ := (beforeMeaning _ _ _).mp two
  have eq := Option.some.inj (hj.symm.trans hk)
  cases eq
  exact (beforeMeaning _ _ _).mpr ⟨i,l,hi,hl,Nat.lt_trans ij kl⟩

theorem noCausalReturn (events : List Event) (first second : String)
    (one : before events first second = true) : before events second first ≠ true :=
  fun two => noSelfCause _ _ (causalTransitive _ _ _ _ one two)

theorem payloadBoundary (alphabet : List String) (events : List Event) (port : Port)
    (missing : ¬ port.payload ∈ alphabet) : bound alphabet events port ≠ true :=
  fun h => missing ((boundMeaning _ _ _).mp h).1

theorem localFailureBoundary (registry : Registry) (store : Store) (event : Event)
    (machine : StateTransition.System) (reason : String)
    (registered : lookupFirst registry event.process = some machine)
    (current : lookupFirst store event.process = some event.before)
    (failed : StateTransition.step machine event.before event.action = .error reason) :
    replayEvent registry store event = none := by
  unfold replayEvent; rw [registered]; dsimp only; rw [current]; dsimp only
  rw [ite_eq_left rfl,failed]

theorem failureStopsGlobal (registry : Registry) (store : Store) (event : Event) (rest : List Event)
    (failed : replayEvent registry store event = none) : replay registry store (event :: rest) = none := by
  unfold replay; rw [failed]

-- A completed formal run retains both the full local trace and message ledger.
def Certificate (registry : Registry) (initial terminal : Store) (events : List Event)
    (alphabet : List String) (sent received : List Port) : Prop :=
  distinct (events.map Event.identity) = true ∧ GlobalTrace registry initial events terminal ∧
    valid alphabet events sent received = true

theorem globalResult (registry : Registry) (initial terminal : Store) (events : List Event)
    (alphabet : List String) (sent received : List Port)
    (certificate : Certificate registry initial terminal events alphabet sent received) :
    replay registry initial events = some terminal ∧ terminal.map Prod.fst = initial.map Prod.fst :=
  ⟨globalReplay _ _ _ _ certificate.2.1,globalIdentities _ _ _ _ certificate.2.1⟩

theorem boundExtension (alphabet : List String) (events added : List Event) (port : Port)
    (held : bound alphabet events port = true) : bound alphabet (events ++ added) port = true := by
  obtain ⟨payload,event,member,identity,process⟩ := (boundMeaning _ _ _).mp held
  exact (boundMeaning _ _ _).mpr ⟨payload,event,memAppendLeft _ _ _ member,identity,process⟩

theorem causalExtension (events added : List Event) (send receive : String)
    (ordered : before events send receive = true) : before (events ++ added) send receive = true := by
  obtain ⟨i,j,one,two,lt⟩ := (beforeMeaning _ _ _).mp ordered
  apply (beforeMeaning _ _ _).mpr
  rw [CommunicationResources.mapAppend]
  exact ⟨i,j,SearchTrace.retainedScan _ _ _ _ one,SearchTrace.retainedScan _ _ _ _ two,lt⟩

theorem ledgerExtension (alphabet : List String) (events added : List Event) (sent received : List Port)
    (accepted : valid alphabet events sent received = true) : valid alphabet (events ++ added) sent received = true := by
  have p := (andTrue _ _).mp accepted
  have ports := (andTrue _ _).mp p.1
  apply validFromRows
  · intro send held; exact boundExtension _ _ _ _ (allTrueAtMember _ _ ports.1 send held)
  · intro receive held; exact boundExtension _ _ _ _ (allTrueAtMember _ _ ports.2 receive held)
  · intro receive held
    obtain ⟨_,send,member,_,same,payload,causal⟩ := completeReceiptProvenance _ _ _ _ accepted receive held
    exact ⟨send,member,(matchingMeaning _ _ _).mpr ⟨same,payload,causalExtension _ _ _ _ causal⟩⟩

theorem ledgerComposition (alphabet : List String) (events : List Event) (s1 r1 s2 r2 : List Port)
    (one : valid alphabet events s1 r1 = true) (two : valid alphabet events s2 r2 = true) :
    valid alphabet events (s1 ++ s2) (r1 ++ r2) = true := by
  have p := (andTrue _ _).mp ((andTrue _ _).mp one).1
  have q := (andTrue _ _).mp ((andTrue _ _).mp two).1
  apply validFromRows
  · intro send held
    cases memAppendCases _ _ _ held with
    | inl old => exact allTrueAtMember _ _ p.1 send old
    | inr added => exact allTrueAtMember _ _ q.1 send added
  · intro receive held
    cases memAppendCases _ _ _ held with
    | inl old => exact allTrueAtMember _ _ p.2 receive old
    | inr added => exact allTrueAtMember _ _ q.2 receive added
  · intro receive held
    cases memAppendCases _ _ _ held with
    | inl old =>
      obtain ⟨_,send,member,_,same,payload,causal⟩ := completeReceiptProvenance _ _ _ _ one receive old
      exact ⟨send,memAppendLeft _ _ _ member,(matchingMeaning _ _ _).mpr ⟨same,payload,causal⟩⟩
    | inr added =>
      obtain ⟨_,send,member,_,same,payload,causal⟩ := completeReceiptProvenance _ _ _ _ two receive added
      exact ⟨send,memAppendRight _ _ _ member,(matchingMeaning _ _ _).mpr ⟨same,payload,causal⟩⟩

theorem identityLedger (alphabet : List String) (events : List Event) : valid alphabet events [] [] = true := rfl
end SFT.Computation.DistributedMessages
