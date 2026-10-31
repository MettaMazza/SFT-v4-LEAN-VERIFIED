import SFT.Physics.CosmoCompleteBudgetGrammarBase
namespace SFT.Physics.CosmoCompleteBudgetGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem decisionCensus63 (composition : Composition) (closure : Closure) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,composition,closure,target,provenance,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,composition,closure,target,provenance,extension⟩ := by
 cases composition <;> cases closure <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus63 (composition : Composition) (closure : Closure) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,composition,closure,target,provenance,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,composition,closure,target,provenance,extension⟩ : Candidate) = survivor := by
 cases composition <;> cases closure <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CosmoCompleteBudgetGrammar
