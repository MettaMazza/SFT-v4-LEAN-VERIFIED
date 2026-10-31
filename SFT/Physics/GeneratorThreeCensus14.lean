import SFT.Physics.GeneratorThreeCensus14Part0
import SFT.Physics.GeneratorThreeCensus14Part1
import SFT.Physics.GeneratorThreeCensus14Part2
import SFT.Physics.GeneratorThreeCensus14Part3
namespace SFT.Physics.GeneratorThreeGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus14 (successor : Successor) (unit : Unit) (orbit : Orbit) (order : Order) (measurement : Measurement) (extension : Extension) :
    survives ⟨.admitted,.admitted,.admitted,.rejected,successor,unit,orbit,order,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,successor,unit,orbit,order,measurement,extension⟩ := by
  cases successor with
  | rejected =>
    cases unit with
    | rejected => exact decisionCensus14Part0 orbit order measurement extension
    | admitted => exact decisionCensus14Part1 orbit order measurement extension
  | admitted =>
    cases unit with
    | rejected => exact decisionCensus14Part2 orbit order measurement extension
    | admitted => exact decisionCensus14Part3 orbit order measurement extension
end SFT.Physics.GeneratorThreeGrammar
