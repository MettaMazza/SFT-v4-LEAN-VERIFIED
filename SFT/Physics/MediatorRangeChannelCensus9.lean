import SFT.Physics.MediatorRangeChannelGrammarBase
namespace SFT.Physics.MediatorRangeChannelGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk9 (conservation : Conservation) (range : Range) (ordering : Ordering) (massless : Massless) (comparison : Comparison) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,conservation,range,ordering,massless,comparison,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,conservation,range,ordering,massless,comparison,extension⟩ := by
 cases conservation <;> cases range <;> cases ordering <;> cases massless <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk9 (conservation : Conservation) (range : Range) (ordering : Ordering) (massless : Massless) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,conservation,range,ordering,massless,comparison,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,conservation,range,ordering,massless,comparison,extension⟩ : Candidate) = survivor := by
 cases conservation <;> cases range <;> cases ordering <;> cases massless <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.MediatorRangeChannelGrammar
