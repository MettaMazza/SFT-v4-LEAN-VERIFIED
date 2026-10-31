import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus62Part0 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part0 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part1 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part1 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part2 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part2 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part3 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part3 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part4 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part4 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part5 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part5 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part6 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part6 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part7 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part7 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part8 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part8 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part9 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part9 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part10 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part10 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part11 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part11 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part12 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part12 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part13 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part13 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part14 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part14 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62Part15 (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ := by
 cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus62Part15 (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,record,extension⟩ : Candidate) = survivor := by
 cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus62 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass <;> cases inventory <;> cases measurement
 · exact decisionCensus62Part0 record extension
 · exact decisionCensus62Part1 record extension
 · exact decisionCensus62Part2 record extension
 · exact decisionCensus62Part3 record extension
 · exact decisionCensus62Part4 record extension
 · exact decisionCensus62Part5 record extension
 · exact decisionCensus62Part6 record extension
 · exact decisionCensus62Part7 record extension
 · exact decisionCensus62Part8 record extension
 · exact decisionCensus62Part9 record extension
 · exact decisionCensus62Part10 record extension
 · exact decisionCensus62Part11 record extension
 · exact decisionCensus62Part12 record extension
 · exact decisionCensus62Part13 record extension
 · exact decisionCensus62Part14 record extension
 · exact decisionCensus62Part15 record extension
theorem uniqueCensus62 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass <;> cases inventory <;> cases measurement
 · exact uniqueCensus62Part0 record extension
 · exact uniqueCensus62Part1 record extension
 · exact uniqueCensus62Part2 record extension
 · exact uniqueCensus62Part3 record extension
 · exact uniqueCensus62Part4 record extension
 · exact uniqueCensus62Part5 record extension
 · exact uniqueCensus62Part6 record extension
 · exact uniqueCensus62Part7 record extension
 · exact uniqueCensus62Part8 record extension
 · exact uniqueCensus62Part9 record extension
 · exact uniqueCensus62Part10 record extension
 · exact uniqueCensus62Part11 record extension
 · exact uniqueCensus62Part12 record extension
 · exact uniqueCensus62Part13 record extension
 · exact uniqueCensus62Part14 record extension
 · exact uniqueCensus62Part15 record extension
end SFT.Physics.SectorInventoryGrammar
