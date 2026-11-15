import SFT.Physics.BaryogenesisDependencyGrammarBase
namespace SFT.Physics.BaryogenesisDependencyGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk8 (ledger : Ledger) (composition : Composition) (enumeration : Enumeration) (comparison : Comparison) (provenance : Provenance) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.rejected,ledger,composition,enumeration,comparison,provenance,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,ledger,composition,enumeration,comparison,provenance,extension⟩ := by
 cases ledger <;> cases composition <;> cases enumeration <;> cases comparison <;> cases provenance <;> cases extension <;> rfl
theorem uniqueCriteriaChunk8 (ledger : Ledger) (composition : Composition) (enumeration : Enumeration) (comparison : Comparison) (provenance : Provenance) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,ledger,composition,enumeration,comparison,provenance,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,ledger,composition,enumeration,comparison,provenance,extension⟩ : Candidate) = survivor := by
 cases ledger <;> cases composition <;> cases enumeration <;> cases comparison <;> cases provenance <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.BaryogenesisDependencyGrammar
