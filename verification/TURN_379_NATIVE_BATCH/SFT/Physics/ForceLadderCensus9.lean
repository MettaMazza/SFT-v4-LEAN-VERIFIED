import SFT.Physics.ForceLadderGrammarBase
namespace SFT.Physics.ForceLadderGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus9 (minimality : Minimality) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,minimality,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,minimality,measurement,record,extension⟩ := by
 cases minimality <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus9 (minimality : Minimality) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,minimality,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,minimality,measurement,record,extension⟩ : Candidate) = survivor := by
 cases minimality <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ForceLadderGrammar
