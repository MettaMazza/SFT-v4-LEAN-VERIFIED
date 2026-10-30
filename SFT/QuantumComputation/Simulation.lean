import SFT.QuantumComputation.Universality
import SFT.QuantumComputation.Algorithms
namespace SFT.QuantumComputation.Simulation
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleInterpretation
open SFT.QuantumComputation.ReversibleExecution SFT.QuantumComputation.Circuit
open SFT.InformationScience.EncodingClasses SFT.InformationScience.EncodingMaps SFT.InformationScience.EncodingDecoder

theorem exactExecutionCorrespondence (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (states : List State) (terminal : State)
    (decoded : decode code decoder = .ok name) (selected : lookupFirst registry name = some request)
    (admitted : makeState request.initial.branches request.initial.phaseCycle = .ok request.initial)
    (valid : ∀ gate, gate ∈ request.gates → makeGate gate.wordMap gate.phaseSuccessors = .ok gate) :
    interpret registry decoder code = some (.ok (states,terminal)) ↔
      Forward request.initial request.gates states terminal := by
  constructor
  · intro executed
    rw [exactRequest registry decoder code name request decoded selected] at executed
    exact evaluationHasExactTrace request.initial terminal request.gates states admitted valid (Option.some.inj executed)
  · intro trace
    rw [exactRequest registry decoder code name request decoded selected,forwardExecutes _ _ _ _ trace]

theorem exactErrorCorrespondence (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (error : String)
    (decoded : decode code decoder = .ok name) (selected : lookupFirst registry name = some request) :
    interpret registry decoder code = some (.error error) ↔ evaluate request.initial request.gates = .error error := by
  rw [exactRequest registry decoder code name request decoded selected]
  exact ⟨Option.some.inj,congrArg some⟩
theorem simulationResourceAgreement (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (states : List State) (terminal : State)
    (decoded : decode code decoder = .ok name) (selected : lookupFirst registry name = some request)
    (admitted : makeState request.initial.branches request.initial.phaseCycle = .ok request.initial)
    (valid : ∀ gate, gate ∈ request.gates → makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : interpret registry decoder code = some (.ok (states,terminal))) :
    states.length = request.gates.length ∧ terminal.branches.length = request.initial.branches.length ∧
      terminal.phaseCycle = request.initial.phaseCycle := by
  have trace := (exactExecutionCorrespondence registry decoder code name request states terminal decoded selected admitted valid).mp executed
  exact ⟨retainedPredecessorCount _ _ _ _ trace,fullSupportRetained _ _ _ _ trace,circuitPhaseCycle _ _ _ _ trace⟩
open SFT.QuantumComputation.ReversibleObservation SFT.QuantumComputation.Algorithms

theorem simulatedObservationCorrespondence (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (states : List State) (terminal selectedState : State)
    (decoded : decode code decoder = .ok name) (selected : lookupFirst registry name = some request)
    (admitted : makeState request.initial.branches request.initial.phaseCycle = .ok request.initial)
    (valid : ∀ gate, gate ∈ request.gates → makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : interpret registry decoder code = some (.ok (states,terminal)))
    (mapping : Classification) (label : String) (record : List Record)
    (observed : observe terminal mapping label = .ok (selectedState,record)) (target : Word × String) :
    target ∈ selectedState.branches ↔
      (∃ source, source ∈ request.initial.branches ∧ BranchTrace request.initial.phaseCycle request.gates source target) ∧
      lookupFirst mapping target.1 = some label := by
  have trace := (exactExecutionCorrespondence registry decoder code name request states terminal decoded selected admitted valid).mp executed
  exact selectedBranchCorrectness request.initial terminal selectedState request.gates states trace mapping label record observed target

theorem simulatedInterferenceCorrespondence (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (states : List State) (terminal : State)
    (decoded : decode code decoder = .ok name) (selected : lookupFirst registry name = some request)
    (admitted : makeState request.initial.branches request.initial.phaseCycle = .ok request.initial)
    (valid : ∀ gate, gate ∈ request.gates → makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : interpret registry decoder code = some (.ok (states,terminal)))
    (mapping : Classification) (groups : List (String × List (Word × String)))
    (merged : predecessorMerge terminal mapping = .ok groups) (label : String)
    (rows : List (Word × String)) (group : (label,rows) ∈ groups) (target : Word × String) :
    target ∈ rows ↔
      (∃ source, source ∈ request.initial.branches ∧ BranchTrace request.initial.phaseCycle request.gates source target) ∧
      lookupFirst mapping target.1 = some label := by
  have trace := (exactExecutionCorrespondence registry decoder code name request states terminal decoded selected admitted valid).mp executed
  exact interferenceBranchCorrectness request.initial terminal request.gates states trace mapping groups merged label rows group target
end SFT.QuantumComputation.Simulation
