import SFT.Physics.StellarGrammarBase
namespace SFT.Physics.StellarGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk17 (dark : Dark) (tully : Tully) (resonance : Resonance) (tidal : Tidal) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,dark,tully,resonance,tidal,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,dark,tully,resonance,tidal,measurement,extension⟩ := by
 cases dark <;> cases tully <;> cases resonance <;> cases tidal <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk17 (dark : Dark) (tully : Tully) (resonance : Resonance) (tidal : Tidal) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,dark,tully,resonance,tidal,measurement,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,dark,tully,resonance,tidal,measurement,extension⟩ : Candidate) = survivor := by
 cases dark <;> cases tully <;> cases resonance <;> cases tidal <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.StellarGrammar
