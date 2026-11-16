import SFT.Physics.SmithionGrammarBase
namespace SFT.Physics.SmithionGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk2 (roots : Roots) (ratios : Ratios) (relic : Relic) (abundance : Abundance) (flavour : Flavour) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,roots,ratios,relic,abundance,flavour,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,roots,ratios,relic,abundance,flavour,measurement,extension⟩ := by
 cases roots <;> cases ratios <;> cases relic <;> cases abundance <;> cases flavour <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk2 (roots : Roots) (ratios : Ratios) (relic : Relic) (abundance : Abundance) (flavour : Flavour) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,roots,ratios,relic,abundance,flavour,measurement,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,roots,ratios,relic,abundance,flavour,measurement,extension⟩ : Candidate) = survivor := by
 cases roots <;> cases ratios <;> cases relic <;> cases abundance <;> cases flavour <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.SmithionGrammar
