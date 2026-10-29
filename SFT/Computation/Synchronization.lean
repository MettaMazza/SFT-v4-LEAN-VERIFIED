import SFT.Computation.ConcurrencySchedules
namespace SFT.Computation.Synchronization
open StateTransition

-- V3 SYNCHRONIZATION carrier: held participants and readiness states.
-- The rendezvous label is shared; each local transition remains source-bound.
structure Participant where
  identity : String
  system : System
  state : String
  deriving DecidableEq

structure Observation where
  participant : Participant
  outcome : Except String String

def observe (label : String) (p : Participant) : Observation :=
  ⟨p, step p.system p.state label⟩

def ledger (label : String) (participants : List Participant) : List Observation :=
  participants.map (observe label)

-- Retain every blocked row; no early failure erases the remaining observations.
def blocked : List Observation → List Observation
 | [] => []
 | row :: rest => match row.outcome with
   | .ok _ => blocked rest
   | .error _ => row :: blocked rest

-- Release exists only when all participant transitions are enabled.
def release (label : String) : List Participant → Option (List Participant)
 | [] => some []
 | p :: rest => match step p.system p.state label with
   | .error _ => none
   | .ok target => match release label rest with
     | none => none
     | some tail => some ({p with state := target} :: tail)

inductive Joint (label : String) : List Participant → List Participant → Prop where
 | identity : Joint label [] []
 | next (p : Participant) (rest tail : List Participant) (target : String)
     (enabled : step p.system p.state label = .ok target)
     (remaining : Joint label rest tail) :
     Joint label (p :: rest) ({p with state := target} :: tail)

theorem releaseMeaning (label : String) (before after : List Participant) :
    release label before = some after ↔ Joint label before after := by
  constructor
  · intro h
    induction before generalizing after with
    | nil => cases h; exact .identity
    | cons p rest ih =>
      cases enabled : step p.system p.state label with
      | error e => change (match step p.system p.state label with | .error _ => none | .ok target => match release label rest with | none => none | some tail => some ({p with state := target} :: tail)) = _ at h; rw [enabled] at h; cases h
      | ok target =>
        change (match step p.system p.state label with | .error _ => none | .ok target => match release label rest with | none => none | some tail => some ({p with state := target} :: tail)) = _ at h
        rw [enabled] at h
        cases tailResult : release label rest with
        | none => rw [tailResult] at h; cases h
        | some tail => rw [tailResult] at h; cases h; exact .next p rest tail target enabled (ih tail tailResult)
  · intro h
    induction h with
    | identity => rfl
    | next p rest tail target enabled remaining ih =>
      change (match step p.system p.state label with | .error _ => none | .ok target => match release label rest with | none => none | some tail => some ({p with state := target} :: tail)) = _
      rw [enabled,ih]

theorem participantIdentities (label : String) (before after : List Participant)
    (joint : Joint label before after) : before.map Participant.identity = after.map Participant.identity := by
  induction joint with
  | identity => rfl
  | next p rest tail target enabled remaining ih => exact congrArg (List.cons p.identity) ih

theorem systemIdentities (label : String) (before after : List Participant)
    (joint : Joint label before after) : before.map Participant.system = after.map Participant.system := by
  induction joint with
  | identity => rfl
  | next p rest tail target enabled remaining ih => exact congrArg (List.cons p.system) ih

theorem eachParticipantEnabled (label : String) (before after : List Participant)
    (joint : Joint label before after) (p : Participant) (held : p ∈ before) :
    ∃ target, step p.system p.state label = .ok target := by
  induction joint with
  | identity => cases held
  | next row rest tail target enabled remaining ih =>
    cases held with
    | head => exact ⟨target,enabled⟩
    | tail _ member => exact ih member

theorem noBlockedRelease (label : String) (before after : List Participant)
    (joint : Joint label before after) : blocked (ledger label before) = [] := by
  induction joint with
  | identity => rfl
  | next p rest tail target enabled remaining ih =>
    change (match step p.system p.state label with
      | .ok _ => blocked (ledger label rest)
      | .error _ => observe label p :: blocked (ledger label rest)) = []
    rw [enabled]; exact ih

theorem blockedParticipantPreventsRelease (label : String) (before after : List Participant)
    (p : Participant) (held : p ∈ before) (error : String)
    (failure : step p.system p.state label = .error error) : release label before ≠ some after := by
  intro successful
  obtain ⟨target,enabled⟩ := eachParticipantEnabled label before after ((releaseMeaning _ _ _).mp successful) p held
  have impossible := failure.symm.trans enabled
  cases impossible

theorem ledgerRetainsParticipants (label : String) (participants : List Participant) :
    (ledger label participants).map Observation.participant = participants := by
  induction participants with
  | nil => rfl
  | cons p rest ih => exact congrArg (List.cons p) ih

theorem ledgerAppend (label : String) (first second : List Participant) :
    ledger label (first ++ second) = ledger label first ++ ledger label second := by
  induction first with
  | nil => rfl
  | cons p rest ih => exact congrArg (List.cons (observe label p)) ih

theorem jointAssembly (label : String) (a b c d : List Participant)
    (first : Joint label a b) (second : Joint label c d) : Joint label (a ++ c) (b ++ d) := by
  induction first with
  | identity => exact second
  | next p rest tail target enabled remaining ih => exact .next p _ _ target enabled ih

theorem successorPreservesEarlier (label : String) (before after : List Participant)
    (joint : Joint label before after) (p : Participant) (target : String)
    (enabled : step p.system p.state label = .ok target) :
    Joint label (before ++ [p]) (after ++ [{p with state := target}]) :=
  jointAssembly label before after _ _ joint (.next p [] [] target enabled .identity)

-- Successive rendezvous retain their exact intermediate release interface.
inductive Trace : List Participant → List String → List (List Participant) → List Participant → Prop where
 | identity (state : List Participant) : Trace state [] [] state
 | next (before middle after : List Participant) (label : String) (labels : List String)
     (states : List (List Participant)) (joint : Joint label before middle)
     (rest : Trace middle labels states after) :
     Trace before (label :: labels) (before :: states) after

theorem serialTrace (a b c : List Participant) (xs ys : List String)
    (firstStates secondStates : List (List Participant))
    (first : Trace a xs firstStates b) (second : Trace b ys secondStates c) :
    Trace a (xs ++ ys) (firstStates ++ secondStates) c := by
  induction first with
  | identity state => exact second
  | next before middle after label labels states joint rest ih => exact .next _ _ _ _ _ _ joint (ih second)

theorem allReadyRelease (label : String) (before : List Participant)
    (ready : ∀ p, p ∈ before → ∃ target, step p.system p.state label = .ok target) :
    ∃ after, Joint label before after := by
  induction before with
  | nil => exact ⟨[],.identity⟩
  | cons p rest ih =>
    obtain ⟨target,enabled⟩ := ready p (List.Mem.head _)
    obtain ⟨tail,joint⟩ := ih (fun q held => ready q (List.Mem.tail _ held))
    exact ⟨{p with state := target} :: tail,.next p rest tail target enabled joint⟩

theorem exactReadiness (label : String) (before : List Participant) :
    (∃ after, release label before = some after) ↔
    (∀ p, p ∈ before → ∃ target, step p.system p.state label = .ok target) := by
  constructor
  · intro ⟨after,result⟩; exact eachParticipantEnabled label before after ((releaseMeaning _ _ _).mp result)
  · intro ready
    obtain ⟨after,joint⟩ := allReadyRelease label before ready
    exact ⟨after,(releaseMeaning _ _ _).mpr joint⟩

theorem blockedRowsComplete (rows : List Observation) (row : Observation) :
    row ∈ blocked rows ↔ row ∈ rows ∧ ∃ error, row.outcome = .error error := by
  induction rows with
  | nil => constructor <;> intro h; cases h; cases h.1
  | cons head rest ih =>
    cases out : head.outcome with
    | ok value =>
      change row ∈ (match head.outcome with | .ok _ => blocked rest | .error _ => head :: blocked rest) ↔ _
      rw [out]
      constructor
      · intro h; obtain ⟨held,err⟩ := ih.mp h; exact ⟨List.Mem.tail _ held,err⟩
      · intro ⟨held,error,failed⟩
        cases held with
        | head => cases out.symm.trans failed
        | tail _ held => exact ih.mpr ⟨held,error,failed⟩
    | error error =>
      change row ∈ (match head.outcome with | .ok _ => blocked rest | .error _ => head :: blocked rest) ↔ _
      rw [out]
      constructor
      · intro h; cases h with
        | head => exact ⟨List.Mem.head _,error,out⟩
        | tail _ held => obtain ⟨member,err⟩ := ih.mp held; exact ⟨List.Mem.tail _ member,err⟩
      · intro ⟨held,err⟩; cases held with
        | head => exact List.Mem.head _
        | tail _ member => exact List.Mem.tail _ (ih.mpr ⟨member,err⟩)

theorem jointSourceRows (label : String) (before after : List Participant)
    (joint : Joint label before after) (p : Participant) (held : p ∈ before) :
    ∃ target, (p.state,label,target) ∈ p.system.transitions := by
  obtain ⟨target,enabled⟩ := eachParticipantEnabled label before after joint p held
  exact ⟨target,stepSourceRow _ _ _ _ enabled⟩

theorem traceRetainsIdentities (before after : List Participant) (labels : List String)
    (states : List (List Participant)) (trace : Trace before labels states after) :
    before.map Participant.identity = after.map Participant.identity := by
  induction trace with
  | identity => rfl
  | next before middle after label labels states joint rest ih =>
    exact (participantIdentities _ _ _ joint).trans ih

theorem traceLength (before after : List Participant) (labels : List String)
    (states : List (List Participant)) (trace : Trace before labels states after) :
    labels.length = states.length := by
  induction trace with
  | identity => rfl
  | next before middle after label labels states joint rest ih => exact congrArg Nat.succ ih

end SFT.Computation.Synchronization
