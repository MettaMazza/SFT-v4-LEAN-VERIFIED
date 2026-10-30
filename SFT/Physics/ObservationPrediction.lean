import SFT.Physics.ObservationCarrier
namespace SFT.Physics.ObservationPrediction
open CapabilityAdmission CapabilityExecution CapabilityPrediction
-- Exact prediction_program_document instruction sequence from generated_empirical_law.py.
def predictionSteps (label : String) : List Instruction := [
  ⟨.input,"premise",["registered-premise"]⟩,
  ⟨.label,"prediction",["physical-observation",label]⟩,
  ⟨.pair,"bound-result",["premise","prediction"]⟩,
  ⟨.emit,"",["prediction"]⟩]
def predictionProgram (experimentId label : String) : Program :=
  ⟨SFT.Host.Text.append experimentId "-prediction",predictionSteps label⟩
def isInput : Opcode → Bool
 | .input => true
 | .emptyOne | .label | .count | .ratio | .word | .pair | .table | .lookup | .junction | .product | .quotient | .same | .assertSame | .emit => false
theorem onlyRegisteredInput (label : String) :
    ((predictionSteps label).filter (fun i => isInput i.opcode)).map Instruction.arguments =
      [["registered-premise"]] := rfl
theorem oneTerminalEmission (label : String) :
    ((predictionSteps label).filter (fun i => isEmit i.opcode)).length = 1 ∧
    terminal (predictionSteps label) = true := ⟨rfl,rfl⟩
theorem emittedRegister (label : String) :
    ((predictionSteps label).filter (fun i => isEmit i.opcode)).map Instruction.arguments =
      [["prediction"]] := rfl
theorem traceHasFourRows (experimentId label : String) (inputs : List (String × CapabilityValues.Value))
    (result : State) (completed : run inputs initial 0 (predictionProgram experimentId label).instructions = .ok result) :
    result.trace.length = 4 := by
  have h := runTraceLength inputs (predictionProgram experimentId label).instructions initial result 0 completed
  exact h
end SFT.Physics.ObservationPrediction

