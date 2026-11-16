import SFT.Physics.ChirpRingdownGrammarBase
namespace SFT.Physics.ChirpRingdownGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk33 (contact : Contact) (merger : Merger) (tone : Tone) (damping : Damping) (floor : Floor) (sequence : Sequence) : survives ⟨.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,contact,merger,tone,damping,floor,sequence⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,contact,merger,tone,damping,floor,sequence⟩ := by
 cases contact <;> cases merger <;> cases tone <;> cases damping <;> cases floor <;> cases sequence <;> rfl
theorem uniqueCriteriaChunk33 (contact : Contact) (merger : Merger) (tone : Tone) (damping : Damping) (floor : Floor) (sequence : Sequence) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,contact,merger,tone,damping,floor,sequence⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,contact,merger,tone,damping,floor,sequence⟩ : Candidate) = survivor := by
 cases contact <;> cases merger <;> cases tone <;> cases damping <;> cases floor <;> cases sequence
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ChirpRingdownGrammar
