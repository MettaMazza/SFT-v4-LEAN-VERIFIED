import SFT.Foundation.AdmissionGrammarCore
namespace SFT.Foundation.AdmissionGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem sourceDecisionBlock6 (controls : Controls) (validation : Validation) (measurement : Measurement) (receipts : Receipts) (dependency : Dependency) (extra : Extra) : survives (⟨.rejected,.rejected,.admitted,.admitted,.rejected,controls,validation,measurement,receipts,dependency,extra⟩ : Candidate) = criteriaDecision (⟨.rejected,.rejected,.admitted,.admitted,.rejected,controls,validation,measurement,receipts,dependency,extra⟩ : Candidate) := by
 cases controls <;> cases validation <;> cases measurement <;> cases receipts <;> cases dependency <;> cases extra
 all_goals rfl
theorem uniqueCriteriaBlock6 (controls : Controls) (validation : Validation) (measurement : Measurement) (receipts : Receipts) (dependency : Dependency) (extra : Extra) : criteriaDecision (⟨.rejected,.rejected,.admitted,.admitted,.rejected,controls,validation,measurement,receipts,dependency,extra⟩ : Candidate) = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.rejected,controls,validation,measurement,receipts,dependency,extra⟩ : Candidate) = survivor := by
 cases controls <;> cases validation <;> cases measurement <;> cases receipts <;> cases dependency <;> cases extra
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Foundation.AdmissionGrammar
