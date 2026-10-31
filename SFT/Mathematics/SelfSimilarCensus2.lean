import SFT.Mathematics.SelfSimilarGrammarBase
namespace SFT.Mathematics.SelfSimilarGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus2 (support : Support) (series : Series) (generality : Generality) (addition : Addition) : survives ⟨.rejected,.rejected,.admitted,.rejected,support,series,generality,addition⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,support,series,generality,addition⟩ := by
 cases support <;> cases series <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus2 (support : Support) (series : Series) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,support,series,generality,addition⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,support,series,generality,addition⟩ : Candidate) = survivor := by
 cases support <;> cases series <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.SelfSimilarGrammar
