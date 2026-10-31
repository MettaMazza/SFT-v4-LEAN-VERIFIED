import SFT.Physics.HubbleGrammarBase
namespace SFT.Physics.HubbleGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus92 (deepening : Deepening) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,deepening,target,provenance,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,deepening,target,provenance,extension⟩ := by
 cases deepening <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus92 (deepening : Deepening) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,deepening,target,provenance,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,deepening,target,provenance,extension⟩ : Candidate) = survivor := by
 cases deepening <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.HubbleGrammar
