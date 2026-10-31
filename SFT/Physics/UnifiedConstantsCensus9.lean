import SFT.Physics.UnifiedConstantsGrammarBase
namespace SFT.Physics.UnifiedConstantsGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem decisionCensus9 (mutation : Mutation) (control : Control) (measurement : Measurement) (extension : Extension) (rule : Rule) : survives ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,mutation,control,measurement,extension,rule⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,mutation,control,measurement,extension,rule⟩ := by
 cases mutation <;> cases control <;> cases measurement <;> cases extension <;> cases rule
 all_goals rfl
theorem uniqueCensus9 (mutation : Mutation) (control : Control) (measurement : Measurement) (extension : Extension) (rule : Rule) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,mutation,control,measurement,extension,rule⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,mutation,control,measurement,extension,rule⟩ : Candidate) = survivor := by
 cases mutation <;> cases control <;> cases measurement <;> cases extension <;> cases rule
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.UnifiedConstantsGrammar
