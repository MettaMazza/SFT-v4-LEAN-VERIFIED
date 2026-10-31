import SFT.Physics.CosmicComponentTransportGrammarBase
namespace SFT.Physics.CosmicComponentTransportGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem decisionCensus8 (acceleration : Acceleration) (orientation : Orientation) (scale : Scale) (target : Target) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,acceleration,orientation,scale,target,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,acceleration,orientation,scale,target,extension⟩ := by
 cases acceleration <;> cases orientation <;> cases scale <;> cases target <;> cases extension
 all_goals rfl
theorem uniqueCensus8 (acceleration : Acceleration) (orientation : Orientation) (scale : Scale) (target : Target) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,acceleration,orientation,scale,target,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,acceleration,orientation,scale,target,extension⟩ : Candidate) = survivor := by
 cases acceleration <;> cases orientation <;> cases scale <;> cases target <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CosmicComponentTransportGrammar
