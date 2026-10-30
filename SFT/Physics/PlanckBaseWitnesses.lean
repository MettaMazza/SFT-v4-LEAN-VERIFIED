import SFT.Physics.PlanckHierarchy
namespace SFT.Physics.PlanckBaseWitnesses
open PlanckHierarchy
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match upperCoverDepth with | .error _ => false | .ok d => d == 7
def check1 : Bool := match massiveStateCount with | .error _ => false | .ok d => d == 127
def check2 : Bool := match squaredHierarchy with | .error _ => false | .ok d => d == 170141183460469231731687303715884105728
def witnesses : List Witness := [⟨"depth","The independently generated upper cover depth is seven.",check0⟩,⟨"massive-count","The complete depth-seven support has positive predecessor 127.",check1⟩,⟨"exact-square","The hierarchy square is the exact whole 2^127.",check2⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem check2Passed : check2 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && true) = true
 rw [check0Passed,check1Passed,check2Passed]
 rfl
end SFT.Physics.PlanckBaseWitnesses
