import SFT.Physics.CosmicComponentTransportGrammarBase
namespace SFT.Physics.CosmicComponentTransportGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem decisionCensus118 (acceleration : Acceleration) (orientation : Orientation) (scale : Scale) (target : Target) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,acceleration,orientation,scale,target,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,acceleration,orientation,scale,target,extension⟩ := by
 cases acceleration <;> cases orientation <;> cases scale <;> cases target <;> cases extension
 all_goals rfl
theorem uniqueCensus118 (acceleration : Acceleration) (orientation : Orientation) (scale : Scale) (target : Target) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,acceleration,orientation,scale,target,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,acceleration,orientation,scale,target,extension⟩ : Candidate) = survivor := by
 cases acceleration <;> cases orientation <;> cases scale <;> cases target <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CosmicComponentTransportGrammar
