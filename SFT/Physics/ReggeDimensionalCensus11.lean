import SFT.Physics.ReggeDimensionalGrammarBase
namespace SFT.Physics.ReggeDimensionalGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk11 (base : Base) (closure : Closure) (units : Units) (target : Target) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,base,closure,units,target,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,base,closure,units,target,extension⟩ := by
 cases base <;> cases closure <;> cases units <;> cases target <;> cases extension <;> rfl
theorem uniqueCriteriaChunk11 (base : Base) (closure : Closure) (units : Units) (target : Target) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,base,closure,units,target,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,base,closure,units,target,extension⟩ : Candidate) = survivor := by
 cases base <;> cases closure <;> cases units <;> cases target <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ReggeDimensionalGrammar
