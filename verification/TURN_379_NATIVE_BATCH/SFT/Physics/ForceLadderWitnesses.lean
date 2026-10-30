import SFT.Physics.PrimeSectorLadder
namespace SFT.Physics.ForceLadderWitnesses
open PrimeSectorLadder
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match PlanckHierarchy.upperCoverDepth with | .error _ => false | .ok d => d == 7
def check1 : Bool := match primeSectorLadder with | .error _ => false | .ok ps => ps == [2,3,5,7]
def check2 : Bool := match mediatorRecord with | .error _ => false | .ok ms => ms == [3,8,24,48]
def check3 : Bool := match couplingRecord with | .error _ => false | .ok cs => cs.map (fun q => (q.1.natAbs,q.2)) == [(1,2),(2,3),(4,5),(6,7)]
def witnesses : List Witness := [⟨"ceiling","The generator-successor volume has least binary cover seven.",check0⟩,⟨"ladder","Complete prime enumeration through the ceiling yields four sectors.",check1⟩,⟨"mediators","Pair-cell predecessor counts close exactly.",check2⟩,⟨"couplings","Each sector partitions the One through its predecessor share.",check3⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem check2Passed : check2 = true := rfl
theorem check3Passed : check3 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && check3 && true) = true
 rw [check0Passed,check1Passed,check2Passed,check3Passed]
 rfl
end SFT.Physics.ForceLadderWitnesses
