import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus20Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus20Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus20Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus20Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus20Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus20Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus20Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus20Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus20 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus20Part0 inventory measurement record extension
 · exact decisionCensus20Part1 inventory measurement record extension
 · exact decisionCensus20Part2 inventory measurement record extension
 · exact decisionCensus20Part3 inventory measurement record extension
theorem uniqueCensus20 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus20Part0 inventory measurement record extension
 · exact uniqueCensus20Part1 inventory measurement record extension
 · exact uniqueCensus20Part2 inventory measurement record extension
 · exact uniqueCensus20Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
