import SFT.Physics.TerminalCKMMeasurement
namespace SFT.Physics.TerminalCKMEmpiricalWitnesses
open TerminalCKMMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-relation","The exact terminal contribution is positive and generated without opening the target record.",contributionCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (contributionCheck && true)=true
 rw [contributionCheckPassed]
 rfl
end SFT.Physics.TerminalCKMEmpiricalWitnesses
