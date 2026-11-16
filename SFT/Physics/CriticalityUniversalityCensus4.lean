import SFT.Physics.CriticalityUniversalityGrammarBase
namespace SFT.Physics.CriticalityUniversalityGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk4 (field : Field) (identities : Identities) (cascade : Cascade) (spectrum : Spectrum) : survives ⟨.rejected,.admitted,.rejected,.rejected,field,identities,cascade,spectrum⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,field,identities,cascade,spectrum⟩ := by
 cases field <;> cases identities <;> cases cascade <;> cases spectrum <;> rfl
theorem uniqueCriteriaChunk4 (field : Field) (identities : Identities) (cascade : Cascade) (spectrum : Spectrum) : criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,field,identities,cascade,spectrum⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.rejected,field,identities,cascade,spectrum⟩ : Candidate) = survivor := by
 cases field <;> cases identities <;> cases cascade <;> cases spectrum
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CriticalityUniversalityGrammar
