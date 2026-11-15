import SFT.Physics.AccumulatedSeparationGrammarBase
namespace SFT.Physics.AccumulatedSeparationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk14 (envelope : Envelope) (boundary : Boundary) (tolerance : Tolerance) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,envelope,boundary,tolerance,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,envelope,boundary,tolerance,extension⟩ := by
 cases envelope <;> cases boundary <;> cases tolerance <;> cases extension <;> rfl
theorem uniqueCriteriaChunk14 (envelope : Envelope) (boundary : Boundary) (tolerance : Tolerance) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,envelope,boundary,tolerance,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,envelope,boundary,tolerance,extension⟩ : Candidate) = survivor := by
 cases envelope <;> cases boundary <;> cases tolerance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.AccumulatedSeparationGrammar
