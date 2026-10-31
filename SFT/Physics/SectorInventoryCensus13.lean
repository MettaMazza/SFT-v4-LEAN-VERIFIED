import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus13Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus13Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus13Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus13Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus13Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus13Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus13Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus13Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus13 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus13Part0 inventory measurement record extension
 · exact decisionCensus13Part1 inventory measurement record extension
 · exact decisionCensus13Part2 inventory measurement record extension
 · exact decisionCensus13Part3 inventory measurement record extension
theorem uniqueCensus13 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus13Part0 inventory measurement record extension
 · exact uniqueCensus13Part1 inventory measurement record extension
 · exact uniqueCensus13Part2 inventory measurement record extension
 · exact uniqueCensus13Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
