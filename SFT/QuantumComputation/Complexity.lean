import SFT.QuantumComputation.Circuit
import SFT.QuantumComputation.Superposition
namespace SFT.QuantumComputation.Complexity
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleExecution

theorem everyLiveSupportCount (initial terminal : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (state : State) (held : state ∈ states) :
    state.branches.length = initial.branches.length := by
  induction execution with
  | identity => cases held
  | next initial result terminal gate gates states admitted valid applied rest ih =>
    cases held with
    | head => rfl
    | tail _ member => exact (ih member).trans (stepRetainsCount initial result gate applied)

theorem completeLiveSupportLedger (initial terminal : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) :
    states.map (fun state => state.branches.length) = List.replicate gates.length initial.branches.length := by
  induction execution with
  | identity => rfl
  | next initial result terminal gate gates states admitted valid applied rest ih =>
    change initial.branches.length :: states.map (fun state => state.branches.length) =
      initial.branches.length :: List.replicate gates.length initial.branches.length
    rw [ih,stepRetainsCount initial result gate applied]

theorem serialGateLedger (initial middle terminal : State) (first second : List Gate)
    (before after : List State) (one : Forward initial first before middle)
    (two : Forward middle second after terminal) :
    (before ++ after).length = first.length + second.length ∧
      terminal.branches.length = initial.branches.length := by
  rw [SFT.Foundation.CommonRefinement.appendLength,retainedPredecessorCount _ _ _ _ one,
    retainedPredecessorCount _ _ _ _ two]
  exact ⟨rfl,(fullSupportRetained _ _ _ _ two).trans (fullSupportRetained _ _ _ _ one)⟩
theorem generatedLiveSupportCost (alphabet positions cycle : List String) (initial terminal : State)
    (generated : completeSupport alphabet positions cycle = .ok initial)
    (gates : List Gate) (states : List State) (execution : Forward initial gates states terminal) :
    states.map (fun state => state.branches.length) =
      List.replicate gates.length (alphabet.length ^ positions.length) ∧
      terminal.branches.length = alphabet.length ^ positions.length := by
  have count := SFT.QuantumComputation.Superposition.fullBranchCount alphabet positions cycle initial generated
  exact ⟨(completeLiveSupportLedger initial terminal gates states execution).trans
    (congrArg (List.replicate gates.length) count),
    (fullSupportRetained initial terminal gates states execution).trans count⟩

open SFT.QuantumComputation.ReversibleObservation

theorem generatedMeasurementCost (alphabet positions cycle : List String) (initial terminal selected : State)
    (generated : completeSupport alphabet positions cycle = .ok initial)
    (gates : List Gate) (states : List State) (execution : Forward initial gates states terminal)
    (mapping : Classification) (label : String) (record : List Record)
    (observed : observe terminal mapping label = .ok (selected,record)) :
    record.length = alphabet.length ^ positions.length :=
  (SFT.QuantumComputation.Circuit.circuitObservationRecord initial terminal selected gates states execution
    mapping label record observed).1.trans
    (SFT.QuantumComputation.Superposition.fullBranchCount alphabet positions cycle initial generated)

end SFT.QuantumComputation.Complexity
