import SFT.Physics.ScatteringPartitionPathGrammarBase
namespace SFT.Physics.ScatteringPartitionPathGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk14 («section» : Section) (density : Density) (path : Path) (cause : Cause) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,«section»,density,path,cause,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,«section»,density,path,cause,extension⟩ := by
 cases «section» <;> cases density <;> cases path <;> cases cause <;> cases extension <;> rfl
theorem uniqueCriteriaChunk14 («section» : Section) (density : Density) (path : Path) (cause : Cause) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,«section»,density,path,cause,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,«section»,density,path,cause,extension⟩ : Candidate) = survivor := by
 cases «section» <;> cases density <;> cases path <;> cases cause <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.ScatteringPartitionPathGrammar
