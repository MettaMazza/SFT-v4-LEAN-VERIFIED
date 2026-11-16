import SFT.Physics.ParticleModeGrammarBase
namespace SFT.Physics.ParticleModeGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk7 (mass : Mass) (dual : Dual) (reach : Reach) (transition : Transition) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.admitted,mass,dual,reach,transition,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.admitted,mass,dual,reach,transition,extension⟩ := by
 cases mass <;> cases dual <;> cases reach <;> cases transition <;> cases extension <;> rfl
theorem uniqueCriteriaChunk7 (mass : Mass) (dual : Dual) (reach : Reach) (transition : Transition) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.admitted,mass,dual,reach,transition,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.admitted,mass,dual,reach,transition,extension⟩ : Candidate) = survivor := by
 cases mass <;> cases dual <;> cases reach <;> cases transition <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ParticleModeGrammar
