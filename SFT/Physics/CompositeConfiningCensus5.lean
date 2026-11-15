import SFT.Physics.CompositeConfiningGrammarBase
namespace SFT.Physics.CompositeConfiningGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk5 (orbits : Orbits) (antipodes : Antipodes) (pair_count : Pair_count) (coupling : Coupling) (comparison : Comparison) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.admitted,orbits,antipodes,pair_count,coupling,comparison,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,orbits,antipodes,pair_count,coupling,comparison,extension⟩ := by
 cases orbits <;> cases antipodes <;> cases pair_count <;> cases coupling <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk5 (orbits : Orbits) (antipodes : Antipodes) (pair_count : Pair_count) (coupling : Coupling) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,orbits,antipodes,pair_count,coupling,comparison,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.admitted,orbits,antipodes,pair_count,coupling,comparison,extension⟩ : Candidate) = survivor := by
 cases orbits <;> cases antipodes <;> cases pair_count <;> cases coupling <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CompositeConfiningGrammar
