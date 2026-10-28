import SFT.Computation.RecognitionDomain
namespace SFT.Computation.RecognitionTrace
open StateTransition StateComposition MachineExecution
open SFT.Foundation.Count.TraceDerivation

-- A decision retains a terminating original path and one held answer label.
def Decision (system : System) (initial : String) (actions before : List String) (terminal : String) : Prop :=
  Halted system initial terminal actions before ∧ (terminal = "accept" ∨ terminal = "reject")

-- A retained unresolved prefix says nothing about whether a later prefix ends.
def Unresolved (system : System) (initial : String) (actions before : List String) (current : String) : Prop :=
  initial ∈ system.states ∧ Path system initial actions before current ∧
    current ≠ "accept" ∧ current ≠ "reject"

def Decides (system : System) (inputs : List (String × List String)) : Prop :=
  ∀ input, input ∈ inputs → ∃ before terminal, Decision system input.1 input.2 before terminal

theorem decisionReplays (system : System) (initial : String) (actions before : List String) (terminal : String)
    (decision : Decision system initial actions before terminal) :
    run system initial actions = .ok (before ++ [terminal]) := (haltReconstructs _ _ _ _ _ decision.1).1

theorem unresolvedReplays (system : System) (initial : String) (actions before : List String) (current : String)
    (prior : Unresolved system initial actions before current) :
    run system initial actions = .ok (before ++ [current]) :=
  (runAdmission _ _ _ _).mpr ⟨prior.1,(runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ prior.2.1)⟩

theorem unresolvedIsNotDecision (system : System) (initial : String) (actions before : List String) (current : String)
    (prior : Unresolved system initial actions before current) : ¬ Decision system initial actions before current := by
  intro decision
  cases decision.2 with
  | inl accepted => exact prior.2.2.1 accepted
  | inr rejected => exact prior.2.2.2 rejected

theorem decisionCannotContinue (system : System) (initial : String) (actions before : List String) (terminal : String)
    (decision : Decision system initial actions before terminal) (action target : String) :
    step system terminal action ≠ .ok target := haltHasNoContinuation _ _ _ _ _ decision.1 action target

theorem totalDomainHasNoMissingDecision (system : System) (inputs : List (String × List String))
    (total : Decides system inputs) (input : String × List String) (held : input ∈ inputs) :
    ∃ before terminal, run system input.1 input.2 = .ok (before ++ [terminal]) ∧
      (terminal = "accept" ∨ terminal = "reject") := by
  obtain ⟨before,terminal,decision⟩ := total input held
  exact ⟨before,terminal,decisionReplays _ _ _ _ _ decision,decision.2⟩

theorem totalSuccessor (system : System) (inputs : List (String × List String)) (input : String × List String) :
    Decides system (input :: inputs) ↔
      (∃ before terminal, Decision system input.1 input.2 before terminal) ∧ Decides system inputs := by
  constructor
  · intro total
    exact ⟨total input (.head inputs),fun request member => total request (.tail input member)⟩
  · intro both request member
    cases member with
    | head => exact both.1
    | tail _ held => exact both.2 request held

-- Concrete original generated process witnessing that a finite retained
-- continuation is not evidence of total decision or a negative answer.
def loop : System := ⟨["held"],["fold"],[("held","fold","held")]⟩

theorem loopAdmitted : create loop.states loop.actions loop.transitions = .ok loop := rfl

theorem loopNoDecision (actions before : List String) (terminal : String) :
    ¬ Decision loop "held" actions before terminal := by
  intro decision
  have member := executionStates _ _ _ _ loopAdmitted "held" (.head []) _ _
    (pathExecution _ _ _ _ _ decision.1.2.1) terminal
    (memAppendRight terminal before [terminal] (.head []))
  change terminal ∈ ["held"] at member
  cases member with
  | head => exact decisionCannotContinue _ _ _ _ _ decision "fold" "held" rfl
  | tail _ impossible => cases impossible

theorem loopNotTotal (actions : List String) : ¬ Decides loop [("held",actions)] := by
  intro total
  obtain ⟨before,terminal,decision⟩ := total ("held",actions) (.head [])
  exact loopNoDecision _ _ _ decision

theorem loopPrefix (depth : Nat) :
    Unresolved loop "held" (List.replicate depth "fold") (List.replicate depth "held") "held" := by
  have path : Path loop "held" (List.replicate depth "fold") (List.replicate depth "held") "held" := by
    induction depth with
    | zero => exact .identity "held"
    | succ depth ih => exact .next "held" "fold" "held" _ _ _ rfl ih
  exact ⟨.head [],path,(by decide),(by decide)⟩

end SFT.Computation.RecognitionTrace
