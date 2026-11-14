import SFT.Physics.GravityAuthoritativeWitnesses
namespace SFT.Physics.GravityHorizonValidationWitnesses
open GravityAuthoritativeWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-horizon-vector","Favorable strong-field and unmeasured rows remain jointly classified.",horizonCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (horizonCheck && true)=true
 rw [horizonCheckPassed]
 rfl
end SFT.Physics.GravityHorizonValidationWitnesses
