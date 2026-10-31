import SFT.Physics.GeneratorThreeGrammarBase
namespace SFT.Physics.GeneratorThreeGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus14Part0 (orbit : Orbit) (order : Order) (measurement : Measurement) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,orbit,order,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,orbit,order,measurement,extension⟩ := by
  cases orbit <;> cases order <;> cases measurement <;> cases extension
  all_goals rfl
end SFT.Physics.GeneratorThreeGrammar
