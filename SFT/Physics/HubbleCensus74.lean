import SFT.Physics.HubbleGrammarBase
namespace SFT.Physics.HubbleGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus74 (deepening : Deepening) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,deepening,target,provenance,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,deepening,target,provenance,extension⟩ := by
 cases deepening <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus74 (deepening : Deepening) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,deepening,target,provenance,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,deepening,target,provenance,extension⟩ : Candidate) = survivor := by
 cases deepening <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.HubbleGrammar
