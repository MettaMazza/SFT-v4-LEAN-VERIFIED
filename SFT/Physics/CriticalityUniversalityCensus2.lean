import SFT.Physics.CriticalityUniversalityGrammarBase
namespace SFT.Physics.CriticalityUniversalityGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk2 (field : Field) (identities : Identities) (cascade : Cascade) (spectrum : Spectrum) : survives ⟨.rejected,.rejected,.admitted,.rejected,field,identities,cascade,spectrum⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,field,identities,cascade,spectrum⟩ := by
 cases field <;> cases identities <;> cases cascade <;> cases spectrum <;> rfl
theorem uniqueCriteriaChunk2 (field : Field) (identities : Identities) (cascade : Cascade) (spectrum : Spectrum) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,field,identities,cascade,spectrum⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,field,identities,cascade,spectrum⟩ : Candidate) = survivor := by
 cases field <;> cases identities <;> cases cascade <;> cases spectrum
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CriticalityUniversalityGrammar
