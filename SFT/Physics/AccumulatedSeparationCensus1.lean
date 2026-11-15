import SFT.Physics.AccumulatedSeparationGrammarBase
namespace SFT.Physics.AccumulatedSeparationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk1 (envelope : Envelope) (boundary : Boundary) (tolerance : Tolerance) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.admitted,envelope,boundary,tolerance,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,envelope,boundary,tolerance,extension⟩ := by
 cases envelope <;> cases boundary <;> cases tolerance <;> cases extension <;> rfl
theorem uniqueCriteriaChunk1 (envelope : Envelope) (boundary : Boundary) (tolerance : Tolerance) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,envelope,boundary,tolerance,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,envelope,boundary,tolerance,extension⟩ : Candidate) = survivor := by
 cases envelope <;> cases boundary <;> cases tolerance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.AccumulatedSeparationGrammar
