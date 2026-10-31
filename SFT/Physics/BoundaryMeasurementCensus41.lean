import SFT.Physics.BoundaryMeasurementGrammarBase
namespace SFT.Physics.BoundaryMeasurementGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus41 (stopping : Stopping) (target : Target) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,stopping,target,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,stopping,target,record,extension⟩ := by
 cases stopping <;> cases target <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus41 (stopping : Stopping) (target : Target) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,stopping,target,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,stopping,target,record,extension⟩ : Candidate) = survivor := by
 cases stopping <;> cases target <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.BoundaryMeasurementGrammar
