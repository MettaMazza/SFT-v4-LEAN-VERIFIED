import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus10Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus10Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus10Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus10Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus10Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus10Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus10Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus10Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus10 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus10Part0 inventory measurement record extension
 · exact decisionCensus10Part1 inventory measurement record extension
 · exact decisionCensus10Part2 inventory measurement record extension
 · exact decisionCensus10Part3 inventory measurement record extension
theorem uniqueCensus10 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus10Part0 inventory measurement record extension
 · exact uniqueCensus10Part1 inventory measurement record extension
 · exact uniqueCensus10Part2 inventory measurement record extension
 · exact uniqueCensus10Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
