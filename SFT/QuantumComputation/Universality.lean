import SFT.QuantumComputation.Circuit
namespace SFT.QuantumComputation.Universality
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleInterpretation
open SFT.QuantumComputation.ReversibleExecution SFT.QuantumComputation.Circuit
open SFT.InformationScience.EncodingClasses SFT.InformationScience.EncodingMaps SFT.InformationScience.EncodingDecoder

theorem interpreterSource (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (states : List State) (terminal : State)
    (executed : interpret registry decoder code = some (.ok (states,terminal))) :
    ∃ name request, decode code decoder = .ok name ∧ lookupFirst registry name = some request ∧
      evaluate request.initial request.gates = .ok (states,terminal) := by
  unfold interpret at executed
  cases d : decode code decoder with
  | error e => rw [d] at executed; cases executed
  | ok name =>
    rw [d] at executed
    dsimp only at executed
    cases l : lookupFirst registry name with
    | none => rw [l] at executed; cases executed
    | some request =>
      rw [l] at executed
      exact ⟨name,request,rfl,l,Option.some.inj executed⟩

theorem interpretedTraceAndPhase (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (states : List State) (terminal : State)
    (decoded : decode code decoder = .ok name) (selected : lookupFirst registry name = some request)
    (admitted : makeState request.initial.branches request.initial.phaseCycle = .ok request.initial)
    (valid : ∀ gate, gate ∈ request.gates → makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : interpret registry decoder code = some (.ok (states,terminal))) :
    Forward request.initial request.gates states terminal ∧
      terminal.phaseCycle = request.initial.phaseCycle ∧ states.length = request.gates.length := by
  rw [exactRequest registry decoder code name request decoded selected] at executed
  have evaluation := Option.some.inj executed
  have trace := evaluationHasExactTrace request.initial terminal request.gates states admitted valid evaluation
  exact ⟨trace,circuitPhaseCycle _ _ _ _ trace,retainedPredecessorCount _ _ _ _ trace⟩

open SFT.Mathematics.DiscreteObjects

theorem everyEncodedCircuitSimulated (registry : List (String × Request))
    (unique : distinct (registry.map Prod.fst) = true) (support : List Codeword)
    (encoding : Encoding) (decoder : Decoder)
    (valid : validateEncoding (registry.map Prod.fst) support encoding = true)
    (inverse : exactDecoder (registry.map Prod.fst) encoding = some decoder)
    (name : String) (request : Request) (member : (name,request) ∈ registry)
    (states : List State) (terminal : State)
    (trace : Forward request.initial request.gates states terminal) :
    ∃ code, code ∈ support ∧ lookupFirst encoding name = some code ∧
      interpret registry decoder code = some (.ok (states,terminal)) ∧
      Backward terminal (reverseOrder request.gates) request.initial ∧
      terminal.phaseCycle = request.initial.phaseCycle ∧ states.length = request.gates.length := by
  obtain ⟨code,held,encoded,run⟩ := completeFrozenGrammar registry unique support encoding decoder valid inverse name request member
  rw [forwardExecutes _ _ _ _ trace] at run
  exact ⟨code,held,encoded,run,exactInverseTrace _ _ _ _ trace,
    circuitPhaseCycle _ _ _ _ trace,retainedPredecessorCount _ _ _ _ trace⟩

open SFT.QuantumComputation.ReversibleObservation

theorem interpretedObservationPreserved (registry : List (String × Request)) (decoder : Decoder) (code : Codeword)
    (name : String) (request : Request) (states : List State) (terminal selectedState : State)
    (decoded : decode code decoder = .ok name) (selected : lookupFirst registry name = some request)
    (admitted : makeState request.initial.branches request.initial.phaseCycle = .ok request.initial)
    (valid : ∀ gate, gate ∈ request.gates → makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : interpret registry decoder code = some (.ok (states,terminal)))
    (mapping : Classification) (label : String) (record : List Record)
    (observed : observe terminal mapping label = .ok (selectedState,record)) :
    record.length = request.initial.branches.length ∧
      (⟨record.map Prod.fst,request.initial.phaseCycle⟩ : State) = terminal := by
  have trace := (interpretedTraceAndPhase registry decoder code name request states terminal
    decoded selected admitted valid executed).1
  exact circuitObservationRecord request.initial terminal selectedState request.gates states trace mapping label record observed

end SFT.QuantumComputation.Universality
