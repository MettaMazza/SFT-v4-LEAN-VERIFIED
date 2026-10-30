import SFT.Computation.StateExtension
import SFT.Computation.OptimizationTrace
namespace SFT.Computation.Adaptation
open SFT.Computation.StateTransition
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
structure Model where
  updates : System
  initial : String
  constitution : String
  law : String
  performance : SFT.Mathematics.OptimizationSelection.Preference
structure Request where
  observations : List String
  constitution : String
  law : String
structure Receipt where
  observations : List String
  trace : List String
  constitution : String
  law : String
  deriving DecidableEq

def identityHeld (m : Model) (request : Request) : Bool :=
  decide (request.constitution = m.constitution) && decide (request.law = m.law)
def adapt (m : Model) (request : Request) : Except String Receipt :=
  if identityHeld m request then
    match run m.updates m.initial request.observations with
    | .error e => .error e
    | .ok trace => .ok ⟨request.observations,trace,m.constitution,m.law⟩
  else .error "update changes constitutional engine or claim law"

theorem identityMeaning (m : Model) (request : Request) : identityHeld m request = true ↔
    request.constitution = m.constitution ∧ request.law = m.law := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; exact ⟨of_decide_eq_true p.1,of_decide_eq_true p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨decide_eq_true h.1,decide_eq_true h.2⟩

theorem acceptedReceipt (m : Model) (request : Request) (receipt : Receipt)
    (accepted : adapt m request = .ok receipt) :
    identityHeld m request = true ∧ run m.updates m.initial request.observations = .ok receipt.trace ∧
    receipt.observations = request.observations ∧ receipt.constitution = m.constitution ∧ receipt.law = m.law := by
  unfold adapt at accepted
  cases held : identityHeld m request with
  | false => rw [held] at accepted; cases accepted
  | true =>
    rw [held] at accepted
    cases execution : run m.updates m.initial request.observations with
    | error e => rw [execution] at accepted; cases accepted
    | ok trace =>
      rw [execution] at accepted
      cases accepted
      exact ⟨rfl,rfl,rfl,rfl,rfl⟩

theorem identityRejected (m : Model) (request : Request) (changed : identityHeld m request = false) :
    adapt m request = .error "update changes constitutional engine or claim law" := by
  unfold adapt; rw [changed]; rfl

theorem executionFailure (m : Model) (request : Request) (error : String)
    (same : identityHeld m request = true) (failed : run m.updates m.initial request.observations = .error error) :
    adapt m request = .error error := by
  unfold adapt; rw [same,failed]; rfl

theorem receiptTrace (m : Model) (request : Request) (receipt : Receipt)
    (accepted : adapt m request = .ok receipt) :
    m.initial ∈ m.updates.states ∧ Execution m.updates m.initial request.observations receipt.trace := by
  have p := (runAdmission _ _ _ _).mp (acceptedReceipt _ _ _ accepted).2.1
  exact ⟨p.1,(runFromMeaning _ _ _ _).mp p.2⟩
def improves (m : Model) (better worse : String) : Bool := has m.performance (better,worse)
theorem improvementMeaning (m : Model) (better worse : String) :
    improves m better worse = true ↔ (better,worse) ∈ m.performance := hasIff _ _

theorem admittedReceipt (m : Model) (request : Request) (trace : List String)
    (identity : identityHeld m request = true)
    (execution : run m.updates m.initial request.observations = .ok trace) :
    adapt m request = .ok ⟨request.observations,trace,m.constitution,m.law⟩ := by
  unfold adapt; rw [identity,execution]; rfl

theorem updateComposition (m : Model) (middle last : String) (left right before after : List String)
    (initial : m.initial ∈ m.updates.states)
    (first : SFT.Computation.StateComposition.Path m.updates m.initial left before middle)
    (second : SFT.Computation.StateComposition.Path m.updates middle right after last) :
    adapt m ⟨left ++ right,m.constitution,m.law⟩ =
      .ok ⟨left ++ right,(before ++ after) ++ [last],m.constitution,m.law⟩ :=
  admittedReceipt _ _ _ ((identityMeaning _ _).mpr ⟨rfl,rfl⟩)
    (SFT.Computation.StateComposition.nativeComposition _ _ _ _ _ _ _ _ initial first second)

structure Extension (first second : Model) where
  initial : first.initial = second.initial
  constitution : first.constitution = second.constitution
  law : first.law = second.law
  admitted : create second.updates.states second.updates.actions second.updates.transitions = .ok second.updates
  states : ∀ s, s ∈ first.updates.states → s ∈ second.updates.states
  rows : ∀ r, r ∈ first.updates.transitions → r ∈ second.updates.transitions

theorem updateExtension (first second : Model) (extension : Extension first second)
    (request : Request) (receipt : Receipt) (accepted : adapt first request = .ok receipt) :
    adapt second request = .ok ⟨request.observations,receipt.trace,first.constitution,first.law⟩ := by
  have h := acceptedReceipt _ _ _ accepted
  have identities := (identityMeaning _ _).mp h.1
  have runExtended := SFT.Computation.StateExtension.extendRun _ _ extension.admitted extension.states extension.rows _ _ _ h.2.1
  rw [extension.initial] at runExtended
  have result := admittedReceipt second request receipt.trace
    ((identityMeaning _ _).mpr ⟨identities.1.trans extension.constitution,identities.2.trans extension.law⟩) runExtended
  rw [← extension.constitution,← extension.law] at result
  exact result
end SFT.Computation.Adaptation
