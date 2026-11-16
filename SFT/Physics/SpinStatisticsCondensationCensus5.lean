import SFT.Physics.SpinStatisticsCondensationGrammarBase
namespace SFT.Physics.SpinStatisticsCondensationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk5 (spin : Spin) (pairing : Pairing) (lock : Lock) (ground : Ground) : survives ⟨.rejected,.admitted,.rejected,.admitted,spin,pairing,lock,ground⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,spin,pairing,lock,ground⟩ := by
 cases spin <;> cases pairing <;> cases lock <;> cases ground <;> rfl
theorem uniqueCriteriaChunk5 (spin : Spin) (pairing : Pairing) (lock : Lock) (ground : Ground) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,spin,pairing,lock,ground⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,spin,pairing,lock,ground⟩ : Candidate) = survivor := by
 cases spin <;> cases pairing <;> cases lock <;> cases ground
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.SpinStatisticsCondensationGrammar
