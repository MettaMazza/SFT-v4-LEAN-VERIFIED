import SFT.Physics.GeneratorThreeCensus15Part0
import SFT.Physics.GeneratorThreeCensus15Part1
import SFT.Physics.GeneratorThreeCensus15Part2
import SFT.Physics.GeneratorThreeCensus15Part3
namespace SFT.Physics.GeneratorThreeGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus15 (successor : Successor) (unit : Unit) (orbit : Orbit) (order : Order) (measurement : Measurement) (extension : Extension) :
    survives ⟨.admitted,.admitted,.admitted,.admitted,successor,unit,orbit,order,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,successor,unit,orbit,order,measurement,extension⟩ := by
  cases successor with
  | rejected =>
    cases unit with
    | rejected => exact decisionCensus15Part0 orbit order measurement extension
    | admitted => exact decisionCensus15Part1 orbit order measurement extension
  | admitted =>
    cases unit with
    | rejected => exact decisionCensus15Part2 orbit order measurement extension
    | admitted => exact decisionCensus15Part3 orbit order measurement extension
end SFT.Physics.GeneratorThreeGrammar
