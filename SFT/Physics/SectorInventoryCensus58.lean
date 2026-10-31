import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus58Part0 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part0 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part1 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part1 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part2 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part2 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part3 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part3 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part4 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part4 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part5 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part5 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part6 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part6 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part7 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part7 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part8 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part8 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part9 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part9 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part10 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part10 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part11 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part11 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part12 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part12 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part13 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part13 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part14 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part14 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58Part15 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus58Part15 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus58 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass <;> cases inventory <;> cases measurement
 · exact decisionCensus58Part0 record extension
 · exact decisionCensus58Part1 record extension
 · exact decisionCensus58Part2 record extension
 · exact decisionCensus58Part3 record extension
 · exact decisionCensus58Part4 record extension
 · exact decisionCensus58Part5 record extension
 · exact decisionCensus58Part6 record extension
 · exact decisionCensus58Part7 record extension
 · exact decisionCensus58Part8 record extension
 · exact decisionCensus58Part9 record extension
 · exact decisionCensus58Part10 record extension
 · exact decisionCensus58Part11 record extension
 · exact decisionCensus58Part12 record extension
 · exact decisionCensus58Part13 record extension
 · exact decisionCensus58Part14 record extension
 · exact decisionCensus58Part15 record extension
theorem uniqueCensus58 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass <;> cases inventory <;> cases measurement
 · exact uniqueCensus58Part0 record extension
 · exact uniqueCensus58Part1 record extension
 · exact uniqueCensus58Part2 record extension
 · exact uniqueCensus58Part3 record extension
 · exact uniqueCensus58Part4 record extension
 · exact uniqueCensus58Part5 record extension
 · exact uniqueCensus58Part6 record extension
 · exact uniqueCensus58Part7 record extension
 · exact uniqueCensus58Part8 record extension
 · exact uniqueCensus58Part9 record extension
 · exact uniqueCensus58Part10 record extension
 · exact uniqueCensus58Part11 record extension
 · exact uniqueCensus58Part12 record extension
 · exact uniqueCensus58Part13 record extension
 · exact uniqueCensus58Part14 record extension
 · exact uniqueCensus58Part15 record extension
end SFT.Physics.SectorInventoryGrammar
