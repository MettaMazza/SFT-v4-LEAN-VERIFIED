import SFT.Physics.FiniteQuantumGravityGrammarBase
namespace SFT.Physics.FiniteQuantumGravityGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk5 (propagation : Propagation) (quantum : Quantum) (loops : Loops) (horizon : Horizon) (comparison : Comparison) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,propagation,quantum,loops,horizon,comparison,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,propagation,quantum,loops,horizon,comparison,extension⟩ := by
 cases propagation <;> cases quantum <;> cases loops <;> cases horizon <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk5 (propagation : Propagation) (quantum : Quantum) (loops : Loops) (horizon : Horizon) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,propagation,quantum,loops,horizon,comparison,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,propagation,quantum,loops,horizon,comparison,extension⟩ : Candidate) = survivor := by
 cases propagation <;> cases quantum <;> cases loops <;> cases horizon <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.FiniteQuantumGravityGrammar
