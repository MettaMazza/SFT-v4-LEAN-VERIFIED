import SFT.Physics.AccumulatedSeparationGrammarBase
namespace SFT.Physics.AccumulatedSeparationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk5 (envelope : Envelope) (boundary : Boundary) (tolerance : Tolerance) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,envelope,boundary,tolerance,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,envelope,boundary,tolerance,extension⟩ := by
 cases envelope <;> cases boundary <;> cases tolerance <;> cases extension <;> rfl
theorem uniqueCriteriaChunk5 (envelope : Envelope) (boundary : Boundary) (tolerance : Tolerance) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,envelope,boundary,tolerance,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,envelope,boundary,tolerance,extension⟩ : Candidate) = survivor := by
 cases envelope <;> cases boundary <;> cases tolerance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.AccumulatedSeparationGrammar
