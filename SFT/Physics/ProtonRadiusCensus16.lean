import SFT.Physics.ProtonRadiusGrammarBase
namespace SFT.Physics.ProtonRadiusGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk16 (transport : Transport) (orientation : Orientation) (scale : Scale) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected1,transport,orientation,scale,target,provenance,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected1,transport,orientation,scale,target,provenance,extension⟩ := by
 cases transport <;> cases orientation <;> cases scale <;> cases target <;> cases provenance <;> cases extension <;> rfl
theorem uniqueCriteriaChunk16 (transport : Transport) (orientation : Orientation) (scale : Scale) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected1,transport,orientation,scale,target,provenance,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected1,transport,orientation,scale,target,provenance,extension⟩ : Candidate) = survivor := by
 cases transport <;> cases orientation <;> cases scale <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ProtonRadiusGrammar
