import SFT.Mathematics.ExactRelationsGrammarBase
namespace SFT.Mathematics.ExactRelationsGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus0 (transport : Transport) (composition : Composition) (generality : Generality) (addition : Addition) : survives ⟨.rejected,.rejected,.rejected,.rejected,transport,composition,generality,addition⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,transport,composition,generality,addition⟩ := by
 cases transport <;> cases composition <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus0 (transport : Transport) (composition : Composition) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,transport,composition,generality,addition⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,transport,composition,generality,addition⟩ : Candidate) = survivor := by
 cases transport <;> cases composition <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.ExactRelationsGrammar
