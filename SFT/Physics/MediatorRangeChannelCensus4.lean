import SFT.Physics.MediatorRangeChannelGrammarBase
namespace SFT.Physics.MediatorRangeChannelGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk4 (conservation : Conservation) (range : Range) (ordering : Ordering) (massless : Massless) (comparison : Comparison) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.rejected,conservation,range,ordering,massless,comparison,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,conservation,range,ordering,massless,comparison,extension⟩ := by
 cases conservation <;> cases range <;> cases ordering <;> cases massless <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk4 (conservation : Conservation) (range : Range) (ordering : Ordering) (massless : Massless) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,conservation,range,ordering,massless,comparison,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.rejected,conservation,range,ordering,massless,comparison,extension⟩ : Candidate) = survivor := by
 cases conservation <;> cases range <;> cases ordering <;> cases massless <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.MediatorRangeChannelGrammar
