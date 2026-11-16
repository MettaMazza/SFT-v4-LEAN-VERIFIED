import SFT.Physics.ThermalEquilibriumResponseGrammarBase
namespace SFT.Physics.ThermalEquilibriumResponseGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk12 (maximum : Maximum) (fluctuation : Fluctuation) (response : Response) (noise : Noise) : survives ⟨.admitted,.admitted,.rejected,.rejected,maximum,fluctuation,response,noise⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,maximum,fluctuation,response,noise⟩ := by
 cases maximum <;> cases fluctuation <;> cases response <;> cases noise <;> rfl
theorem uniqueCriteriaChunk12 (maximum : Maximum) (fluctuation : Fluctuation) (response : Response) (noise : Noise) : criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,maximum,fluctuation,response,noise⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.rejected,maximum,fluctuation,response,noise⟩ : Candidate) = survivor := by
 cases maximum <;> cases fluctuation <;> cases response <;> cases noise
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ThermalEquilibriumResponseGrammar
