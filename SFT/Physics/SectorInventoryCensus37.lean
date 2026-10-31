import SFT.Physics.SectorInventoryGrammarBase
namespace SFT.Physics.SectorInventoryGrammar
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem decisionCensus37Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus37Part0 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus37Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus37Part1 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.rejected,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus37Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus37Part2 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,.rejected,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus37Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals rfl
theorem uniqueCensus37Part3 (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,.admitted,.admitted,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases inventory <;> cases measurement <;> cases record <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
theorem decisionCensus37 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ := by
 cases mixing <;> cases mass
 · exact decisionCensus37Part0 inventory measurement record extension
 · exact decisionCensus37Part1 inventory measurement record extension
 · exact decisionCensus37Part2 inventory measurement record extension
 · exact decisionCensus37Part3 inventory measurement record extension
theorem uniqueCensus37 (mixing : Mixing) (mass : Mass) (inventory : Inventory) (measurement : Measurement) (record : Record) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.admitted,.rejected,.admitted,mixing,mass,inventory,measurement,record,extension⟩ : Candidate) = survivor := by
 cases mixing <;> cases mass
 · exact uniqueCensus37Part0 inventory measurement record extension
 · exact uniqueCensus37Part1 inventory measurement record extension
 · exact uniqueCensus37Part2 inventory measurement record extension
 · exact uniqueCensus37Part3 inventory measurement record extension
end SFT.Physics.SectorInventoryGrammar
