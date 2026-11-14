import SFT.Physics.NeutrinolessBounds
namespace SFT.Physics.ZeroNuEntryWitnesses
open NeutrinolessBounds
structure Witness where
 name : String
 statement : String
 passed : Bool
def identityCheck : Bool := match zeroNuNoncancellation with
 | .error _ => false
 | .ok f => SFT.Physics.LeptonIntervals.zero.blt f.positiveFloorCoefficient
def witnesses : List Witness := [⟨"noncancellation","The exact rational lower coefficient is strictly positive.",identityCheck⟩]
theorem identityCheckPassed : identityCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.ZeroNuEntryWitnesses
