import SFT.Physics.CollectiveRadiationGrammarBase
namespace SFT.Physics.CollectiveRadiationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk7 (threshold : Threshold) (linewidth : Linewidth) (plasma : Plasma) (magnetofluid : Magnetofluid) : survives ⟨.rejected,.admitted,.admitted,.admitted,threshold,linewidth,plasma,magnetofluid⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,threshold,linewidth,plasma,magnetofluid⟩ := by
 cases threshold <;> cases linewidth <;> cases plasma <;> cases magnetofluid <;> rfl
theorem uniqueCriteriaChunk7 (threshold : Threshold) (linewidth : Linewidth) (plasma : Plasma) (magnetofluid : Magnetofluid) : criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,threshold,linewidth,plasma,magnetofluid⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.admitted,threshold,linewidth,plasma,magnetofluid⟩ : Candidate) = survivor := by
 cases threshold <;> cases linewidth <;> cases plasma <;> cases magnetofluid
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CollectiveRadiationGrammar
