import SFT.Physics.CompactHorizonGrammarBase
namespace SFT.Physics.CompactHorizonGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk38 (radius : Radius) (area : Area) (entropy : Entropy) (thermal : Thermal) (floor : Floor) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,radius,area,entropy,thermal,floor,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,radius,area,entropy,thermal,floor,extension⟩ := by
 cases radius <;> cases area <;> cases entropy <;> cases thermal <;> cases floor <;> cases extension <;> rfl
theorem uniqueCriteriaChunk38 (radius : Radius) (area : Area) (entropy : Entropy) (thermal : Thermal) (floor : Floor) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,radius,area,entropy,thermal,floor,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,radius,area,entropy,thermal,floor,extension⟩ : Candidate) = survivor := by
 cases radius <;> cases area <;> cases entropy <;> cases thermal <;> cases floor <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CompactHorizonGrammar
