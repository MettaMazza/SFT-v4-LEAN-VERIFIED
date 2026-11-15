import SFT.Mathematics.CalculatorCompleteGrammarBase
namespace SFT.Mathematics.CalculatorCompleteGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk7 (proof_output : Proof_output) (accessibility : Accessibility) (portability : Portability) (periodic_scale : Periodic_scale) (resource_boundary : Resource_boundary) (testing : Testing) : survives ⟨.rejected,.admitted,.admitted,.admitted,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩ := by
 cases proof_output <;> cases accessibility <;> cases portability <;> cases periodic_scale <;> cases resource_boundary <;> cases testing <;> rfl
theorem uniqueCriteriaChunk7 (proof_output : Proof_output) (accessibility : Accessibility) (portability : Portability) (periodic_scale : Periodic_scale) (resource_boundary : Resource_boundary) (testing : Testing) : criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.admitted,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩ : Candidate) = survivor := by
 cases proof_output <;> cases accessibility <;> cases portability <;> cases periodic_scale <;> cases resource_boundary <;> cases testing
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.CalculatorCompleteGrammar
