import SFT.Physics.LandauerDemonLedgerGrammarBase
namespace SFT.Physics.LandauerDemonLedgerGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk10 (reverse : Reverse) (sorting : Sorting) (memory : Memory) (environment : Environment) (thermal : Thermal) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,reverse,sorting,memory,environment,thermal,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,reverse,sorting,memory,environment,thermal,extension⟩ := by
 cases reverse <;> cases sorting <;> cases memory <;> cases environment <;> cases thermal <;> cases extension <;> rfl
theorem uniqueCriteriaChunk10 (reverse : Reverse) (sorting : Sorting) (memory : Memory) (environment : Environment) (thermal : Thermal) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,reverse,sorting,memory,environment,thermal,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,reverse,sorting,memory,environment,thermal,extension⟩ : Candidate) = survivor := by
 cases reverse <;> cases sorting <;> cases memory <;> cases environment <;> cases thermal <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.LandauerDemonLedgerGrammar
