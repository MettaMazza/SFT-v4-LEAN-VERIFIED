import SFT.Physics.ThermalEquilibriumResponseGrammarBase
namespace SFT.Physics.ThermalEquilibriumResponseGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk3 (maximum : Maximum) (fluctuation : Fluctuation) (response : Response) (noise : Noise) : survives ⟨.rejected,.rejected,.admitted,.admitted,maximum,fluctuation,response,noise⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,maximum,fluctuation,response,noise⟩ := by
 cases maximum <;> cases fluctuation <;> cases response <;> cases noise <;> rfl
theorem uniqueCriteriaChunk3 (maximum : Maximum) (fluctuation : Fluctuation) (response : Response) (noise : Noise) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,maximum,fluctuation,response,noise⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,maximum,fluctuation,response,noise⟩ : Candidate) = survivor := by
 cases maximum <;> cases fluctuation <;> cases response <;> cases noise
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ThermalEquilibriumResponseGrammar
