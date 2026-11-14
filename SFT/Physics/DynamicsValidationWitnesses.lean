import SFT.Physics.FieldAuthoritativeWitnesses
namespace SFT.Physics.DynamicsValidationWitnesses
open FieldAuthoritativeWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-dynamics-vector","The favorable and scope-limiting rows remain jointly classified.",dynamicsCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (dynamicsCheck && true)=true
 rw [dynamicsCheckPassed]
 rfl
end SFT.Physics.DynamicsValidationWitnesses
