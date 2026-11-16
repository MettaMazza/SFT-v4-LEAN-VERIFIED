import SFT.Physics.CriticalityUniversalityGrammarBase
namespace SFT.Physics.CriticalityUniversalityGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk15 (field : Field) (identities : Identities) (cascade : Cascade) (spectrum : Spectrum) : survives ⟨.admitted,.admitted,.admitted,.admitted,field,identities,cascade,spectrum⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,field,identities,cascade,spectrum⟩ := by
 cases field <;> cases identities <;> cases cascade <;> cases spectrum <;> rfl
theorem uniqueCriteriaChunk15 (field : Field) (identities : Identities) (cascade : Cascade) (spectrum : Spectrum) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,field,identities,cascade,spectrum⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,field,identities,cascade,spectrum⟩ : Candidate) = survivor := by
 cases field <;> cases identities <;> cases cascade <;> cases spectrum
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CriticalityUniversalityGrammar
