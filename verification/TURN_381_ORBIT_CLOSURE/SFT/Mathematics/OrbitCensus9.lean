import SFT.Mathematics.OrbitGrammarBase
namespace SFT.Mathematics.OrbitGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus9 (partition : Partition) (transient : Transient) (generality : Generality) (addition : Addition) : survives ⟨.admitted,.rejected,.rejected,.admitted,partition,transient,generality,addition⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,partition,transient,generality,addition⟩ := by
 cases partition <;> cases transient <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus9 (partition : Partition) (transient : Transient) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,partition,transient,generality,addition⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,partition,transient,generality,addition⟩ : Candidate) = survivor := by
 cases partition <;> cases transient <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.OrbitGrammar
