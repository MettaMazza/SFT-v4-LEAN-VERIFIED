import SFT.Physics.YangMillsSingletGapGrammarBase
namespace SFT.Physics.YangMillsSingletGapGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk0 (confinement : Confinement) (carrier : Carrier) (orbit : Orbit) (depth : Depth) (prior : Prior) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.rejected,confinement,carrier,orbit,depth,prior,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,confinement,carrier,orbit,depth,prior,extension⟩ := by
 cases confinement <;> cases carrier <;> cases orbit <;> cases depth <;> cases prior <;> cases extension <;> rfl
theorem uniqueCriteriaChunk0 (confinement : Confinement) (carrier : Carrier) (orbit : Orbit) (depth : Depth) (prior : Prior) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,confinement,carrier,orbit,depth,prior,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,confinement,carrier,orbit,depth,prior,extension⟩ : Candidate) = survivor := by
 cases confinement <;> cases carrier <;> cases orbit <;> cases depth <;> cases prior <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.YangMillsSingletGapGrammar
