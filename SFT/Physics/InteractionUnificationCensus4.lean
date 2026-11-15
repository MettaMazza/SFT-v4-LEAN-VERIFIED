import SFT.Physics.InteractionUnificationGrammarBase
namespace SFT.Physics.InteractionUnificationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk4 (support : Support) (order : Order) (coincidence : Coincidence) (period : Period) (comparison : Comparison) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.rejected,support,order,coincidence,period,comparison,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,support,order,coincidence,period,comparison,extension⟩ := by
 cases support <;> cases order <;> cases coincidence <;> cases period <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk4 (support : Support) (order : Order) (coincidence : Coincidence) (period : Period) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,support,order,coincidence,period,comparison,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.rejected,support,order,coincidence,period,comparison,extension⟩ : Candidate) = survivor := by
 cases support <;> cases order <;> cases coincidence <;> cases period <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.InteractionUnificationGrammar
