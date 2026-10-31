import SFT.Physics.BoundaryMeasurementGrammarBase
namespace SFT.Physics.BoundaryMeasurementGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus5 (stopping : Stopping) (target : Target) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,stopping,target,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,stopping,target,record,extension⟩ := by
 cases stopping <;> cases target <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus5 (stopping : Stopping) (target : Target) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,stopping,target,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,stopping,target,record,extension⟩ : Candidate) = survivor := by
 cases stopping <;> cases target <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.BoundaryMeasurementGrammar
