import SFT.Physics.ForceLadderGrammarBase
namespace SFT.Physics.ForceLadderGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus0 (minimality : Minimality) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.rejected,minimality,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,minimality,measurement,record,extension⟩ := by
 cases minimality <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus0 (minimality : Minimality) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,minimality,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,minimality,measurement,record,extension⟩ : Candidate) = survivor := by
 cases minimality <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ForceLadderGrammar
