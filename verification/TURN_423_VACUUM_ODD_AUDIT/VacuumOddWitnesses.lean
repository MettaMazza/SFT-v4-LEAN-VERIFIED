import SFT.Physics.VacuumOddOrbit
namespace SFT.Physics.VacuumOddWitnesses
open VacuumOddOrbit
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match outputPairs (oddDenominatorOrbit (.integer 3)) with | .error _ => false | .ok xs => xs == [(2,3),(1,3)]
def check1 : Bool := match oddDenominatorOrbit (.integer 5) with | .error _ => false | .ok xs => xs.length == 4
def check2 : Bool := match oddDenominatorOrbit (.integer 7) with | .error _ => false | .ok xs => xs.length == 3
def check3 : Bool := (List.range 15).all (fun n => let d := 2*n+3; match outputPairs (oddDenominatorOrbit (.integer (.ofNat d))) with | .error _ => false | .ok xs => xs.getLast? == some (1,d))
def witnesses : List Witness := [⟨"three","The first odd mode is a strict positive two-cycle.",check0⟩,⟨"five","The denominator-five mode closes in four transitions.",check1⟩,⟨"seven","The generator-three mode closes in three transitions.",check2⟩,⟨"odd-prefix","Every generated odd denominator through thirty-one returns without leaving the domain.",check3⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem check2Passed : check2 = true := rfl
theorem check3Passed : check3 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && check3 && true) = true
 rw [check0Passed,check1Passed,check2Passed,check3Passed]
 rfl
end SFT.Physics.VacuumOddWitnesses
