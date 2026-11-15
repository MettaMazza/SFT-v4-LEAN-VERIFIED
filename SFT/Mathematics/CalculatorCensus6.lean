import SFT.Mathematics.CalculatorGrammarBase
namespace SFT.Mathematics.CalculatorGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk6 (nonrational : Nonrational) (transcendental : Transcendental) (orthogonal : Orthogonal) (domain : Domain) (trace : Trace) (addition : Addition) : survives ⟨.rejected,.admitted,.admitted,.rejected,nonrational,transcendental,orthogonal,domain,trace,addition⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,nonrational,transcendental,orthogonal,domain,trace,addition⟩ := by
 cases nonrational <;> cases transcendental <;> cases orthogonal <;> cases domain <;> cases trace <;> cases addition <;> rfl
theorem uniqueCriteriaChunk6 (nonrational : Nonrational) (transcendental : Transcendental) (orthogonal : Orthogonal) (domain : Domain) (trace : Trace) (addition : Addition) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,nonrational,transcendental,orthogonal,domain,trace,addition⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,nonrational,transcendental,orthogonal,domain,trace,addition⟩ : Candidate) = survivor := by
 cases nonrational <;> cases transcendental <;> cases orthogonal <;> cases domain <;> cases trace <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.CalculatorGrammar
