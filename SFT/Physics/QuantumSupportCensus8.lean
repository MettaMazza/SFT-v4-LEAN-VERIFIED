import SFT.Physics.QuantumSupportGrammarBase
namespace SFT.Physics.QuantumSupportGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk8 (joint : Joint) (projection : Projection) (bell : Bell) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.rejected,joint,projection,bell,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,joint,projection,bell,extension⟩ := by
 cases joint <;> cases projection <;> cases bell <;> cases extension <;> rfl
theorem uniqueCriteriaChunk8 (joint : Joint) (projection : Projection) (bell : Bell) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,joint,projection,bell,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,joint,projection,bell,extension⟩ : Candidate) = survivor := by
 cases joint <;> cases projection <;> cases bell <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.QuantumSupportGrammar
