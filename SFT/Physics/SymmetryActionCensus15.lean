import SFT.Physics.SymmetryActionGrammarBase
namespace SFT.Physics.SymmetryActionGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk15 (conserved : Conserved) (converse : Converse) (action : Action) (path : Path) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,conserved,converse,action,path,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,conserved,converse,action,path,extension⟩ := by
 cases conserved <;> cases converse <;> cases action <;> cases path <;> cases extension <;> rfl
theorem uniqueCriteriaChunk15 (conserved : Conserved) (converse : Converse) (action : Action) (path : Path) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,conserved,converse,action,path,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,conserved,converse,action,path,extension⟩ : Candidate) = survivor := by
 cases conserved <;> cases converse <;> cases action <;> cases path <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.SymmetryActionGrammar
