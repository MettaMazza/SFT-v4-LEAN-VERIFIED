import SFT.Mathematics.LimitContinuumGrammarBase
namespace SFT.Mathematics.LimitContinuumGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus0 (continuum : Continuum) (cardinality : Cardinality) (generality : Generality) (addition : Addition) : survives ⟨.rejected,.rejected,.rejected,.rejected,continuum,cardinality,generality,addition⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,continuum,cardinality,generality,addition⟩ := by
 cases continuum <;> cases cardinality <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus0 (continuum : Continuum) (cardinality : Cardinality) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,continuum,cardinality,generality,addition⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,continuum,cardinality,generality,addition⟩ : Candidate) = survivor := by
 cases continuum <;> cases cardinality <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.LimitContinuumGrammar
