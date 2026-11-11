import SFT.Physics.AtomicOrbitCapacity
namespace SFT.Physics.AtomicOrbitCapacityWitnesses
open SFT.Physics.AtomicOrbitCapacity
structure Witness where
 name : String
 statement : String
 passed : Bool

def capacity (n : Nat) := orbitCapacity (.integer (.ofNat n))
def orientationsAt (n : Nat) := orientationCount (.integer (.ofNat n))
def firstFive : Bool := match [1,2,3,4,5].mapM capacity with
 | .ok values => values == [2,6,10,14,18]
 | .error _ => false
def successorCheck : Bool := ((List.range 11).map (fun n => n+1)).all (fun n =>
 match capacity (n+1) with
 | .error _ => false
 | .ok next => match capacity n with
   | .error _ => false
   | .ok current => next == current+4)
def supportCheck : Bool := ((List.range 11).map (fun n => n+1)).all (fun n =>
 match capacity n with
 | .error _ => false
 | .ok actual => match orientationsAt n with
   | .error _ => false
   | .ok os => match binaryCount with
     | .error _ => false
     | .ok labels => actual == os*labels)
def witnesses : List Witness := [⟨"first-five-capacities","The first five positive ranks generate 2, 6, 10, 14 and 18.",firstFive⟩,⟨"successor-increment","Every tested successor adds exactly four, as proved for arbitrary positive rank by the boundary-pair construction.",successorCheck⟩,⟨"complete-cell-support","Capacity equals the complete product of orientations and the two held labels.",supportCheck⟩]
theorem firstFivePassed : firstFive=true := rfl
theorem successorCheckPassed : successorCheck=true := rfl
theorem supportCheckPassed : supportCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.AtomicOrbitCapacityWitnesses
