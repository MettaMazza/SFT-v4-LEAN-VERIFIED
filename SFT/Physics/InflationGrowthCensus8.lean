import SFT.Physics.InflationGrowthGrammarBase
namespace SFT.Physics.InflationGrowthGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk8 (tensor : Tensor) (exit : Exit) (growth : Growth) (transfer : Transfer) : survives ⟨.admitted,.rejected,.rejected,.rejected,tensor,exit,growth,transfer⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,tensor,exit,growth,transfer⟩ := by
 cases tensor <;> cases exit <;> cases growth <;> cases transfer <;> rfl
theorem uniqueCriteriaChunk8 (tensor : Tensor) (exit : Exit) (growth : Growth) (transfer : Transfer) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,tensor,exit,growth,transfer⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,tensor,exit,growth,transfer⟩ : Candidate) = survivor := by
 cases tensor <;> cases exit <;> cases growth <;> cases transfer
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.InflationGrowthGrammar
