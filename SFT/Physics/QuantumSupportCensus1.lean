import SFT.Physics.QuantumSupportGrammarBase
namespace SFT.Physics.QuantumSupportGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk1 (joint : Joint) (projection : Projection) (bell : Bell) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.admitted,joint,projection,bell,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,joint,projection,bell,extension⟩ := by
 cases joint <;> cases projection <;> cases bell <;> cases extension <;> rfl
theorem uniqueCriteriaChunk1 (joint : Joint) (projection : Projection) (bell : Bell) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,joint,projection,bell,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,joint,projection,bell,extension⟩ : Candidate) = survivor := by
 cases joint <;> cases projection <;> cases bell <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.QuantumSupportGrammar
