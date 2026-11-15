import SFT.Mathematics.CalculatorCompleteGrammarBase
namespace SFT.Mathematics.CalculatorCompleteGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk3 (proof_output : Proof_output) (accessibility : Accessibility) (portability : Portability) (periodic_scale : Periodic_scale) (resource_boundary : Resource_boundary) (testing : Testing) : survives ⟨.rejected,.rejected,.admitted,.admitted,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩ := by
 cases proof_output <;> cases accessibility <;> cases portability <;> cases periodic_scale <;> cases resource_boundary <;> cases testing <;> rfl
theorem uniqueCriteriaChunk3 (proof_output : Proof_output) (accessibility : Accessibility) (portability : Portability) (periodic_scale : Periodic_scale) (resource_boundary : Resource_boundary) (testing : Testing) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩ : Candidate) = survivor := by
 cases proof_output <;> cases accessibility <;> cases portability <;> cases periodic_scale <;> cases resource_boundary <;> cases testing
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.CalculatorCompleteGrammar
