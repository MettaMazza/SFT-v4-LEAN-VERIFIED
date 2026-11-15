import SFT.Mathematics.CalculatorBrowserGrammarBase
namespace SFT.Mathematics.CalculatorBrowserGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk13 (session_state : Session_state) (network_reach : Network_reach) (dependency_boundary : Dependency_boundary) (validation : Validation) : survives ⟨.admitted,.admitted,.rejected,.admitted,session_state,network_reach,dependency_boundary,validation⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,session_state,network_reach,dependency_boundary,validation⟩ := by
 cases session_state <;> cases network_reach <;> cases dependency_boundary <;> cases validation <;> rfl
theorem uniqueCriteriaChunk13 (session_state : Session_state) (network_reach : Network_reach) (dependency_boundary : Dependency_boundary) (validation : Validation) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,session_state,network_reach,dependency_boundary,validation⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,session_state,network_reach,dependency_boundary,validation⟩ : Candidate) = survivor := by
 cases session_state <;> cases network_reach <;> cases dependency_boundary <;> cases validation
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.CalculatorBrowserGrammar
