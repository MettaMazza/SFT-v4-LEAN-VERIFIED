import SFT.Physics.GeneratorThreeGrammarBase
namespace SFT.Physics.GeneratorThreeGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus7 (successor : Successor) (unit : Unit) (orbit : Orbit) (order : Order) (measurement : Measurement) (extension : Extension) :
    survives ⟨.rejected,.admitted,.admitted,.admitted,successor,unit,orbit,order,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,successor,unit,orbit,order,measurement,extension⟩ := by
  cases successor <;> cases unit <;> cases orbit <;> cases order <;> cases measurement <;> cases extension
  all_goals rfl
end SFT.Physics.GeneratorThreeGrammar
