import SFT.Mathematics.LimitContinuumGrammarBase
namespace SFT.Mathematics.LimitContinuumGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus6 (continuum : Continuum) (cardinality : Cardinality) (generality : Generality) (addition : Addition) : survives ⟨.rejected,.admitted,.admitted,.rejected,continuum,cardinality,generality,addition⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,continuum,cardinality,generality,addition⟩ := by
 cases continuum <;> cases cardinality <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus6 (continuum : Continuum) (cardinality : Cardinality) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,continuum,cardinality,generality,addition⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,continuum,cardinality,generality,addition⟩ : Candidate) = survivor := by
 cases continuum <;> cases cardinality <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.LimitContinuumGrammar
