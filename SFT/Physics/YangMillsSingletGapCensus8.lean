import SFT.Physics.YangMillsSingletGapGrammarBase
namespace SFT.Physics.YangMillsSingletGapGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk8 (confinement : Confinement) (carrier : Carrier) (orbit : Orbit) (depth : Depth) (prior : Prior) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.rejected,confinement,carrier,orbit,depth,prior,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,confinement,carrier,orbit,depth,prior,extension⟩ := by
 cases confinement <;> cases carrier <;> cases orbit <;> cases depth <;> cases prior <;> cases extension <;> rfl
theorem uniqueCriteriaChunk8 (confinement : Confinement) (carrier : Carrier) (orbit : Orbit) (depth : Depth) (prior : Prior) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,confinement,carrier,orbit,depth,prior,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,confinement,carrier,orbit,depth,prior,extension⟩ : Candidate) = survivor := by
 cases confinement <;> cases carrier <;> cases orbit <;> cases depth <;> cases prior <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.YangMillsSingletGapGrammar
