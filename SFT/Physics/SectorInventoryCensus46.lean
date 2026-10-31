import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus46Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus46Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus46Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus46Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus46Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus46Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus46Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus46Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus46 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus46Part0 inventory measurement record extension
 · exact decisionCensus46Part1 inventory measurement record extension
 · exact decisionCensus46Part2 inventory measurement record extension
 · exact decisionCensus46Part3 inventory measurement record extension
theorem uniqueCensus46 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.admitted,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus46Part0 inventory measurement record extension
 · exact uniqueCensus46Part1 inventory measurement record extension
 · exact uniqueCensus46Part2 inventory measurement record extension
 · exact uniqueCensus46Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
