import SFT.Physics.CosmicRatios
namespace SFT.Physics.DarkBaryonWitnesses
open CosmicRatios
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match darkBaryonStructure with | .error _ => false | .ok d => pair (AlphaRatio.add d.baryonShare d.darkShare) == (1,1)
def check1 : Bool := match darkBaryonStructure with | .error _ => false | .ok d => d.orbitTrace.length == 5
def check2 : Bool := match darkBaryonStructure with | .error _ => false | .ok d => pair d.leadingRatio == (27,5) && pair d.refinedRatio == (279,52)
def witnesses : List Witness := [⟨"complete-partition","The forced depth and volume shares sum exactly to the One.",check0⟩,⟨"native-orbit","The unit part over 31 has exact first-return period five.",check1⟩,⟨"exact-ratios","Both leading and first-recursive ratios reconstruct exactly.",check2⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem check2Passed : check2 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && true) = true
 rw [check0Passed,check1Passed,check2Passed]
 rfl
end SFT.Physics.DarkBaryonWitnesses
