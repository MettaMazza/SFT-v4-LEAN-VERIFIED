import SFT.Physics.GeneratorThreeCensus12Part0
import SFT.Physics.GeneratorThreeCensus12Part1
import SFT.Physics.GeneratorThreeCensus12Part2
import SFT.Physics.GeneratorThreeCensus12Part3
namespace SFT.Physics.GeneratorThreeGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus12 (successor : Successor) (unit : Unit) (orbit : Orbit) (order : Order) (measurement : Measurement) (extension : Extension) :
    survives ⟨.admitted,.admitted,.rejected,.rejected,successor,unit,orbit,order,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,successor,unit,orbit,order,measurement,extension⟩ := by
  cases successor with
  | rejected =>
    cases unit with
    | rejected => exact decisionCensus12Part0 orbit order measurement extension
    | admitted => exact decisionCensus12Part1 orbit order measurement extension
  | admitted =>
    cases unit with
    | rejected => exact decisionCensus12Part2 orbit order measurement extension
    | admitted => exact decisionCensus12Part3 orbit order measurement extension
end SFT.Physics.GeneratorThreeGrammar
