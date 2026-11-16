import SFT.Physics.ParticleModeGrammarBase
namespace SFT.Physics.ParticleModeGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk30 (mass : Mass) (dual : Dual) (reach : Reach) (transition : Transition) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,mass,dual,reach,transition,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,mass,dual,reach,transition,extension⟩ := by
 cases mass <;> cases dual <;> cases reach <;> cases transition <;> cases extension <;> rfl
theorem uniqueCriteriaChunk30 (mass : Mass) (dual : Dual) (reach : Reach) (transition : Transition) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,mass,dual,reach,transition,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,mass,dual,reach,transition,extension⟩ : Candidate) = survivor := by
 cases mass <;> cases dual <;> cases reach <;> cases transition <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ParticleModeGrammar
