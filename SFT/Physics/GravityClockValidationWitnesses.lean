import SFT.Physics.GravityAuthoritativeWitnesses
namespace SFT.Physics.GravityClockValidationWitnesses
open GravityAuthoritativeWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-clock-vector","Measurement and scope rows remain jointly classified.",clockCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (clockCheck && true)=true
 rw [clockCheckPassed]
 rfl
end SFT.Physics.GravityClockValidationWitnesses
