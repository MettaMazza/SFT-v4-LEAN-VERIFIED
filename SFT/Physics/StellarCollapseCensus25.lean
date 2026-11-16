import SFT.Physics.StellarCollapseGrammarBase
namespace SFT.Physics.StellarCollapseGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk25 (collapse : Collapse) (thermonuclear : Thermonuclear) (capture : Capture) (rebalance : Rebalance) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ := by
 cases collapse <;> cases thermonuclear <;> cases capture <;> cases rebalance <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk25 (collapse : Collapse) (thermonuclear : Thermonuclear) (capture : Capture) (rebalance : Rebalance) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ : Candidate) = survivor := by
 cases collapse <;> cases thermonuclear <;> cases capture <;> cases rebalance <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.StellarCollapseGrammar
