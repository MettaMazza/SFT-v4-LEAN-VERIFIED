import SFT.Physics.TerminalProtonMeasurement
namespace SFT.Physics.TerminalProtonEmpiricalWitnesses
open TerminalProtonMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-positive-dressing","The exact dressing is generated without opening the source record.",contributionCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (contributionCheck && true)=true
 rw [contributionCheckPassed]
 rfl
end SFT.Physics.TerminalProtonEmpiricalWitnesses
