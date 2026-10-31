import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus56Part0 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part0 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part1 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part1 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part2 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part2 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part3 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part3 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part4 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part4 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part5 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part5 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part6 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part6 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part7 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part7 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part8 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part8 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part9 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part9 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part10 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part10 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part11 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part11 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part12 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part12 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part13 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part13 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part14 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part14 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56Part15 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus56Part15 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus56 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass <;> cases inventory <;> cases measurement
 · exact decisionCensus56Part0 record extension
 · exact decisionCensus56Part1 record extension
 · exact decisionCensus56Part2 record extension
 · exact decisionCensus56Part3 record extension
 · exact decisionCensus56Part4 record extension
 · exact decisionCensus56Part5 record extension
 · exact decisionCensus56Part6 record extension
 · exact decisionCensus56Part7 record extension
 · exact decisionCensus56Part8 record extension
 · exact decisionCensus56Part9 record extension
 · exact decisionCensus56Part10 record extension
 · exact decisionCensus56Part11 record extension
 · exact decisionCensus56Part12 record extension
 · exact decisionCensus56Part13 record extension
 · exact decisionCensus56Part14 record extension
 · exact decisionCensus56Part15 record extension
theorem uniqueCensus56 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass <;> cases inventory <;> cases measurement
 · exact uniqueCensus56Part0 record extension
 · exact uniqueCensus56Part1 record extension
 · exact uniqueCensus56Part2 record extension
 · exact uniqueCensus56Part3 record extension
 · exact uniqueCensus56Part4 record extension
 · exact uniqueCensus56Part5 record extension
 · exact uniqueCensus56Part6 record extension
 · exact uniqueCensus56Part7 record extension
 · exact uniqueCensus56Part8 record extension
 · exact uniqueCensus56Part9 record extension
 · exact uniqueCensus56Part10 record extension
 · exact uniqueCensus56Part11 record extension
 · exact uniqueCensus56Part12 record extension
 · exact uniqueCensus56Part13 record extension
 · exact uniqueCensus56Part14 record extension
 · exact uniqueCensus56Part15 record extension
end SFT.Physics.SectorInventoryGrammar
