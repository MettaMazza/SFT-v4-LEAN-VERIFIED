import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus38Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus38Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus38Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus38Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus38Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus38Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus38Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus38Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus38 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus38Part0 inventory measurement record extension
 · exact decisionCensus38Part1 inventory measurement record extension
 · exact decisionCensus38Part2 inventory measurement record extension
 · exact decisionCensus38Part3 inventory measurement record extension
theorem uniqueCensus38 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus38Part0 inventory measurement record extension
 · exact uniqueCensus38Part1 inventory measurement record extension
 · exact uniqueCensus38Part2 inventory measurement record extension
 · exact uniqueCensus38Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
