import SFT.Physics.ParkerProtonEnergyGrammarBase
namespace SFT.Physics.ParkerProtonEnergyGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk39 (composition : Composition) (scale : Scale) (target : Target) (provenance : Provenance) (comparison : Comparison) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected0,composition,scale,target,provenance,comparison,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected0,composition,scale,target,provenance,comparison,extension⟩ := by
 cases composition <;> cases scale <;> cases target <;> cases provenance <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk39 (composition : Composition) (scale : Scale) (target : Target) (provenance : Provenance) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected0,composition,scale,target,provenance,comparison,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected0,composition,scale,target,provenance,comparison,extension⟩ : Candidate) = survivor := by
 cases composition <;> cases scale <;> cases target <;> cases provenance <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ParkerProtonEnergyGrammar
