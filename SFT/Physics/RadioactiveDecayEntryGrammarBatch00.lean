import SFT.Physics.RadioactiveDecayEntryGrammarData
namespace SFT.Physics.RadioactiveDecayEntryGrammarBatch00
open RadioactiveDecayEntryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatches (gamma : Gamma) (composition : Composition) (survival : Survival) (determinism : Determinism) (target : Target) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.rejected,gamma,composition,survival,determinism,target,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,gamma,composition,survival,determinism,target,extension⟩ := by
 cases gamma <;> cases composition <;> cases survival <;> cases determinism <;> cases target <;> cases extension
 all_goals rfl
theorem uniqueCriteria (gamma : Gamma) (composition : Composition) (survival : Survival) (determinism : Determinism) (target : Target) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,gamma,composition,survival,determinism,target,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,gamma,composition,survival,determinism,target,extension⟩ : Candidate) = survivor := by
 cases gamma <;> cases composition <;> cases survival <;> cases determinism <;> cases target <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.RadioactiveDecayEntryGrammarBatch00
