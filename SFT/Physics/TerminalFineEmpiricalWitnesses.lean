import SFT.Physics.TerminalFineMeasurement
namespace SFT.Physics.TerminalFineEmpiricalWitnesses
open TerminalFineMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-exact-carrier","The fine carrier is exact and positive before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.TerminalFineEmpiricalWitnesses
