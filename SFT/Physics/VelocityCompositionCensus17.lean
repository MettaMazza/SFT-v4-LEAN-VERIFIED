import SFT.Physics.VelocityCompositionGrammarBase
namespace SFT.Physics.VelocityCompositionGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionChunk17 (limit : Limit) (closure : Closure) (associativity : Associativity) (record : Record) (measurement : Measurement) (extension : Extension) : survives ⟨.admitted,.rejected,.rejected,.rejected,.admitted,limit,closure,associativity,record,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,.admitted,limit,closure,associativity,record,measurement,extension⟩ := by
 cases limit <;> cases closure <;> cases associativity <;> cases record <;> cases measurement <;> cases extension <;> rfl
theorem uniqueCriteriaChunk17 (limit : Limit) (closure : Closure) (associativity : Associativity) (record : Record) (measurement : Measurement) (extension : Extension) : criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,.admitted,limit,closure,associativity,record,measurement,extension⟩ = true ↔ (⟨.admitted,.rejected,.rejected,.rejected,.admitted,limit,closure,associativity,record,measurement,extension⟩ : Candidate) = survivor := by
 cases limit <;> cases closure <;> cases associativity <;> cases record <;> cases measurement <;> cases extension
 all_goals constructor <;> intro h <;> first | rfl | cases h
end SFT.Physics.VelocityCompositionGrammar
