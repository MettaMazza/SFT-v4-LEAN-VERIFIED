import SFT.Physics.CosmoSpatialFlatnessGrammarBase
namespace SFT.Physics.CosmoSpatialFlatnessGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus2 (refinement : Refinement) (scope : Scope) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,refinement,scope,target,provenance,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,refinement,scope,target,provenance,extension⟩ := by
 cases refinement <;> cases scope <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus2 (refinement : Refinement) (scope : Scope) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,refinement,scope,target,provenance,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,refinement,scope,target,provenance,extension⟩ : Candidate) = survivor := by
 cases refinement <;> cases scope <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CosmoSpatialFlatnessGrammar
