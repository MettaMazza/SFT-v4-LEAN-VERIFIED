import SFT.Physics.InflationGrowthGrammarBase
namespace SFT.Physics.InflationGrowthGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk3 (tensor : Tensor) (exit : Exit) (growth : Growth) (transfer : Transfer) : survives ⟨.rejected,.rejected,.admitted,.admitted,tensor,exit,growth,transfer⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,tensor,exit,growth,transfer⟩ := by
 cases tensor <;> cases exit <;> cases growth <;> cases transfer <;> rfl
theorem uniqueCriteriaChunk3 (tensor : Tensor) (exit : Exit) (growth : Growth) (transfer : Transfer) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,tensor,exit,growth,transfer⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,tensor,exit,growth,transfer⟩ : Candidate) = survivor := by
 cases tensor <;> cases exit <;> cases growth <;> cases transfer
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.InflationGrowthGrammar
