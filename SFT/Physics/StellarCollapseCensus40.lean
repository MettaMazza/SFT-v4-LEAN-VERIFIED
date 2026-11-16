import SFT.Physics.StellarCollapseGrammarBase
namespace SFT.Physics.StellarCollapseGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk40 (collapse : Collapse) (thermonuclear : Thermonuclear) (capture : Capture) (rebalance : Rebalance) (measurement : Measurement) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ := by
 cases collapse <;> cases thermonuclear <;> cases capture <;> cases rebalance <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk40 (collapse : Collapse) (thermonuclear : Thermonuclear) (capture : Capture) (rebalance : Rebalance) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,collapse,thermonuclear,capture,rebalance,measurement,extension⟩ : Candidate) = survivor := by
 cases collapse <;> cases thermonuclear <;> cases capture <;> cases rebalance <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.StellarCollapseGrammar
