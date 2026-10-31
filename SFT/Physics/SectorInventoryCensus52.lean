import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus52Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus52Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus52Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus52Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus52Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus52Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus52Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus52Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus52 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus52Part0 inventory measurement record extension
 · exact decisionCensus52Part1 inventory measurement record extension
 · exact decisionCensus52Part2 inventory measurement record extension
 · exact decisionCensus52Part3 inventory measurement record extension
theorem uniqueCensus52 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.admitted,.rejected,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus52Part0 inventory measurement record extension
 · exact uniqueCensus52Part1 inventory measurement record extension
 · exact uniqueCensus52Part2 inventory measurement record extension
 · exact uniqueCensus52Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
