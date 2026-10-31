import SFT.Physics.ElectroweakTerminalGrammarBase
namespace SFT.Physics.ElectroweakTerminalGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus22 (enumeration : Enumeration) (minimality : Minimality) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,enumeration,minimality,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,enumeration,minimality,measurement,extension⟩ := by
 cases enumeration <;> cases minimality <;> cases measurement <;> cases extension
 all_goals rfl
theorem uniqueCensus22 (enumeration : Enumeration) (minimality : Minimality) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,enumeration,minimality,measurement,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,enumeration,minimality,measurement,extension⟩ : Candidate) = survivor := by
 cases enumeration <;> cases minimality <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ElectroweakTerminalGrammar
