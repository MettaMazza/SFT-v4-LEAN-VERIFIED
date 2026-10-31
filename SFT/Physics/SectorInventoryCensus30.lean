import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus30Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus30Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus30Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus30Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus30Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus30Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus30Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus30Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus30 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus30Part0 inventory measurement record extension
 · exact decisionCensus30Part1 inventory measurement record extension
 · exact decisionCensus30Part2 inventory measurement record extension
 · exact decisionCensus30Part3 inventory measurement record extension
theorem uniqueCensus30 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.rejected,.admitted,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus30Part0 inventory measurement record extension
 · exact uniqueCensus30Part1 inventory measurement record extension
 · exact uniqueCensus30Part2 inventory measurement record extension
 · exact uniqueCensus30Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
