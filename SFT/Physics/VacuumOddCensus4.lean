import SFT.Physics.VacuumOddGrammarBase
namespace SFT.Physics.VacuumOddGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus4 (minimality : Minimality) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.rejected,minimality,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,minimality,measurement,record,extension⟩ := by
 cases minimality <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus4 (minimality : Minimality) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,minimality,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.rejected,minimality,measurement,record,extension⟩ : Candidate) = survivor := by
 cases minimality <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.VacuumOddGrammar
