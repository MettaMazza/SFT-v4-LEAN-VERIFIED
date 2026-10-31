import SFT.Physics.CosmicRatios
namespace SFT.Physics.HubbleWitnesses
open CosmicRatios
set_option maxRecDepth 100000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match hubbleStructure with | .error _ => false | .ok h => pair (AlphaRatio.add h.matterShare h.vacuumShare) == (1,1)
def check1 : Bool := match hubbleStructure with | .error _ => false | .ok h => pair h.leadingCorrection == (1,12) && pair h.leadingRatio == (13,12)
def check2 : Bool := match hubbleStructure with | .error _ => false | .ok h => h.orbitTrace.length == 7
def check3 : Bool := match hubbleStructure with | .error _ => false | .ok h => pair h.refinedRatio == (3305,3048)
def witnesses : List Witness := [⟨"complete-partition","The exact formed and open shares close to the One.",check0⟩,⟨"leading-ratio","The complete leading construction is exactly thirteen-twelfths.",check1⟩,⟨"depth-seven-orbit","The unit part over 127 has exact first-return period seven.",check2⟩,⟨"refined-ratio","The one-recurrence deepening is exactly 3305/3048.",check3⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem check2Passed : check2 = true := rfl
theorem check3Passed : check3 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && check3 && true) = true
 rw [check0Passed,check1Passed,check2Passed,check3Passed]
 rfl
end SFT.Physics.HubbleWitnesses
