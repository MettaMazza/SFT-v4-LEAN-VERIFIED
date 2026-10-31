import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus41Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus41Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus41Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus41Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus41Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus41Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus41Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus41Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus41 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus41Part0 inventory measurement record extension
 · exact decisionCensus41Part1 inventory measurement record extension
 · exact decisionCensus41Part2 inventory measurement record extension
 · exact decisionCensus41Part3 inventory measurement record extension
theorem uniqueCensus41 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus41Part0 inventory measurement record extension
 · exact uniqueCensus41Part1 inventory measurement record extension
 · exact uniqueCensus41Part2 inventory measurement record extension
 · exact uniqueCensus41Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
