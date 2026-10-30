import SFT.Mathematics.ExactRelationsGrammarBase
namespace SFT.Mathematics.ExactRelationsGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus13 (transport : Transport) (composition : Composition) (generality : Generality) (addition : Addition) : survives ⟨.admitted,.admitted,.rejected,.admitted,transport,composition,generality,addition⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,transport,composition,generality,addition⟩ := by
 cases transport <;> cases composition <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus13 (transport : Transport) (composition : Composition) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,transport,composition,generality,addition⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,transport,composition,generality,addition⟩ : Candidate) = survivor := by
 cases transport <;> cases composition <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.ExactRelationsGrammar
