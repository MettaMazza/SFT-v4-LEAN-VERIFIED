import SFT.Physics.CosmoCompleteBudgetGrammarBase
namespace SFT.Physics.CosmoCompleteBudgetGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem decisionCensus19 (composition : Composition) (closure : Closure) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,composition,closure,target,provenance,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,composition,closure,target,provenance,extension⟩ := by
 cases composition <;> cases closure <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus19 (composition : Composition) (closure : Closure) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,composition,closure,target,provenance,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,composition,closure,target,provenance,extension⟩ : Candidate) = survivor := by
 cases composition <;> cases closure <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CosmoCompleteBudgetGrammar
