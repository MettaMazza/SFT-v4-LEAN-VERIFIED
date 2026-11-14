import SFT.Physics.RadioactiveDecayEntryGrammarData
namespace SFT.Physics.RadioactiveDecayEntryGrammarBatch09
open RadioactiveDecayEntryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatches (gamma : Gamma) (composition : Composition) (survival : Survival) (determinism : Determinism) (target : Target) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,gamma,composition,survival,determinism,target,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,gamma,composition,survival,determinism,target,extension⟩ := by
 cases gamma <;> cases composition <;> cases survival <;> cases determinism <;> cases target <;> cases extension
 all_goals rfl
theorem uniqueCriteria (gamma : Gamma) (composition : Composition) (survival : Survival) (determinism : Determinism) (target : Target) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,gamma,composition,survival,determinism,target,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,gamma,composition,survival,determinism,target,extension⟩ : Candidate) = survivor := by
 cases gamma <;> cases composition <;> cases survival <;> cases determinism <;> cases target <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.RadioactiveDecayEntryGrammarBatch09
