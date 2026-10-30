import SFT.Mathematics.LimitContinuumGrammarBase
namespace SFT.Mathematics.LimitContinuumGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus15 (continuum : Continuum) (cardinality : Cardinality) (generality : Generality) (addition : Addition) : survives ⟨.admitted,.admitted,.admitted,.admitted,continuum,cardinality,generality,addition⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,continuum,cardinality,generality,addition⟩ := by
 cases continuum <;> cases cardinality <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus15 (continuum : Continuum) (cardinality : Cardinality) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,continuum,cardinality,generality,addition⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,continuum,cardinality,generality,addition⟩ : Candidate) = survivor := by
 cases continuum <;> cases cardinality <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.LimitContinuumGrammar
