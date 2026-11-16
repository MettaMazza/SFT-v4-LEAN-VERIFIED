import SFT.Physics.StrongCPGrammarBase
namespace SFT.Physics.StrongCPGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk2 (compensator : Compensator) (sector : Sector) (baryon : Baryon) (transition : Transition) (baryogenesis : Baryogenesis) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩ := by
 cases compensator <;> cases sector <;> cases baryon <;> cases transition <;> cases baryogenesis <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk2 (compensator : Compensator) (sector : Sector) (baryon : Baryon) (transition : Transition) (baryogenesis : Baryogenesis) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩ : Candidate) = survivor := by
 cases compensator <;> cases sector <;> cases baryon <;> cases transition <;> cases baryogenesis <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.StrongCPGrammar
