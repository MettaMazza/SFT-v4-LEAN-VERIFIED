import SFT.Physics.MajoranaComparisonMeasurement
namespace SFT.Physics.MajoranaStatusValidationWitnesses
open MajoranaComparisonMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-classification","The full comparison vector recomputes its exact classification.",majoranaCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (majoranaCheck && true)=true
 rw [majoranaCheckPassed]
 rfl
end SFT.Physics.MajoranaStatusValidationWitnesses
