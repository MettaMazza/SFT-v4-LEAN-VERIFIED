import SFT.Physics.CollectiveRadiationGrammarBase
namespace SFT.Physics.CollectiveRadiationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk14 (threshold : Threshold) (linewidth : Linewidth) (plasma : Plasma) (magnetofluid : Magnetofluid) : survives ⟨.admitted,.admitted,.admitted,.rejected,threshold,linewidth,plasma,magnetofluid⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,threshold,linewidth,plasma,magnetofluid⟩ := by
 cases threshold <;> cases linewidth <;> cases plasma <;> cases magnetofluid <;> rfl
theorem uniqueCriteriaChunk14 (threshold : Threshold) (linewidth : Linewidth) (plasma : Plasma) (magnetofluid : Magnetofluid) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,threshold,linewidth,plasma,magnetofluid⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,threshold,linewidth,plasma,magnetofluid⟩ : Candidate) = survivor := by
 cases threshold <;> cases linewidth <;> cases plasma <;> cases magnetofluid
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CollectiveRadiationGrammar
