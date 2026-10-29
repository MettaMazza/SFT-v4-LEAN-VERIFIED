import SFT.Computation.Communication
namespace SFT.Computation.Replication
open StateTransition
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure Replica where
  identity : String
  state : String
  deriving DecidableEq

structure Update where
  identity : String
  sender : String
  receiver : String
  label : String
  deriving DecidableEq

-- A local update retains every other copy and its identity. The state transition
-- is the already admitted source operation; no merge policy is introduced.
inductive Change (system : System) (u : Update) : List Replica → List Replica → Prop where
  | here (copy : Replica) (rest : List Replica) (target : String)
      (recipient : copy.identity = u.receiver)
      (transition : StateTransition.step system copy.state u.label = .ok target) :
      Change system u (copy :: rest) ({copy with state := target} :: rest)
  | later (copy : Replica) (before after : List Replica)
      (changed : Change system u before after) :
      Change system u (copy :: before) (copy :: after)

structure Step (system : System) (registered : List Update) (propagation : List (String × String))
    (u : Update) (before after : List Replica) : Prop where
  registeredUpdate : u ∈ registered
  propagationRow : (u.sender,u.receiver) ∈ propagation
  senderHeld : u.sender ∈ before.map Replica.identity
  change : Change system u before after

theorem identitiesRetained (system : System) (u : Update) (before after : List Replica)
    (h : Change system u before after) : before.map Replica.identity = after.map Replica.identity := by
  induction h with
  | here => rfl
  | later copy before after changed ih => exact congrArg (List.cons copy.identity) ih

theorem replicaCountRetained (system : System) (u : Update) (before after : List Replica)
    (h : Change system u before after) : before.length = after.length := by
  induction h with
  | here => rfl
  | later copy before after changed ih => exact congrArg Nat.succ ih

theorem recipientHeld (system : System) (u : Update) (before after : List Replica)
    (h : Change system u before after) : u.receiver ∈ before.map Replica.identity := by
  induction h with
  | here copy rest target recipient transition => exact recipient ▸ List.Mem.head _
  | later copy before after changed ih => exact List.Mem.tail _ ih

theorem originalTransition (system : System) (u : Update) (before after : List Replica)
    (h : Change system u before after) :
    ∃ copy target, copy ∈ before ∧ copy.identity = u.receiver ∧
      (copy.state,u.label,target) ∈ system.transitions := by
  induction h with
  | here copy rest target recipient transition =>
    exact ⟨copy,target,List.Mem.head _,recipient,stepSourceRow _ _ _ _ transition⟩
  | later copy before after changed ih =>
    obtain ⟨held,target,member,recipient,row⟩ := ih
    exact ⟨held,target,List.Mem.tail _ member,recipient,row⟩

theorem unaffectedCopyRetained (system : System) (u : Update) (before after : List Replica)
    (h : Change system u before after) (copy : Replica) (held : copy ∈ before)
    (different : copy.identity ≠ u.receiver) : copy ∈ after := by
  induction h with
  | here row rest target recipient transition =>
    cases held with
    | head => exact False.elim (different recipient)
    | tail _ member => exact List.Mem.tail _ member
  | later row before after changed ih =>
    cases held with
    | head => exact List.Mem.head _
    | tail _ member => exact List.Mem.tail _ (ih member)

inductive Trace (system : System) (registered : List Update) (propagation : List (String × String)) :
    List Replica → List Update → List (List Replica) → List Replica → Prop where
  | identity (copies : List Replica) : Trace system registered propagation copies [] [] copies
  | next (before middle after : List Replica) (u : Update) (updates : List Update)
      (states : List (List Replica)) (step : Step system registered propagation u before middle)
      (tail : Trace system registered propagation middle updates states after) :
      Trace system registered propagation before (u :: updates) (before :: states) after

theorem traceIdentities (system : System) (registered : List Update) (propagation : List (String × String))
    (before after : List Replica) (updates : List Update) (states : List (List Replica))
    (h : Trace system registered propagation before updates states after) :
    before.map Replica.identity = after.map Replica.identity := by
  induction h with
  | identity => rfl
  | next before middle after u updates states step tail ih => exact (identitiesRetained _ _ _ _ step.change).trans ih

theorem traceUpdateProvenance (system : System) (registered : List Update) (propagation : List (String × String))
    (before after : List Replica) (updates : List Update) (states : List (List Replica))
    (h : Trace system registered propagation before updates states after) (u : Update) (held : u ∈ updates) :
    u ∈ registered ∧ (u.sender,u.receiver) ∈ propagation := by
  induction h with
  | identity => cases held
  | next before middle after row updates states step tail ih =>
    cases held with
    | head => exact ⟨step.registeredUpdate,step.propagationRow⟩
    | tail _ member => exact ih member

theorem serialTrace (system : System) (registered : List Update) (propagation : List (String × String))
    (a b c : List Replica) (xs ys : List Update) (sx sy : List (List Replica))
    (hx : Trace system registered propagation a xs sx b) (hy : Trace system registered propagation b ys sy c) :
    Trace system registered propagation a (xs ++ ys) (sx ++ sy) c := by
  induction hx with
  | identity => exact hy
  | next before middle after u updates states step tail ih => exact .next _ _ _ _ _ _ step (ih hy)

theorem traceLength (system : System) (registered : List Update) (propagation : List (String × String))
    (before after : List Replica) (updates : List Update) (states : List (List Replica))
    (h : Trace system registered propagation before updates states after) : updates.length = states.length := by
  induction h with
  | identity => rfl
  | next before middle after u updates states step tail ih => exact congrArg Nat.succ ih

-- Consistency is an explicit observation of all retained states, not a clock.
def consistent (copies : List Replica) (value : String) : Bool :=
  copies.all (fun copy => decide (copy.state = value))

def stateClass (copies : List Replica) (value : String) : List Replica :=
  copies.filter (fun copy => decide (copy.state = value))

theorem consistencyMeaning (copies : List Replica) (value : String) : consistent copies value = true ↔
    ∀ copy, copy ∈ copies → copy.state = value := by
  constructor
  · intro h copy held; exact of_decide_eq_true (allTrueAtMember _ _ h copy held)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun copy held => decide_eq_true (h copy held))

theorem classMeaning (copies : List Replica) (value : String) (copy : Replica) :
    copy ∈ stateClass copies value ↔ copy ∈ copies ∧ copy.state = value := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem completeStateClass (copies : List Replica) (copy : Replica) (held : copy ∈ copies) :
    copy ∈ stateClass copies copy.state := (classMeaning _ _ _).mpr ⟨held,rfl⟩

theorem distinctClasses (copies : List Replica) (a b : String) (different : a ≠ b) (copy : Replica)
    (ha : copy ∈ stateClass copies a) (hb : copy ∈ stateClass copies b) : False :=
  different (((classMeaning _ _ _).mp ha).2.symm.trans ((classMeaning _ _ _).mp hb).2)

theorem convergenceObservation (copies : List Replica) (value : String) (h : consistent copies value = true)
    (a b : Replica) (ha : a ∈ copies) (hb : b ∈ copies) : a.state = b.state :=
  ((consistencyMeaning _ _).mp h a ha).trans ((consistencyMeaning _ _).mp h b hb).symm

theorem conflictRejectsConsistency (copies : List Replica) (a b : Replica)
    (ha : a ∈ copies) (hb : b ∈ copies) (conflict : a.state ≠ b.state) (value : String) :
    consistent copies value ≠ true := fun h => conflict (convergenceObservation _ _ h _ _ ha hb)

theorem parallelConsistency (a b : List Replica) (value : String)
    (ha : consistent a value = true) (hb : consistent b value = true) : consistent (a ++ b) value = true := by
  apply (consistencyMeaning _ _).mpr
  intro copy held
  cases memAppendCases _ _ _ held with
  | inl h => exact (consistencyMeaning _ _).mp ha copy h
  | inr h => exact (consistencyMeaning _ _).mp hb copy h

-- A lost-order witness retains both histories; equal terminal copies do not
-- license replacing either history with the other.
structure OrderLoss where
  first : List Update
  second : List Update
  firstObservation : List Replica
  secondObservation : List Replica
  differentOrder : first ≠ second
  sameObservation : firstObservation = secondObservation

theorem lostOrderCannotRecover (loss : OrderLoss) (recover : List Replica → List Update) :
    ¬ (recover loss.firstObservation = loss.first ∧ recover loss.secondObservation = loss.second) := by
  intro h
  exact loss.differentOrder (h.1.symm.trans ((congrArg recover loss.sameObservation).trans h.2))

theorem earlierUpdateRetained (before extra : List Update) (u : Update) (held : u ∈ before) :
    u ∈ before ++ extra := memAppendLeft _ _ _ held

theorem changeParallelRight (system : System) (u : Update) (before after extra : List Replica)
    (h : Change system u before after) : Change system u (before ++ extra) (after ++ extra) := by
  induction h with
  | here copy rest target recipient transition => exact .here copy _ target recipient transition
  | later copy before after changed ih => exact .later copy _ _ ih

theorem changeParallelLeft (system : System) (u : Update) (before after earlierCopies : List Replica)
    (h : Change system u before after) : Change system u (earlierCopies ++ before) (earlierCopies ++ after) := by
  induction earlierCopies with
  | nil => exact h
  | cons copy rest ih => exact .later copy _ _ ih

theorem stepParallel (system : System) (registered : List Update) (propagation : List (String × String))
    (u : Update) (before after extra : List Replica)
    (h : Step system registered propagation u before after) :
    Step system registered propagation u (before ++ extra) (after ++ extra) := by
  refine ⟨h.registeredUpdate,h.propagationRow,?_,changeParallelRight _ _ _ _ _ h.change⟩
  obtain ⟨copy,held,eq⟩ := memMapPreimage Replica.identity u.sender before h.senderHeld
  exact eq ▸ memMap Replica.identity copy _ (memAppendLeft _ _ _ held)

theorem traceSuccessor (system : System) (registered : List Update) (propagation : List (String × String))
    (initial middle final : List Replica) (updates : List Update) (states : List (List Replica))
    (h : Trace system registered propagation initial updates states middle) (u : Update)
    (next : Step system registered propagation u middle final) :
    Trace system registered propagation initial (updates ++ [u]) (states ++ [middle]) final :=
  serialTrace _ _ _ _ _ _ _ _ _ _ h (.next middle final final u [] [] next (.identity final))

def retainedOrderLoss (system : System) (registered : List Update) (propagation : List (String × String))
    (initial final : List Replica) (first second : List Update) (firstStates secondStates : List (List Replica))
    (_firstTrace : Trace system registered propagation initial first firstStates final)
    (_secondTrace : Trace system registered propagation initial second secondStates final)
    (different : first ≠ second) : OrderLoss := ⟨first,second,final,final,different,rfl⟩

theorem nativeOrderLossCannotRecover (system : System) (registered : List Update) (propagation : List (String × String))
    (initial final : List Replica) (first second : List Update) (firstStates secondStates : List (List Replica))
    (firstTrace : Trace system registered propagation initial first firstStates final)
    (secondTrace : Trace system registered propagation initial second secondStates final)
    (different : first ≠ second) (recover : List Replica → List Update) :
    ¬ (recover final = first ∧ recover final = second) :=
  lostOrderCannotRecover (retainedOrderLoss system registered propagation initial final first second
    firstStates secondStates firstTrace secondTrace different) recover

end SFT.Computation.Replication
