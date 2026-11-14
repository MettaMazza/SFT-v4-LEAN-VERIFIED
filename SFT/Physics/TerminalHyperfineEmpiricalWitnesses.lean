import SFT.Physics.TerminalHyperfineMeasurement
namespace SFT.Physics.TerminalHyperfineEmpiricalWitnesses
open TerminalHyperfineMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-exact-carrier","The hyperfine carrier is exact and positive before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.TerminalHyperfineEmpiricalWitnesses
