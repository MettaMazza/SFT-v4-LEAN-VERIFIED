import SFT.Physics.StrongCPGrammarBase
namespace SFT.Physics.StrongCPGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk5 (compensator : Compensator) (sector : Sector) (baryon : Baryon) (transition : Transition) (baryogenesis : Baryogenesis) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩ := by
 cases compensator <;> cases sector <;> cases baryon <;> cases transition <;> cases baryogenesis <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk5 (compensator : Compensator) (sector : Sector) (baryon : Baryon) (transition : Transition) (baryogenesis : Baryogenesis) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩ : Candidate) = survivor := by
 cases compensator <;> cases sector <;> cases baryon <;> cases transition <;> cases baryogenesis <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.StrongCPGrammar
