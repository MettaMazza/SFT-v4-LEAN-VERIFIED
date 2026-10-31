import SFT.Physics.VacuumDensityGrammarBase
namespace SFT.Physics.VacuumDensityGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus1 (typing : Typing) (transport : Transport) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,typing,transport,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,typing,transport,measurement,extension⟩ := by
 cases typing <;> cases transport <;> cases measurement <;> cases extension
 all_goals rfl
theorem uniqueCensus1 (typing : Typing) (transport : Transport) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,typing,transport,measurement,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,typing,transport,measurement,extension⟩ : Candidate) = survivor := by
 cases typing <;> cases transport <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.VacuumDensityGrammar
