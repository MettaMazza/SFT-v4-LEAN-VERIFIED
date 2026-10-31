import SFT.Physics.PlanckTerminalGrammarBase
namespace SFT.Physics.PlanckTerminalGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus12 (enumeration : Enumeration) (minimality : Minimality) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,enumeration,minimality,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,enumeration,minimality,measurement,extension⟩ := by
 cases enumeration <;> cases minimality <;> cases measurement <;> cases extension
 all_goals rfl
theorem uniqueCensus12 (enumeration : Enumeration) (minimality : Minimality) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,enumeration,minimality,measurement,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,enumeration,minimality,measurement,extension⟩ : Candidate) = survivor := by
 cases enumeration <;> cases minimality <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.PlanckTerminalGrammar
