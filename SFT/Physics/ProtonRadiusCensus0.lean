import SFT.Physics.ProtonRadiusGrammarBase
namespace SFT.Physics.ProtonRadiusGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk0 (transport : Transport) (orientation : Orientation) (scale : Scale) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.rejected0,transport,orientation,scale,target,provenance,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected0,transport,orientation,scale,target,provenance,extension⟩ := by
 cases transport <;> cases orientation <;> cases scale <;> cases target <;> cases provenance <;> cases extension <;> rfl
theorem uniqueCriteriaChunk0 (transport : Transport) (orientation : Orientation) (scale : Scale) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected0,transport,orientation,scale,target,provenance,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected0,transport,orientation,scale,target,provenance,extension⟩ : Candidate) = survivor := by
 cases transport <;> cases orientation <;> cases scale <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ProtonRadiusGrammar
