import SFT.Physics.StellarCollapseGrammarBase
namespace SFT.Physics.StellarCollapseGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk57 (collapse : Collapse) (thermonuclear : Thermonuclear) (capture : Capture) (rebalance : Rebalance) (measurement : Measurement) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ := by
 cases collapse <;> cases thermonuclear <;> cases capture <;> cases rebalance <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk57 (collapse : Collapse) (thermonuclear : Thermonuclear) (capture : Capture) (rebalance : Rebalance) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ : Candidate) = survivor := by
 cases collapse <;> cases thermonuclear <;> cases capture <;> cases rebalance <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.StellarCollapseGrammar
