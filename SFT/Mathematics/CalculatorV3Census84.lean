import SFT.Mathematics.CalculatorV3GrammarBase
namespace SFT.Mathematics.CalculatorV3Grammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk84 (domain : Domain) (trace : Trace) (addition : Addition) (scientific_surface : Scientific_surface) (session : Session) (application : Application) : survives ⟨.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,domain,trace,addition,scientific_surface,session,application⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,domain,trace,addition,scientific_surface,session,application⟩ := by
 cases domain <;> cases trace <;> cases addition <;> cases scientific_surface <;> cases session <;> cases application <;> rfl
theorem uniqueCriteriaChunk84 (domain : Domain) (trace : Trace) (addition : Addition) (scientific_surface : Scientific_surface) (session : Session) (application : Application) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,domain,trace,addition,scientific_surface,session,application⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,domain,trace,addition,scientific_surface,session,application⟩ : Candidate) = survivor := by
 cases domain <;> cases trace <;> cases addition <;> cases scientific_surface <;> cases session <;> cases application
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Mathematics.CalculatorV3Grammar
