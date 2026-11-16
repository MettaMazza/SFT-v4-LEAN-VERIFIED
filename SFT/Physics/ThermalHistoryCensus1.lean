import SFT.Physics.ThermalHistoryGrammarBase
namespace SFT.Physics.ThermalHistoryGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk1 (decay : Decay) (capture : Capture) (recombination : Recombination) (acoustic : Acoustic) : survives ⟨.rejected,.rejected,.rejected,.admitted,decay,capture,recombination,acoustic⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,decay,capture,recombination,acoustic⟩ := by
 cases decay <;> cases capture <;> cases recombination <;> cases acoustic <;> rfl
theorem uniqueCriteriaChunk1 (decay : Decay) (capture : Capture) (recombination : Recombination) (acoustic : Acoustic) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,decay,capture,recombination,acoustic⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,decay,capture,recombination,acoustic⟩ : Candidate) = survivor := by
 cases decay <;> cases capture <;> cases recombination <;> cases acoustic
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ThermalHistoryGrammar
