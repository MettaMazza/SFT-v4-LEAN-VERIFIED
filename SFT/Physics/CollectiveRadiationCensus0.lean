import SFT.Physics.CollectiveRadiationGrammarBase
namespace SFT.Physics.CollectiveRadiationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk0 (threshold : Threshold) (linewidth : Linewidth) (plasma : Plasma) (magnetofluid : Magnetofluid) : survives ⟨.rejected,.rejected,.rejected,.rejected,threshold,linewidth,plasma,magnetofluid⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,threshold,linewidth,plasma,magnetofluid⟩ := by
 cases threshold <;> cases linewidth <;> cases plasma <;> cases magnetofluid <;> rfl
theorem uniqueCriteriaChunk0 (threshold : Threshold) (linewidth : Linewidth) (plasma : Plasma) (magnetofluid : Magnetofluid) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,threshold,linewidth,plasma,magnetofluid⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,threshold,linewidth,plasma,magnetofluid⟩ : Candidate) = survivor := by
 cases threshold <;> cases linewidth <;> cases plasma <;> cases magnetofluid
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CollectiveRadiationGrammar
