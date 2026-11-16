import SFT.Physics.GrandLockGrammarBase
namespace SFT.Physics.GrandLockGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk9 (perturbation : Perturbation) (invariants : Invariants) (identity : Identity) (empirical : Empirical) (extension : Extension) (rule : Rule) : survives ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,perturbation,invariants,identity,empirical,extension,rule⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,perturbation,invariants,identity,empirical,extension,rule⟩ := by
 cases perturbation <;> cases invariants <;> cases identity <;> cases empirical <;> cases extension <;> cases rule <;> rfl
theorem uniqueCriteriaChunk9 (perturbation : Perturbation) (invariants : Invariants) (identity : Identity) (empirical : Empirical) (extension : Extension) (rule : Rule) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,perturbation,invariants,identity,empirical,extension,rule⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,perturbation,invariants,identity,empirical,extension,rule⟩ : Candidate) = survivor := by
 cases perturbation <;> cases invariants <;> cases identity <;> cases empirical <;> cases extension <;> cases rule
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.GrandLockGrammar
