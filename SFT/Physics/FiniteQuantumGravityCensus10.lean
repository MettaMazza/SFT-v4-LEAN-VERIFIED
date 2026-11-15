import SFT.Physics.FiniteQuantumGravityGrammarBase
namespace SFT.Physics.FiniteQuantumGravityGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk10 (propagation : Propagation) (quantum : Quantum) (loops : Loops) (horizon : Horizon) (comparison : Comparison) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,propagation,quantum,loops,horizon,comparison,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,propagation,quantum,loops,horizon,comparison,extension⟩ := by
 cases propagation <;> cases quantum <;> cases loops <;> cases horizon <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk10 (propagation : Propagation) (quantum : Quantum) (loops : Loops) (horizon : Horizon) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,propagation,quantum,loops,horizon,comparison,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,propagation,quantum,loops,horizon,comparison,extension⟩ : Candidate) = survivor := by
 cases propagation <;> cases quantum <;> cases loops <;> cases horizon <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.FiniteQuantumGravityGrammar
