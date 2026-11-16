import SFT.Physics.HeliumIsotopeGrammarBase
namespace SFT.Physics.HeliumIsotopeGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk13 (identity : Identity) (conversion : Conversion) (partition : Partition) (target : Target) : survives ⟨.admitted,.admitted,.rejected,.admitted,identity,conversion,partition,target⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,identity,conversion,partition,target⟩ := by
 cases identity <;> cases conversion <;> cases partition <;> cases target <;> rfl
theorem uniqueCriteriaChunk13 (identity : Identity) (conversion : Conversion) (partition : Partition) (target : Target) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,identity,conversion,partition,target⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,identity,conversion,partition,target⟩ : Candidate) = survivor := by
 cases identity <;> cases conversion <;> cases partition <;> cases target
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.HeliumIsotopeGrammar
