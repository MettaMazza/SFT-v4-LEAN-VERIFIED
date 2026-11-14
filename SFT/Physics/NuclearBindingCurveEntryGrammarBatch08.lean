import SFT.Physics.NuclearBindingCurveEntryGrammarData
namespace SFT.Physics.NuclearBindingCurveEntryGrammarBatch08
open NuclearBindingCurveEntryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatches (asymmetry : Asymmetry) (pairing : Pairing) (radius : Radius) (maximum : Maximum) (target : Target) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.rejected,asymmetry,pairing,radius,maximum,target,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,asymmetry,pairing,radius,maximum,target,extension⟩ := by
 cases asymmetry <;> cases pairing <;> cases radius <;> cases maximum <;> cases target <;> cases extension
 all_goals rfl
theorem uniqueCriteria (asymmetry : Asymmetry) (pairing : Pairing) (radius : Radius) (maximum : Maximum) (target : Target) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,asymmetry,pairing,radius,maximum,target,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,asymmetry,pairing,radius,maximum,target,extension⟩ : Candidate) = survivor := by
 cases asymmetry <;> cases pairing <;> cases radius <;> cases maximum <;> cases target <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.NuclearBindingCurveEntryGrammarBatch08
