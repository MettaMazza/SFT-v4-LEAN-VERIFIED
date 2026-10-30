import SFT.Physics.VacuumOddGrammarBase
namespace SFT.Physics.VacuumOddGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus12 (minimality : Minimality) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.rejected,minimality,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,minimality,measurement,record,extension⟩ := by
 cases minimality <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus12 (minimality : Minimality) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,minimality,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.rejected,minimality,measurement,record,extension⟩ : Candidate) = survivor := by
 cases minimality <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.VacuumOddGrammar
