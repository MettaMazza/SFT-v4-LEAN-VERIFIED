import SFT.Physics.CosmoSpatialFlatnessGrammarBase
namespace SFT.Physics.CosmoSpatialFlatnessGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem decisionCensus61 (refinement : Refinement) (scope : Scope) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,refinement,scope,target,provenance,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,refinement,scope,target,provenance,extension⟩ := by
 cases refinement <;> cases scope <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus61 (refinement : Refinement) (scope : Scope) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,refinement,scope,target,provenance,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,refinement,scope,target,provenance,extension⟩ : Candidate) = survivor := by
 cases refinement <;> cases scope <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CosmoSpatialFlatnessGrammar
