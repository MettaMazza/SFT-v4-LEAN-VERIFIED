import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus27Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus27Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus27Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus27Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus27Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus27Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus27Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus27Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus27 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus27Part0 inventory measurement record extension
 · exact decisionCensus27Part1 inventory measurement record extension
 · exact decisionCensus27Part2 inventory measurement record extension
 · exact decisionCensus27Part3 inventory measurement record extension
theorem uniqueCensus27 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus27Part0 inventory measurement record extension
 · exact uniqueCensus27Part1 inventory measurement record extension
 · exact uniqueCensus27Part2 inventory measurement record extension
 · exact uniqueCensus27Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
