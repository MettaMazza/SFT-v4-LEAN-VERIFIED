import SFT.Physics.GeneratorThreeCensus13Part0
import SFT.Physics.GeneratorThreeCensus13Part1
import SFT.Physics.GeneratorThreeCensus13Part2
import SFT.Physics.GeneratorThreeCensus13Part3
namespace SFT.Physics.GeneratorThreeGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus13 (successor : Successor) (unit : Unit) (orbit : Orbit) (order : Order) (measurement : Measurement) (extension : Extension) :
    survives ⟨.admitted,.admitted,.rejected,.admitted,successor,unit,orbit,order,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,successor,unit,orbit,order,measurement,extension⟩ := by
  cases successor with
  | rejected =>
    cases unit with
    | rejected => exact decisionCensus13Part0 orbit order measurement extension
    | admitted => exact decisionCensus13Part1 orbit order measurement extension
  | admitted =>
    cases unit with
    | rejected => exact decisionCensus13Part2 orbit order measurement extension
    | admitted => exact decisionCensus13Part3 orbit order measurement extension
end SFT.Physics.GeneratorThreeGrammar
