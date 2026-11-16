import SFT.Physics.StellarCollapseGrammarBase
namespace SFT.Physics.StellarCollapseGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk17 (collapse : Collapse) (thermonuclear : Thermonuclear) (capture : Capture) (rebalance : Rebalance) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ := by
 cases collapse <;> cases thermonuclear <;> cases capture <;> cases rebalance <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk17 (collapse : Collapse) (thermonuclear : Thermonuclear) (capture : Capture) (rebalance : Rebalance) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ : Candidate) = survivor := by
 cases collapse <;> cases thermonuclear <;> cases capture <;> cases rebalance <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.StellarCollapseGrammar
