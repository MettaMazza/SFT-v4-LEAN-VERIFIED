import SFT.Physics.LandauerDemonLedgerGrammarBase
namespace SFT.Physics.LandauerDemonLedgerGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk1 (reverse : Reverse) (sorting : Sorting) (memory : Memory) (environment : Environment) (thermal : Thermal) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.admitted,reverse,sorting,memory,environment,thermal,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,reverse,sorting,memory,environment,thermal,extension⟩ := by
 cases reverse <;> cases sorting <;> cases memory <;> cases environment <;> cases thermal <;> cases extension <;> rfl
theorem uniqueCriteriaChunk1 (reverse : Reverse) (sorting : Sorting) (memory : Memory) (environment : Environment) (thermal : Thermal) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,reverse,sorting,memory,environment,thermal,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,reverse,sorting,memory,environment,thermal,extension⟩ : Candidate) = survivor := by
 cases reverse <;> cases sorting <;> cases memory <;> cases environment <;> cases thermal <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.LandauerDemonLedgerGrammar
