import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus9Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus9Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus9Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus9Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus9Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus9Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus9Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus9Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus9 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus9Part0 inventory measurement record extension
 · exact decisionCensus9Part1 inventory measurement record extension
 · exact decisionCensus9Part2 inventory measurement record extension
 · exact decisionCensus9Part3 inventory measurement record extension
theorem uniqueCensus9 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus9Part0 inventory measurement record extension
 · exact uniqueCensus9Part1 inventory measurement record extension
 · exact uniqueCensus9Part2 inventory measurement record extension
 · exact uniqueCensus9Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
