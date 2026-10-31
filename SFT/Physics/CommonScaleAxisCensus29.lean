import SFT.Physics.CommonScaleAxisGrammarBase
namespace SFT.Physics.CommonScaleAxisGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem decisionCensus29 (units : Units) (placement : Placement) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected1,.rejected,.admitted,units,placement,target,provenance,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected1,.rejected,.admitted,units,placement,target,provenance,extension⟩ := by
 cases units <;> cases placement <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus29 (units : Units) (placement : Placement) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected1,.rejected,.admitted,units,placement,target,provenance,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.admitted,.rejected,.rejected1,.rejected,.admitted,units,placement,target,provenance,extension⟩ : Candidate) = survivor := by
 cases units <;> cases placement <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CommonScaleAxisGrammar
