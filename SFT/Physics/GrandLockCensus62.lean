import SFT.Physics.GrandLockGrammarBase
namespace SFT.Physics.GrandLockGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk62 (perturbation : Perturbation) (invariants : Invariants) (identity : Identity) (empirical : Empirical) (extension : Extension) (rule : Rule) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,perturbation,invariants,identity,empirical,extension,rule⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,perturbation,invariants,identity,empirical,extension,rule⟩ := by
 cases perturbation <;> cases invariants <;> cases identity <;> cases empirical <;> cases extension <;> cases rule <;> rfl
theorem uniqueCriteriaChunk62 (perturbation : Perturbation) (invariants : Invariants) (identity : Identity) (empirical : Empirical) (extension : Extension) (rule : Rule) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,perturbation,invariants,identity,empirical,extension,rule⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,perturbation,invariants,identity,empirical,extension,rule⟩ : Candidate) = survivor := by
 cases perturbation <;> cases invariants <;> cases identity <;> cases empirical <;> cases extension <;> cases rule
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.GrandLockGrammar
