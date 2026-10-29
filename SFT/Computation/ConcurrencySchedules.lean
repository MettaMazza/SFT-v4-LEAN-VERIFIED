import SFT.Computation.CausalOperations
import SFT.Computation.OrderingTrace
import SFT.Computation.ParallelResources
namespace SFT.Computation.ConcurrencySchedules
open SFT.Mathematics DiscreteObjects GeometryTopology CombinatorialArrangements
open StateTransition StateComposition

-- Event order is checked against every held causal row.
def precedes (left right : String) : List String → Bool
 | [] => false
 | head :: tail => if head = left then has tail right else precedes left right tail

inductive Before (left right : String) : List String → Prop where
 | here (tail : List String) (held : right ∈ tail) : Before left right (left :: tail)
 | later (head : String) (tail : List String) (different : head ≠ left)
     (prior : Before left right tail) : Before left right (head :: tail)

theorem precedesMeaning (left right : String) (schedule : List String) :
    precedes left right schedule = true ↔ Before left right schedule := by
  induction schedule with
  | nil => constructor <;> intro h <;> cases h
  | cons head tail ih =>
    change (if head = left then has tail right else precedes left right tail) = true ↔ _
    by_cases eq : head = left
    · rw [if_pos eq]
      cases eq
      constructor
      · intro h; exact .here _ ((hasIff _ _).mp h)
      · intro h; cases h with
        | here tail held => exact (hasIff _ _).mpr held
        | later head tail different prior => exact False.elim (different rfl)
    · rw [if_neg eq]
      constructor
      · intro h; exact .later _ _ eq (ih.mp h)
      · intro h; cases h with
        | here tail held => exact False.elim (eq rfl)
        | later head tail different prior => exact ih.mpr prior

def causalCheck (relation : List CausalClosure.Edge) (schedule : List String) : Bool :=
  relation.all (fun edge => precedes edge.1 edge.2 schedule)

theorem causalMeaning (relation : List CausalClosure.Edge) (schedule : List String) :
    causalCheck relation schedule = true ↔ ∀ edge, edge ∈ relation → Before edge.1 edge.2 schedule := by
  constructor
  · intro h edge held; exact (precedesMeaning _ _ _).mp ((allTrueIffMembers _ _).mp h edge held)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun edge held => (precedesMeaning _ _ _).mpr (h edge held))

def schedules (events : List String) (relation : List CausalClosure.Edge) : List (List String) :=
  (arrangementsCore events).filter (causalCheck relation)

theorem completeSchedules (events schedule : List String) (relation : List CausalClosure.Edge)
    (nonempty : events ≠ []) (unique : distinct events = true) :
    schedule ∈ schedules events relation ↔ List.Perm schedule events ∧
      ∀ edge, edge ∈ relation → Before edge.1 edge.2 schedule := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨(arrangementMembershipIff _ _ nonempty unique).mp p.1,(causalMeaning _ _).mp p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨(arrangementMembershipIff _ _ nonempty unique).mpr h.1,
      (causalMeaning _ _).mpr h.2⟩

structure Event where
  identity : String
  process : String
  before : String
  action : String
  after : String

def actionsFor (process : String) : List Event → List String
 | [] => []
 | event :: rest => if event.process = process then event.action :: actionsFor process rest else actionsFor process rest

def statesFor (process : String) : List Event → List String
 | [] => []
 | event :: rest => if event.process = process then event.before :: statesFor process rest else statesFor process rest

-- Each process retains its original local transition operation. Other process
-- events leave this local state unchanged; no physical simultaneity is asserted.
inductive Local (system : System) (process : String) : String → List Event → String → Prop where
 | identity (state : String) : Local system process state [] state
 | other (event : Event) (rest : List Event) (state terminal : String)
     (different : event.process ≠ process) (tail : Local system process state rest terminal) :
     Local system process state (event :: rest) terminal
 | own (event : Event) (rest : List Event) (terminal : String) (same : event.process = process)
     (enabled : step system event.before event.action = .ok event.after)
     (tail : Local system process event.after rest terminal) :
     Local system process event.before (event :: rest) terminal

theorem localPath (system : System) (process initial terminal : String) (events : List Event)
    (trace : Local system process initial events terminal) :
    StateComposition.Path system initial (actionsFor process events) (statesFor process events) terminal := by
  induction trace with
  | identity state => exact .identity state
  | other event rest state terminal different tail ih =>
    change StateComposition.Path system state
      (if event.process = process then event.action :: actionsFor process rest else actionsFor process rest)
      (if event.process = process then event.before :: statesFor process rest else statesFor process rest) terminal
    rw [if_neg different,if_neg different]; exact ih
  | own event rest terminal same enabled tail ih =>
    change StateComposition.Path system event.before
      (if event.process = process then event.action :: actionsFor process rest else actionsFor process rest)
      (if event.process = process then event.before :: statesFor process rest else statesFor process rest) terminal
    rw [if_pos same,if_pos same]; exact .next _ _ _ _ _ _ enabled ih

theorem nativeLocalObservation (system : System) (process initial terminal : String) (events : List Event)
    (input : initial ∈ system.states) (trace : Local system process initial events terminal) :
    run system initial (actionsFor process events) = .ok (statesFor process events ++ [terminal]) :=
  (runAdmission _ _ _ _).mpr ⟨input,(runFromMeaning _ _ _ _).mpr
    (pathExecution _ _ _ _ _ (localPath _ _ _ _ _ trace))⟩

theorem serialLocal (system : System) (process initial middle terminal : String) (first second : List Event)
    (one : Local system process initial first middle) (two : Local system process middle second terminal) :
    Local system process initial (first ++ second) terminal := by
  induction one with
  | identity state => exact two
  | other event rest state middle different tail ih => exact .other _ _ _ _ different (ih two)
  | own event rest middle same enabled tail ih => exact .own _ _ _ same enabled (ih two)

theorem actionsAppend (process : String) (first second : List Event) :
    actionsFor process (first ++ second) = actionsFor process first ++ actionsFor process second := by
  induction first with
  | nil => rfl
  | cons event rest ih =>
    change (if event.process = process then event.action :: actionsFor process (rest ++ second)
      else actionsFor process (rest ++ second)) = _
    by_cases same : event.process = process
    · rw [if_pos same,ih]; change event.action :: (actionsFor process rest ++ actionsFor process second) =
        (if event.process = process then event.action :: actionsFor process rest else actionsFor process rest) ++ actionsFor process second
      rw [if_pos same]; rfl
    · rw [if_neg same,ih]; change _ =
        (if event.process = process then event.action :: actionsFor process rest else actionsFor process rest) ++ actionsFor process second
      rw [if_neg same]

theorem independentLocalOrders (leftSystem rightSystem : System) (left right : Event)
    (different : left.process ≠ right.process)
    (leftEnabled : step leftSystem left.before left.action = .ok left.after)
    (rightEnabled : step rightSystem right.before right.action = .ok right.after) :
    Local leftSystem left.process left.before [left,right] left.after ∧
    Local leftSystem left.process left.before [right,left] left.after ∧
    Local rightSystem right.process right.before [left,right] right.after ∧
    Local rightSystem right.process right.before [right,left] right.after := by
  have reverse : right.process ≠ left.process := fun h => different h.symm
  exact ⟨.own left [right] _ rfl leftEnabled (.other right [] _ _ reverse (.identity _)),
    .other right [left] _ _ reverse (.own left [] _ rfl leftEnabled (.identity _)),
    .other left [right] _ _ different (.own right [] _ rfl rightEnabled (.identity _)),
    .own right [left] _ rfl rightEnabled (.other left [] _ _ different (.identity _))⟩

structure Process where
  identity : String
  system : System
  initial : String

-- The registry is retained in full. Every process must reconstruct its own
-- observation from the same complete event schedule.
def Reconstructs (processes : List Process) (events : List Event) : Prop :=
  ∀ process, process ∈ processes → process.initial ∈ process.system.states ∧
    ∃ terminal, Local process.system process.identity process.initial events terminal

theorem everyProcessObserved (processes : List Process) (events : List Event)
    (complete : Reconstructs processes events) (process : Process) (held : process ∈ processes) :
    ∃ terminal, run process.system process.initial (actionsFor process.identity events) =
      .ok (statesFor process.identity events ++ [terminal]) := by
  obtain ⟨input,terminal,trace⟩ := complete process held
  exact ⟨terminal,nativeLocalObservation _ _ _ _ _ input trace⟩

theorem earlierEventRetained (first second : List Event) (event : Event) (held : event ∈ first) :
    event ∈ first ++ second := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

-- The empty schedule is the retained identity observation, while nonempty
-- candidate schedules use the complete inherited arrangements enumeration.
def allSchedules (events : List String) (relation : List CausalClosure.Edge) : List (List String) :=
  if events = [] then (if causalCheck relation [] then [[]] else []) else schedules events relation

theorem allSchedulesComplete (events schedule : List String) (relation : List CausalClosure.Edge)
    (unique : distinct events = true) : schedule ∈ allSchedules events relation ↔
    List.Perm schedule events ∧ ∀ edge, edge ∈ relation → Before edge.1 edge.2 schedule := by
  by_cases empty : events = []
  · cases empty
    unfold allSchedules
    rw [if_pos rfl]
    constructor
    · intro member
      cases checked : causalCheck relation [] with
      | false => rw [checked] at member; cases member
      | true =>
        rw [checked] at member
        cases member with
        | head => exact ⟨.nil,(causalMeaning _ _).mp checked⟩
        | tail _ h => cases h
    · intro ⟨permutation,causal⟩
      have permLength : ∀ {a b : List String}, List.Perm a b → a.length = b.length := by
        intro a b perm
        induction perm with
        | nil => rfl
        | cons item perm ih => exact congrArg Nat.succ ih
        | swap a b rest => rfl
        | trans first second ihFirst ihSecond => exact ihFirst.trans ihSecond
      have length := permLength permutation
      cases schedule with
      | nil => rw [(causalMeaning _ _).mpr causal]; exact List.Mem.head _
      | cons head tail => cases length
  · unfold allSchedules
    rw [if_neg empty]
    exact completeSchedules _ _ _ empty unique

theorem eachLocalEnabled (system : System) (process initial terminal : String) (events : List Event)
    (trace : Local system process initial events terminal) :
    ∀ event, event ∈ events → event.process = process →
      step system event.before event.action = .ok event.after := by
  induction trace with
  | identity state => intro event held; cases held
  | other row rest state terminal different tail ih =>
    intro event held same
    cases held with
    | head => exact False.elim (different same)
    | tail _ member => exact ih event member same
  | own row rest terminal same enabled tail ih =>
    intro event held matched
    cases held with
    | head => exact enabled
    | tail _ member => exact ih event member matched

structure Admitted (processes : List Process) (registry : List Event)
    (relation : List CausalClosure.Edge) (events : List Event) : Prop where
  processIdentities : distinct (processes.map Process.identity) = true
  eventIdentities : distinct (registry.map Event.identity) = true
  completeNames : List.Perm (events.map Event.identity) (registry.map Event.identity)
  sourceRows : ∀ event, event ∈ events → event ∈ registry
  processBinding : ∀ event, event ∈ registry → event.process ∈ processes.map Process.identity
  causal : causalCheck relation (events.map Event.identity) = true
  localTraces : Reconstructs processes events

theorem admittedSchedule (processes : List Process) (registry events : List Event)
    (relation : List CausalClosure.Edge) (admitted : Admitted processes registry relation events) :
    events.map Event.identity ∈ allSchedules (registry.map Event.identity) relation :=
  (allSchedulesComplete _ _ _ admitted.eventIdentities).mpr
    ⟨admitted.completeNames,(causalMeaning _ _).mp admitted.causal⟩

theorem everyEventEnabled (processes : List Process) (registry events : List Event)
    (relation : List CausalClosure.Edge) (admitted : Admitted processes registry relation events)
    (event : Event) (held : event ∈ events) :
    ∃ process, process ∈ processes ∧ process.identity = event.process ∧
      step process.system event.before event.action = .ok event.after := by
  have binding := admitted.processBinding event (admitted.sourceRows event held)
  obtain ⟨process,registered,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ binding
  obtain ⟨input,terminal,trace⟩ := admitted.localTraces process registered
  exact ⟨process,registered,same,eachLocalEnabled _ _ _ _ _ trace event held same.symm⟩

theorem identityObservations (processes : List Process)
    (admitted : ∀ process, process ∈ processes → process.initial ∈ process.system.states) :
    Reconstructs processes [] := fun process held => ⟨admitted process held,process.initial,.identity _⟩

end SFT.Computation.ConcurrencySchedules
