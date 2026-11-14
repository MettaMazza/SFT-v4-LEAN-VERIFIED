import SFT.Physics.FieldAuthoritativeWitnesses
namespace SFT.Physics.OpticsValidationWitnesses
open FieldAuthoritativeWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-optics-vector","Interference, mixing and the coefficient boundary remain jointly classified.",opticsCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (opticsCheck && true)=true
 rw [opticsCheckPassed]
 rfl
end SFT.Physics.OpticsValidationWitnesses
