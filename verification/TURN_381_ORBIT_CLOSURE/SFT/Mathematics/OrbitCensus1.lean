import SFT.Mathematics.OrbitGrammarBase
namespace SFT.Mathematics.OrbitGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus1 (partition : Partition) (transient : Transient) (generality : Generality) (addition : Addition) : survives ⟨.rejected,.rejected,.rejected,.admitted,partition,transient,generality,addition⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,partition,transient,generality,addition⟩ := by
 cases partition <;> cases transient <;> cases generality <;> cases addition
 all_goals rfl
theorem uniqueCensus1 (partition : Partition) (transient : Transient) (generality : Generality) (addition : Addition) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,partition,transient,generality,addition⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,partition,transient,generality,addition⟩ : Candidate) = survivor := by
 cases partition <;> cases transient <;> cases generality <;> cases addition
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.OrbitGrammar
