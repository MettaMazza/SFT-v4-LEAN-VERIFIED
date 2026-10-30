import SFT.Physics.QuarkIsolation
namespace SFT.Physics.QuarkCubicsWitnesses
open QuarkIsolation
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match QuarkInvariants.cubicInvariants with | .error _ => false | .ok c => QuarkInvariants.cubicRecord c == (((1,1),(1,8),(1,383)),((1,1),(1,12),(1,3071)))
def check1 : Bool := match rootBrackets with | .error _ => false | .ok (down,up) => down.length == 3 && up.length == 3
def witnesses : List Witness := [⟨"invariants","Both exact invariant triples close.",check0⟩,⟨"roots","Both exact cubics have three disjoint positive isolating intervals.",check1⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && true) = true
 rw [check0Passed,check1Passed]
 rfl
end SFT.Physics.QuarkCubicsWitnesses
