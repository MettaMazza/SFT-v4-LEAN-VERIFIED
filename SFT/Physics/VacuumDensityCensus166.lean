import SFT.Physics.VacuumDensityGrammarBase
namespace SFT.Physics.VacuumDensityGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus166 (typing : Typing) (transport : Transport) (measurement : Measurement) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,typing,transport,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,typing,transport,measurement,extension⟩ := by
 cases typing <;> cases transport <;> cases measurement <;> cases extension
 all_goals rfl
theorem uniqueCensus166 (typing : Typing) (transport : Transport) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,typing,transport,measurement,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,typing,transport,measurement,extension⟩ : Candidate) = survivor := by
 cases typing <;> cases transport <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.VacuumDensityGrammar
