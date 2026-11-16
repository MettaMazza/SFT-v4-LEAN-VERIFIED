import SFT.Physics.SmithionGrammarBase
namespace SFT.Physics.SmithionGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk0 (roots : Roots) (ratios : Ratios) (relic : Relic) (abundance : Abundance) (flavour : Flavour) (measurement : Measurement) (extension : Extension) : survives ⟨.rejected,.rejected,.rejected,.rejected,roots,ratios,relic,abundance,flavour,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,roots,ratios,relic,abundance,flavour,measurement,extension⟩ := by
 cases roots <;> cases ratios <;> cases relic <;> cases abundance <;> cases flavour <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk0 (roots : Roots) (ratios : Ratios) (relic : Relic) (abundance : Abundance) (flavour : Flavour) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,roots,ratios,relic,abundance,flavour,measurement,extension⟩ = true ↔ (⟨.rejected,.rejected,.rejected,.rejected,roots,ratios,relic,abundance,flavour,measurement,extension⟩ : Candidate) = survivor := by
 cases roots <;> cases ratios <;> cases relic <;> cases abundance <;> cases flavour <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.SmithionGrammar
