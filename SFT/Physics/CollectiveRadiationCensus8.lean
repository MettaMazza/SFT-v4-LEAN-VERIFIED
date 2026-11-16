import SFT.Physics.CollectiveRadiationGrammarBase
namespace SFT.Physics.CollectiveRadiationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk8 (threshold : Threshold) (linewidth : Linewidth) (plasma : Plasma) (magnetofluid : Magnetofluid) : survives ⟨.admitted,.rejected,.rejected,.rejected,threshold,linewidth,plasma,magnetofluid⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,threshold,linewidth,plasma,magnetofluid⟩ := by
 cases threshold <;> cases linewidth <;> cases plasma <;> cases magnetofluid <;> rfl
theorem uniqueCriteriaChunk8 (threshold : Threshold) (linewidth : Linewidth) (plasma : Plasma) (magnetofluid : Magnetofluid) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,threshold,linewidth,plasma,magnetofluid⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,threshold,linewidth,plasma,magnetofluid⟩ : Candidate) = survivor := by
 cases threshold <;> cases linewidth <;> cases plasma <;> cases magnetofluid
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CollectiveRadiationGrammar
