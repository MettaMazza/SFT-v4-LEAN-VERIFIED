import SFT.Physics.LatticeOperatorGrammarBase
namespace SFT.Physics.LatticeOperatorGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk8 (source : Source) (causality : Causality) (modes : Modes) (induction : Induction) (comparison : Comparison) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.rejected,source,causality,modes,induction,comparison,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,source,causality,modes,induction,comparison,extension⟩ := by
 cases source <;> cases causality <;> cases modes <;> cases induction <;> cases comparison <;> cases extension <;> rfl
theorem uniqueCriteriaChunk8 (source : Source) (causality : Causality) (modes : Modes) (induction : Induction) (comparison : Comparison) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,source,causality,modes,induction,comparison,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,source,causality,modes,induction,comparison,extension⟩ : Candidate) = survivor := by
 cases source <;> cases causality <;> cases modes <;> cases induction <;> cases comparison <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.LatticeOperatorGrammar
