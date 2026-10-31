import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus60Part0 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part0 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part1 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part1 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part2 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part2 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part3 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part3 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part4 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part4 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part5 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part5 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part6 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part6 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part7 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part7 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part8 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part8 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part9 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part9 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part10 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part10 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part11 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part11 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part12 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part12 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part13 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part13 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part14 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part14 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60Part15 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus60Part15 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus60 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass <;> cases inventory <;> cases measurement
 · exact decisionCensus60Part0 record extension
 · exact decisionCensus60Part1 record extension
 · exact decisionCensus60Part2 record extension
 · exact decisionCensus60Part3 record extension
 · exact decisionCensus60Part4 record extension
 · exact decisionCensus60Part5 record extension
 · exact decisionCensus60Part6 record extension
 · exact decisionCensus60Part7 record extension
 · exact decisionCensus60Part8 record extension
 · exact decisionCensus60Part9 record extension
 · exact decisionCensus60Part10 record extension
 · exact decisionCensus60Part11 record extension
 · exact decisionCensus60Part12 record extension
 · exact decisionCensus60Part13 record extension
 · exact decisionCensus60Part14 record extension
 · exact decisionCensus60Part15 record extension
theorem uniqueCensus60 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass <;> cases inventory <;> cases measurement
 · exact uniqueCensus60Part0 record extension
 · exact uniqueCensus60Part1 record extension
 · exact uniqueCensus60Part2 record extension
 · exact uniqueCensus60Part3 record extension
 · exact uniqueCensus60Part4 record extension
 · exact uniqueCensus60Part5 record extension
 · exact uniqueCensus60Part6 record extension
 · exact uniqueCensus60Part7 record extension
 · exact uniqueCensus60Part8 record extension
 · exact uniqueCensus60Part9 record extension
 · exact uniqueCensus60Part10 record extension
 · exact uniqueCensus60Part11 record extension
 · exact uniqueCensus60Part12 record extension
 · exact uniqueCensus60Part13 record extension
 · exact uniqueCensus60Part14 record extension
 · exact uniqueCensus60Part15 record extension
end SFT.Physics.SectorInventoryGrammar
