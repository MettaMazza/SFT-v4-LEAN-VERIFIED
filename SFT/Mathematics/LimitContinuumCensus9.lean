import SFT.Mathematics.LimitContinuumGrammarBase
namespace SFT.Mathematics.LimitContinuumGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus9 (continuum : Continuum) (cardinality : Cardinality) (generality : Generality) (addition : Addition) : survives ⟨.admitted,.rejected,.rejected,.admitted,continuum,cardinality,generality,addition⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,continuum,cardinality,generality,addition⟩ := by
 cases continuum <;> cases cardinality <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus9 (continuum : Continuum) (cardinality : Cardinality) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,continuum,cardinality,generality,addition⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,continuum,cardinality,generality,addition⟩ : Candidate) = survivor := by
 cases continuum <;> cases cardinality <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.LimitContinuumGrammar
