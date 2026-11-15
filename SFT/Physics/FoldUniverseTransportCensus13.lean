import SFT.Physics.FoldUniverseTransportGrammarBase
namespace SFT.Physics.FoldUniverseTransportGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk13 (period : Period) (correlation : Correlation) (signal : Signal) (travel : Travel) (physical : Physical) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.admitted,period,correlation,signal,travel,physical,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,period,correlation,signal,travel,physical,extension⟩ := by
 cases period <;> cases correlation <;> cases signal <;> cases travel <;> cases physical <;> cases extension <;> rfl
theorem uniqueCriteriaChunk13 (period : Period) (correlation : Correlation) (signal : Signal) (travel : Travel) (physical : Physical) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,period,correlation,signal,travel,physical,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,period,correlation,signal,travel,physical,extension⟩ : Candidate) = survivor := by
 cases period <;> cases correlation <;> cases signal <;> cases travel <;> cases physical <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.FoldUniverseTransportGrammar
