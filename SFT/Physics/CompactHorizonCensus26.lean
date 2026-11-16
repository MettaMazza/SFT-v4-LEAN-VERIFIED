import SFT.Physics.CompactHorizonGrammarBase
namespace SFT.Physics.CompactHorizonGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk26 (radius : Radius) (area : Area) (entropy : Entropy) (thermal : Thermal) (floor : Floor) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,radius,area,entropy,thermal,floor,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,radius,area,entropy,thermal,floor,extension⟩ := by
 cases radius <;> cases area <;> cases entropy <;> cases thermal <;> cases floor <;> cases extension <;> rfl
theorem uniqueCriteriaChunk26 (radius : Radius) (area : Area) (entropy : Entropy) (thermal : Thermal) (floor : Floor) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,radius,area,entropy,thermal,floor,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,radius,area,entropy,thermal,floor,extension⟩ : Candidate) = survivor := by
 cases radius <;> cases area <;> cases entropy <;> cases thermal <;> cases floor <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.CompactHorizonGrammar
