import SFT.Physics.LatticeOperatorGrammarBase
namespace SFT.Physics.LatticeOperatorGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk2 (source : Source) (causality : Causality) (modes : Modes) (induction : Induction) (comparison : Comparison) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,source,causality,modes,induction,comparison,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,source,causality,modes,induction,comparison,extension⟩ := by
 cases source <;> cases causality <;> cases modes <;> cases induction <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk2 (source : Source) (causality : Causality) (modes : Modes) (induction : Induction) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,source,causality,modes,induction,comparison,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,source,causality,modes,induction,comparison,extension⟩ : Candidate) = survivor := by
 cases source <;> cases causality <;> cases modes <;> cases induction <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.LatticeOperatorGrammar
