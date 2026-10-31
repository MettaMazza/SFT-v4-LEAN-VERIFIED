import SFT.Physics.HubbleGrammarBase
namespace SFT.Physics.HubbleGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem decisionCensus24 (deepening : Deepening) (target : Target) (provenance : Provenance) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.rejected,deepening,target,provenance,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.rejected,deepening,target,provenance,extension⟩ := by
 cases deepening <;> cases target <;> cases provenance <;> cases extension
 all_goals rfl
theorem uniqueCensus24 (deepening : Deepening) (target : Target) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.rejected,deepening,target,provenance,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.rejected,deepening,target,provenance,extension⟩ : Candidate) = survivor := by
 cases deepening <;> cases target <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.HubbleGrammar
