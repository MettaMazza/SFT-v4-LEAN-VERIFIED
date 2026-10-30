import SFT.Physics.QuarkIsolation
namespace SFT.Physics.QuarkChannelsWitnesses
open QuarkIsolation
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match QuarkInvariants.channelInvariants with | .error _ => false | .ok c => QuarkInvariants.channelRecord c == ((1,12),(1,8),7,5)
def witnesses : List Witness := [⟨"values","All four invariant values close exactly.",check0⟩]
theorem check0Passed : check0 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && true) = true
 rw [check0Passed]
 rfl
end SFT.Physics.QuarkChannelsWitnesses
