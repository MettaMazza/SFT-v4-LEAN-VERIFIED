import SFT.Physics.HubbleGrammarBase
namespace SFT.Physics.HubbleGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus65 (deepening : Deepening) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,deepening,target,provenance,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,deepening,target,provenance,extension⟩ := by
 cases deepening <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus65 (deepening : Deepening) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,deepening,target,provenance,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,deepening,target,provenance,extension⟩ : Candidate) = survivor := by
 cases deepening <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.HubbleGrammar
