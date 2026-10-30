import SFT.QuantumComputation.Coding
import SFT.QuantumComputation.ReversibleExecution
namespace SFT.QuantumComputation.FaultTolerance
open SFT.QuantumComputation.ReversibleFaults

-- Exactly the source decoder followed by the source encoder at one recovery location.
def recover (trace : List String) (received : List String) : Except String (List String) :=
  match decode received with
  | .error error => .error error
  | .ok label => encode label trace

theorem recoveryRestoresEncodedWord (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) (mask : List Nat)
    (declared : mask ∈ faultMasks encoded.length trace.length) :
    recover trace (changeFrom mask (if label = "held" then "returned" else "held") 0 encoded) = .ok encoded := by
  unfold recover
  rw [SFT.QuantumComputation.Coding.everyDeclaredErrorReconstructed label trace encoded accepted mask declared]
  exact accepted

def recoverLocations (label : String) (trace : List String) : List (List Nat) → List String → Except String (List String)
  | [], encoded => .ok encoded
  | mask::rest, encoded =>
    match recover trace (changeFrom mask (if label = "held" then "returned" else "held") 0 encoded) with
    | .error error => .error error
    | .ok restored => recoverLocations label trace rest restored

theorem everyLocationRecovers (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) (locations : List (List Nat))
    (declared : ∀ mask, mask ∈ locations → mask ∈ faultMasks encoded.length trace.length) :
    recoverLocations label trace locations encoded = .ok encoded := by
  induction locations with
  | nil => rfl
  | cons mask rest ih =>
    rw [recoverLocations,recoveryRestoresEncodedWord label trace encoded accepted mask (declared mask (.head _))]
    exact ih (fun next held => declared next (.tail _ held))
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleApplication

-- Each annotated row retains its original phase and declared component fault mask.
def recoverRows (trace : List String) : List ((Word × String) × List Nat) → Except String (List (Word × String))
  | [] => .ok []
  | ((word,phase),mask)::rest =>
    match decode word with
    | .error error => .error error
    | .ok label =>
      match recover trace (changeFrom mask (if label = "held" then "returned" else "held") 0 word) with
      | .error error => .error error
      | .ok restored => match recoverRows trace rest with
        | .error error => .error error
        | .ok rows => .ok ((restored,phase)::rows)

theorem allContainedBranchesRecover (trace : List String) (rows : List ((Word × String) × List Nat))
    (contained : ∀ row, row ∈ rows → ∃ label, encode label trace = .ok row.1.1 ∧
      row.2 ∈ faultMasks row.1.1.length trace.length) :
    recoverRows trace rows = .ok (rows.map Prod.fst) := by
  induction rows with
  | nil => rfl
  | cons row rest ih =>
    obtain ⟨⟨word,phase⟩,mask⟩ := row
    obtain ⟨label,encoded,declared⟩ := contained ((word,phase),mask) (.head _)
    rw [recoverRows,SFT.QuantumComputation.Coding.encoderReconstruction label trace word encoded]
    dsimp only
    rw [recoveryRestoresEncodedWord label trace word encoded mask declared]
    dsimp only
    rw [ih (fun row held => contained row (.tail _ held))]
    rfl

theorem recoveryAfterContainedGate (initial result : State) (gate : Gate)
    (applied : applyGate initial gate false = .ok result) (trace : List String)
    (rows : List ((Word × String) × List Nat)) (complete : rows.map Prod.fst = result.branches)
    (contained : ∀ row, row ∈ rows → ∃ label, encode label trace = .ok row.1.1 ∧
      row.2 ∈ faultMasks row.1.1.length trace.length) :
    recoverRows trace rows = .ok result.branches ∧ result.phaseCycle = initial.phaseCycle := by
  rw [allContainedBranchesRecover trace rows contained,complete]
  exact ⟨rfl,(applicationSource initial result gate false applied).2.1⟩
open SFT.QuantumComputation.ReversibleExecution

inductive RecoveredExecution (trace : List String) : State → List Gate → State → Prop where
  | identity (state : State) : RecoveredExecution trace state [] state
  | next (state result terminal : State) (gate : Gate) (gates : List Gate)
      (applied : applyGate state gate false = .ok result)
      (rows : List ((Word × String) × List Nat))
      (complete : rows.map Prod.fst = result.branches)
      (recovered : recoverRows trace rows = .ok result.branches)
      (rest : RecoveredExecution trace result gates terminal) :
      RecoveredExecution trace state (gate::gates) terminal

theorem initialTraceMember (initial terminal : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) : initial ∈ states ++ [terminal] := by
  cases execution with
  | identity => exact .head _
  | next => exact .head _

theorem completeRecoveredExecution (initial terminal : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (trace : List String)
    (annotations : State → List ((Word × String) × List Nat))
    (complete : ∀ state, state ∈ states ++ [terminal] → (annotations state).map Prod.fst = state.branches)
    (contained : ∀ state, state ∈ states ++ [terminal] → ∀ row, row ∈ annotations state →
      ∃ label, encode label trace = .ok row.1.1 ∧ row.2 ∈ faultMasks row.1.1.length trace.length) :
    RecoveredExecution trace initial gates terminal := by
  induction execution with
  | identity state => exact .identity state
  | next state result terminal gate gates states admitted valid applied rest ih =>
    have held := initialTraceMember result terminal gates states rest
    have allHeld : result ∈ (state::states) ++ [terminal] := .tail state held
    have recovered := allContainedBranchesRecover trace (annotations result) (contained result allHeld)
    rw [complete result allHeld] at recovered
    exact .next state result terminal gate gates applied (annotations result) (complete result allHeld) recovered
      (ih (fun next member => complete next (.tail state member))
        (fun next member => contained next (.tail state member)))

theorem undecodableFaultRejected (trace received : List String) (error : String)
    (rejected : decode received = .error error) : recover trace received = .error error := by
  unfold recover
  rw [rejected]
end SFT.QuantumComputation.FaultTolerance
