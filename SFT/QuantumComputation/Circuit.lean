import SFT.QuantumComputation.ReversibleInterpretation
import SFT.QuantumComputation.Measurement
namespace SFT.QuantumComputation.Circuit
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleApplication
open SFT.QuantumComputation.ReversibleExecution SFT.QuantumComputation.ReversibleInterpretation

theorem applicationAdmitted (state result : State) (gate : Gate)
    (admitted : makeState state.branches state.phaseCycle = .ok state)
    (valid : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : applyGate state gate false = .ok result) :
    makeState result.branches result.phaseCycle = .ok result := by
  obtain ⟨other,run,admission,_⟩ := applicationExists state gate false admitted valid
    (applicationSource state result gate false executed).1
  rw [executed] at run
  cases run
  exact admission

theorem evaluationHasExactTrace (initial terminal : State) (gates : List Gate) (states : List State)
    (admitted : makeState initial.branches initial.phaseCycle = .ok initial)
    (valid : ∀ gate, gate ∈ gates → makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : evaluate initial gates = .ok (states,terminal)) :
    Forward initial gates states terminal := by
  induction gates generalizing initial states with
  | nil => cases executed; exact .identity terminal
  | cons gate rest ih =>
    unfold evaluate at executed
    cases app : applyGate initial gate false with
    | error e => rw [app] at executed; cases executed
    | ok result =>
      rw [app] at executed
      dsimp only at executed
      cases ev : evaluate result rest with
      | error e => rw [ev] at executed; cases executed
      | ok pair =>
        obtain ⟨prior,last⟩ := pair
        rw [ev] at executed
        cases executed
        have gateValid := valid gate (.head _)
        exact .next _ _ _ _ _ _ admitted gateValid app
          (ih result prior (applicationAdmitted initial result gate admitted gateValid app)
            (fun next held => valid next (.tail _ held)) ev)

theorem circuitInverseAndLedger (initial terminal : State) (gates : List Gate) (states : List State)
    (admitted : makeState initial.branches initial.phaseCycle = .ok initial)
    (valid : ∀ gate, gate ∈ gates → makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : evaluate initial gates = .ok (states,terminal)) :
    Backward terminal (reverseOrder gates) initial ∧ states.length = gates.length ∧
      terminal.branches.length = initial.branches.length := by
  have trace := evaluationHasExactTrace initial terminal gates states admitted valid executed
  exact ⟨exactInverseTrace _ _ _ _ trace,retainedPredecessorCount _ _ _ _ trace,
    fullSupportRetained _ _ _ _ trace⟩

theorem circuitPhaseCycle (initial terminal : State) (gates : List Gate) (states : List State)
    (trace : Forward initial gates states terminal) : terminal.phaseCycle = initial.phaseCycle := by
  induction trace with
  | identity => rfl
  | next state result terminal gate gates states admitted valid applied rest ih =>
    exact ih.trans (applicationSource state result gate false applied).2.1

open SFT.QuantumComputation.ReversibleObservation

theorem circuitObservationRecord (initial terminal selected : State) (gates : List Gate) (states : List State)
    (trace : Forward initial gates states terminal) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record)) :
    record.length = initial.branches.length ∧
      (⟨record.map Prod.fst,initial.phaseCycle⟩ : State) = terminal := by
  have reconstruction := observationReconstruction terminal selected mapping label record observed
  refine ⟨reconstruction.2.trans (fullSupportRetained initial terminal gates states trace),?_⟩
  rw [reconstruction.1,← circuitPhaseCycle initial terminal gates states trace]

end SFT.QuantumComputation.Circuit
