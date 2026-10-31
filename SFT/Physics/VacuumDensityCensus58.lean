import SFT.Physics.VacuumDensityGrammarBase
namespace SFT.Physics.VacuumDensityGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus58 (typing : Typing) (transport : Transport) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,typing,transport,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,typing,transport,measurement,extension⟩ := by
 cases typing <;> cases transport <;> cases measurement <;> cases extension
 all_goals rfl
theorem uniqueCensus58 (typing : Typing) (transport : Transport) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,typing,transport,measurement,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,typing,transport,measurement,extension⟩ : Candidate) = survivor := by
 cases typing <;> cases transport <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.VacuumDensityGrammar
