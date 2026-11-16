import SFT.Physics.SpinStatisticsCondensationGrammarBase
namespace SFT.Physics.SpinStatisticsCondensationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk9 (spin : Spin) (pairing : Pairing) (lock : Lock) (ground : Ground) : survives ⟨.admitted,.rejected,.rejected,.admitted,spin,pairing,lock,ground⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,spin,pairing,lock,ground⟩ := by
 cases spin <;> cases pairing <;> cases lock <;> cases ground <;> rfl
theorem uniqueCriteriaChunk9 (spin : Spin) (pairing : Pairing) (lock : Lock) (ground : Ground) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,spin,pairing,lock,ground⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,spin,pairing,lock,ground⟩ : Candidate) = survivor := by
 cases spin <;> cases pairing <;> cases lock <;> cases ground
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.SpinStatisticsCondensationGrammar
