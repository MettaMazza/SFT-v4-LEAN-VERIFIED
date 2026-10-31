import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus50Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus50Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus50Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus50Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus50Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus50Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus50Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus50Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus50 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus50Part0 inventory measurement record extension
 · exact decisionCensus50Part1 inventory measurement record extension
 · exact decisionCensus50Part2 inventory measurement record extension
 · exact decisionCensus50Part3 inventory measurement record extension
theorem uniqueCensus50 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.admitted,.rejected,.rejected,.admitted,.rejected,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus50Part0 inventory measurement record extension
 · exact uniqueCensus50Part1 inventory measurement record extension
 · exact uniqueCensus50Part2 inventory measurement record extension
 · exact uniqueCensus50Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
