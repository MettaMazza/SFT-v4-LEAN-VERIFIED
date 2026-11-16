import SFT.Physics.HiggsGrammarBase
namespace SFT.Physics.HiggsGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk22 (cover : Cover) (transport : Transport) (coupling : Coupling) (route : Route) (measurement : Measurement) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,.rejected,cover,transport,coupling,route,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.rejected,cover,transport,coupling,route,measurement,extension⟩ := by
 cases cover <;> cases transport <;> cases coupling <;> cases route <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk22 (cover : Cover) (transport : Transport) (coupling : Coupling) (route : Route) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.rejected,cover,transport,coupling,route,measurement,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,.rejected,cover,transport,coupling,route,measurement,extension⟩ : Candidate) = survivor := by
 cases cover <;> cases transport <;> cases coupling <;> cases route <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.HiggsGrammar
