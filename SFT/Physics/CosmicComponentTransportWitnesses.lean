import SFT.Physics.CosmicComponentTransport
namespace SFT.Physics.CosmicComponentTransportWitnesses
open CosmicComponentTransport
set_option maxRecDepth 20000
set_option maxHeartbeats 8000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def passed : Except String Bool → Bool
 | .error _ => false
 | .ok value => value
def lawAt : List ComponentLaw → Nat → Option ComponentLaw
 | [],_ => none
 | x::_,0 => some x
 | _::xs,n+1 => lawAt xs n
def firstPower (index : Nat) : Option Nat :=
 match lawAt componentLaws index with
 | none => none
 | some row => match row.transportPower with
   | .positive n _ => some n
   | .emptyDilutionOneForm => none
def check0 : Bool := passed do
 let vacuum ← vacuumTransport (LeptonIntervals.normalize 37 19 (by decide))
 .ok (firstPower 0 == some 3 && firstPower 1 == some 4 && vacuum == LeptonIntervals.normalize 1 1 (by decide))
def check1 : Bool := passed do
 let rate ← lateSquaredExpansion (LeptonIntervals.normalize 1 1 (by decide))
 .ok (LeptonIntervals.add matterToday vacuumToday == LeptonIntervals.normalize 1 1 (by decide) && rate == LeptonIntervals.normalize 1 1 (by decide))
def check2 : Bool := passed do
 let equality ← matterVacuumEqualityCube
 let onset ← accelerationOnsetCube
 .ok (equality == LeptonIntervals.normalize 11 5 (by decide) && onset == LeptonIntervals.normalize 22 5 (by decide))
def check3 : Bool := passed do
 let magnitude ← presentAccelerationMagnitude
 .ok (magnitude == LeptonIntervals.normalize 17 32 (by decide))
def check4 : Bool := passed do
 let stretches := [LeptonIntervals.normalize 1 1 (by decide),LeptonIntervals.normalize 3 2 (by decide),LeptonIntervals.normalize 2 1 (by decide),LeptonIntervals.normalize 3 1 (by decide)]
 let rows ← stretches.mapM fun r => do
  let matter ← matterFraction r
  let vacuum ← vacuumFraction r
  .ok (LeptonIntervals.add matter vacuum == LeptonIntervals.normalize 1 1 (by decide))
 .ok (rows.all id)
def witnesses : List Witness := [⟨"component-powers","Three-space, one recurrence and the invariant force matter/radiation/vacuum transport.",check0⟩,⟨"present-closure","The terminal shares and present squared rate close exactly to the One.",check1⟩,⟨"thresholds","The terminal shares force both exact cube thresholds.",check2⟩,⟨"acceleration","Today's typed accelerating separation is exactly 17/32.",check3⟩,⟨"fraction-closure","Matter and vacuum fractions close to the One at every sampled exact stretch.",check4⟩]
theorem check0Passed : check0=true := rfl
theorem check1Passed : check1=true := rfl
theorem check2Passed : check2=true := rfl
theorem check3Passed : check3=true := rfl
theorem check4Passed : check4=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (check0 && check1 && check2 && check3 && check4 && true)=true
 rw [check0Passed,check1Passed,check2Passed,check3Passed,check4Passed]
 rfl
end SFT.Physics.CosmicComponentTransportWitnesses
