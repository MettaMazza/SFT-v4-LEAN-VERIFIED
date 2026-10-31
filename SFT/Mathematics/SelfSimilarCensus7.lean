import SFT.Mathematics.SelfSimilarGrammarBase
namespace SFT.Mathematics.SelfSimilarGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus7 (support : Support) (series : Series) (generality : Generality) (addition : Addition) : survives ⟨.rejected,.admitted,.admitted,.admitted,support,series,generality,addition⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,support,series,generality,addition⟩ := by
 cases support <;> cases series <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus7 (support : Support) (series : Series) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,support,series,generality,addition⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.admitted,support,series,generality,addition⟩ : Candidate) = survivor := by
 cases support <;> cases series <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.SelfSimilarGrammar
