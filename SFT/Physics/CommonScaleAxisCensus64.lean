import SFT.Physics.CommonScaleAxisGrammarBase
namespace SFT.Physics.CommonScaleAxisGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem decisionCensus64 (units : Units) (placement : Placement) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected1,.rejected,.rejected,units,placement,target,provenance,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected1,.rejected,.rejected,units,placement,target,provenance,extension⟩ := by
 cases units <;> cases placement <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus64 (units : Units) (placement : Placement) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected1,.rejected,.rejected,units,placement,target,provenance,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected1,.rejected,.rejected,units,placement,target,provenance,extension⟩ : Candidate) = survivor := by
 cases units <;> cases placement <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CommonScaleAxisGrammar
