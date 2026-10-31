import SFT.Physics.GeneratorThreeFinalCase0
import SFT.Physics.GeneratorThreeFinalCase1
import SFT.Physics.GeneratorThreeFinalCase2
import SFT.Physics.GeneratorThreeFinalCase3
import SFT.Physics.GeneratorThreeFinalCase4
import SFT.Physics.GeneratorThreeFinalCase5
import SFT.Physics.GeneratorThreeFinalCase6
import SFT.Physics.GeneratorThreeFinalCase7
import SFT.Physics.GeneratorThreeFinalCase8
import SFT.Physics.GeneratorThreeFinalCase9
import SFT.Physics.GeneratorThreeFinalCase10
import SFT.Physics.GeneratorThreeFinalCase11
import SFT.Physics.GeneratorThreeFinalCase12
import SFT.Physics.GeneratorThreeFinalCase13
import SFT.Physics.GeneratorThreeFinalCase14
import SFT.Physics.GeneratorThreeFinalCase15
namespace SFT.Physics.GeneratorThreeGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus15Part3 (orbit : Orbit) (order : Order) (measurement : Measurement) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,orbit,order,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,orbit,order,measurement,extension⟩ := by
  cases orbit with
  | rejected =>
    cases order with
    | rejected =>
      cases measurement with
      | rejected =>
        cases extension with
        | rejected =>
          exact decisionFinalCase0
        | admitted =>
          exact decisionFinalCase1
      | admitted =>
        cases extension with
        | rejected =>
          exact decisionFinalCase2
        | admitted =>
          exact decisionFinalCase3
    | admitted =>
      cases measurement with
      | rejected =>
        cases extension with
        | rejected =>
          exact decisionFinalCase4
        | admitted =>
          exact decisionFinalCase5
      | admitted =>
        cases extension with
        | rejected =>
          exact decisionFinalCase6
        | admitted =>
          exact decisionFinalCase7
  | admitted =>
    cases order with
    | rejected =>
      cases measurement with
      | rejected =>
        cases extension with
        | rejected =>
          exact decisionFinalCase8
        | admitted =>
          exact decisionFinalCase9
      | admitted =>
        cases extension with
        | rejected =>
          exact decisionFinalCase10
        | admitted =>
          exact decisionFinalCase11
    | admitted =>
      cases measurement with
      | rejected =>
        cases extension with
        | rejected =>
          exact decisionFinalCase12
        | admitted =>
          exact decisionFinalCase13
      | admitted =>
        cases extension with
        | rejected =>
          exact decisionFinalCase14
        | admitted =>
          exact decisionFinalCase15
end SFT.Physics.GeneratorThreeGrammar
