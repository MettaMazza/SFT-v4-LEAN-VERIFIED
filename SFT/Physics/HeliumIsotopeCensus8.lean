import SFT.Physics.HeliumIsotopeGrammarBase
namespace SFT.Physics.HeliumIsotopeGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk8 (identity : Identity) (conversion : Conversion) (partition : Partition) (target : Target) : survives ⟨.admitted,.rejected,.rejected,.rejected,identity,conversion,partition,target⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,identity,conversion,partition,target⟩ := by
 cases identity <;> cases conversion <;> cases partition <;> cases target <;> rfl
theorem uniqueCriteriaChunk8 (identity : Identity) (conversion : Conversion) (partition : Partition) (target : Target) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,identity,conversion,partition,target⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,identity,conversion,partition,target⟩ : Candidate) = survivor := by
 cases identity <;> cases conversion <;> cases partition <;> cases target
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.HeliumIsotopeGrammar
