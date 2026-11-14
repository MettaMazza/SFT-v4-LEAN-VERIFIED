import SFT.Physics.ProtonComparisonMeasurement
namespace SFT.Physics.ProtonPrecisionValidationWitnesses
open ProtonComparisonMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-classification","The full comparison vector recomputes its exact classification.",protonCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (protonCheck && true)=true
 rw [protonCheckPassed]
 rfl
end SFT.Physics.ProtonPrecisionValidationWitnesses
