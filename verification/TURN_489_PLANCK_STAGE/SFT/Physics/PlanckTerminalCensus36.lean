import SFT.Physics.PlanckTerminalGrammarBase
namespace SFT.Physics.PlanckTerminalGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus36 (enumeration : Enumeration) (minimality : Minimality) (measurement : Measurement) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,enumeration,minimality,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,enumeration,minimality,measurement,extension⟩ := by
 cases enumeration <;> cases minimality <;> cases measurement <;> cases extension
 all_goals rfl
theorem uniqueCensus36 (enumeration : Enumeration) (minimality : Minimality) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,enumeration,minimality,measurement,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,enumeration,minimality,measurement,extension⟩ : Candidate) = survivor := by
 cases enumeration <;> cases minimality <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.PlanckTerminalGrammar
