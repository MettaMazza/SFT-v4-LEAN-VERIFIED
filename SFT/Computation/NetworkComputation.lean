import SFT.Computation.Communication
import SFT.Computation.FaultModel
namespace SFT.Computation.NetworkComputation
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

structure LocalMachine where
  process : String
  system : StateTransition.System

structure Action where
  process : String
  before : String
  label : String
  after : String
  resources : List String
  faults : List FaultModel.Fault

structure Network where
  machines : List LocalMachine
  sends : List Communication.Event
  receives : List Communication.Event
  channels : List Communication.ChannelRow
  actions : List Action
  schedules : List (List Action)
  resources : List String
  faults : List FaultModel.Fault

def ActionAdmitted (n : Network) (a : Action) : Prop :=
  a ∈ n.actions ∧
  (∃ m, m ∈ n.machines ∧ m.process = a.process ∧ StateTransition.step m.system a.before a.label = .ok a.after) ∧
  (∀ r, r ∈ a.resources → r ∈ n.resources) ∧ (∀ f, f ∈ a.faults → f ∈ n.faults)

def DeliveryAdmitted (n : Network) (d : Communication.Delivery) : Prop :=
  Communication.Admitted n.sends n.receives n.channels d ∧
  (∃ m, m ∈ n.machines ∧ m.process = d.sent.process) ∧
  (∃ m, m ∈ n.machines ∧ m.process = d.received.process)

structure Node where
  process : String
  state : String

inductive Change (a : Action) : List Node → List Node → Prop where
  | here (tail : List Node) : Change a (⟨a.process,a.before⟩::tail) (⟨a.process,a.after⟩::tail)
  | later (node : Node) (before after : List Node) : Change a before after → Change a (node::before) (node::after)

inductive Trace (n : Network) : List Node → List Action → List (List Node) → List Node → Prop where
  | identity (nodes) : Trace n nodes [] [] nodes
  | next (before middle after) (a actions states) :
      ActionAdmitted n a → Change a before middle → Trace n middle actions states after →
      Trace n before (a::actions) (before::states) after

structure Execution (n : Network) where
  initial : List Node
  actions : List Action
  states : List (List Node)
  result : List Node
  messages : List Communication.Delivery
  schedule : actions ∈ n.schedules
  trace : Trace n initial actions states result
  deliveries : ∀ d, d ∈ messages → DeliveryAdmitted n d
  initialSupport : ∀ node, node ∈ initial → ∃ m, m ∈ n.machines ∧ m.process = node.process

theorem localSource (n : Network) (a : Action) (h : ActionAdmitted n a) :
    ∃ m, m ∈ n.machines ∧ m.process = a.process ∧ (a.before,a.label,a.after) ∈ m.system.transitions := by
  obtain ⟨m,held,identity,step⟩ := h.2.1
  exact ⟨m,held,identity,StateTransition.stepSourceRow _ _ _ _ step⟩

theorem identitiesRetained (a : Action) (before after : List Node) (h : Change a before after) :
    before.map Node.process = after.map Node.process := by
  induction h with
  | here => rfl
  | later node before after change ih => exact congrArg (List.cons node.process) ih

theorem traceProvenance (n : Network) (before after : List Node) (actions : List Action) (states : List (List Node))
    (h : Trace n before actions states after) : ∀ a, a ∈ actions → ActionAdmitted n a := by
  induction h with
  | identity => intro a held; cases held
  | next before middle after a actions states admitted change rest ih =>
    intro row held; cases held with
    | head => exact admitted
    | tail _ held => exact ih row held

theorem traceIdentities (n : Network) (before after : List Node) (actions : List Action) (states : List (List Node))
    (h : Trace n before actions states after) : before.map Node.process = after.map Node.process := by
  induction h with
  | identity => rfl
  | next before middle after a actions states admitted change rest ih => exact (identitiesRetained _ _ _ change).trans ih

theorem serial (n : Network) (a b c : List Node) (xs ys : List Action) (sx sy : List (List Node))
    (first : Trace n a xs sx b) (second : Trace n b ys sy c) : Trace n a (xs++ys) (sx++sy) c := by
  induction first with
  | identity => exact second
  | next before middle after row actions states admitted change rest ih =>
    exact .next _ _ _ _ _ _ admitted change (ih second)

def resourceLedger (actions : List Action) : List String := actions.flatMap Action.resources
def faultLedger (actions : List Action) : List FaultModel.Fault := actions.flatMap Action.faults

theorem messageSource (n : Network) (e : Execution n) (d : Communication.Delivery) (held : d ∈ e.messages) :
    d.channel ∈ n.channels ∧ d.sent ∈ n.sends ∧ d.received ∈ n.receives := by
  have h := (e.deliveries d held).1; exact ⟨h.2.2.1,h.1,h.2.1⟩

theorem unregisteredScheduleRejected (n : Network) (e : Execution n) : e.actions ∈ n.schedules := e.schedule

theorem resourceSource (n : Network) (e : Execution n) (r : String) (held : r ∈ resourceLedger e.actions) :
    r ∈ n.resources := by
  obtain ⟨a,ha,hr⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ held
  exact (traceProvenance _ _ _ _ _ e.trace a ha).2.2.1 r hr

theorem faultSource (n : Network) (e : Execution n) (f : FaultModel.Fault) (held : f ∈ faultLedger e.actions) :
    f ∈ n.faults := by
  obtain ⟨a,ha,hf⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ held
  exact (traceProvenance _ _ _ _ _ e.trace a ha).2.2.2 f hf

theorem traceExtension (first second : Network)
    (retained : ∀ a, ActionAdmitted first a → ActionAdmitted second a)
    (before after : List Node) (actions : List Action) (states : List (List Node))
    (h : Trace first before actions states after) : Trace second before actions states after := by
  induction h with
  | identity => exact .identity _
  | next before middle after a actions states admitted change rest ih =>
    exact .next _ _ _ _ _ _ (retained a admitted) change ih

theorem changeParallelRight (a : Action) (before after other : List Node) (h : Change a before after) :
    Change a (before++other) (after++other) := by
  induction h with
  | here => exact .here _
  | later node before after change ih => exact .later _ _ _ ih

theorem changeParallelLeft (a : Action) (before after other : List Node) (h : Change a before after) :
    Change a (other++before) (other++after) := by
  induction other with
  | nil => exact h
  | cons node tail ih => exact .later _ _ _ ih

structure Inclusion (first second : Network) : Prop where
  machines : ∀ m, m ∈ first.machines → m ∈ second.machines
  sends : ∀ e, e ∈ first.sends → e ∈ second.sends
  receives : ∀ e, e ∈ first.receives → e ∈ second.receives
  channels : ∀ c, c ∈ first.channels → c ∈ second.channels
  actions : ∀ a, a ∈ first.actions → a ∈ second.actions
  schedules : ∀ s, s ∈ first.schedules → s ∈ second.schedules
  resources : ∀ r, r ∈ first.resources → r ∈ second.resources
  faults : ∀ f, f ∈ first.faults → f ∈ second.faults

theorem actionExtension (first second : Network) (inc : Inclusion first second)
    (a : Action) (h : ActionAdmitted first a) : ActionAdmitted second a := by
  obtain ⟨m,hm,id,step⟩ := h.2.1
  exact ⟨inc.actions a h.1,⟨m,inc.machines m hm,id,step⟩,
    (fun r hr => inc.resources r (h.2.2.1 r hr)),(fun f hf => inc.faults f (h.2.2.2 f hf))⟩

theorem deliveryExtension (first second : Network) (inc : Inclusion first second)
    (d : Communication.Delivery) (h : DeliveryAdmitted first d) : DeliveryAdmitted second d := by
  obtain ⟨sender,hs,sid⟩ := h.2.1
  obtain ⟨receiver,hr,rid⟩ := h.2.2
  exact ⟨⟨inc.sends _ h.1.1,inc.receives _ h.1.2.1,inc.channels _ h.1.2.2.1,h.1.2.2.2⟩,
    ⟨sender,inc.machines _ hs,sid⟩,⟨receiver,inc.machines _ hr,rid⟩⟩

def extendExecution (first second : Network) (inc : Inclusion first second) (e : Execution first) : Execution second :=
  ⟨e.initial,e.actions,e.states,e.result,e.messages,inc.schedules _ e.schedule,
    traceExtension _ _ (actionExtension _ _ inc) _ _ _ _ e.trace,
    fun d held => deliveryExtension _ _ inc d (e.deliveries d held),by
      intro node held
      obtain ⟨m,hm,id⟩ := e.initialSupport node held
      exact ⟨m,inc.machines m hm,id⟩⟩

theorem extensionRetainsTrace (first second : Network) (inc : Inclusion first second) (e : Execution first) :
    (extendExecution first second inc e).actions = e.actions ∧
    (extendExecution first second inc e).states = e.states ∧
    (extendExecution first second inc e).messages = e.messages ∧
    (extendExecution first second inc e).result = e.result := ⟨rfl,rfl,rfl,rfl⟩

theorem resultProcessSource (n : Network) (e : Execution n) (node : Node) (held : node ∈ e.result) :
    ∃ m, m ∈ n.machines ∧ m.process = node.process := by
  have member := memMap Node.process node e.result held
  rw [← traceIdentities _ _ _ _ _ e.trace] at member
  obtain ⟨initial,hi,id⟩ := memMapPreimage _ _ _ member
  obtain ⟨m,hm,mid⟩ := e.initialSupport initial hi
  exact ⟨m,hm,mid.trans id⟩

end SFT.Computation.NetworkComputation
