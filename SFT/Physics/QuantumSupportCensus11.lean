import SFT.Physics.QuantumSupportGrammarBase
namespace SFT.Physics.QuantumSupportGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk11 (joint : Joint) (projection : Projection) (bell : Bell) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,joint,projection,bell,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,joint,projection,bell,extension⟩ := by
 cases joint <;> cases projection <;> cases bell <;> cases extension <;> rfl
theorem uniqueCriteriaChunk11 (joint : Joint) (projection : Projection) (bell : Bell) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,joint,projection,bell,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,joint,projection,bell,extension⟩ : Candidate) = survivor := by
 cases joint <;> cases projection <;> cases bell <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.QuantumSupportGrammar
