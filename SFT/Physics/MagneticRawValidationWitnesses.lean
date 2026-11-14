import SFT.Physics.MagneticComparisonMeasurement
namespace SFT.Physics.MagneticRawValidationWitnesses
open MagneticComparisonMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-classification","The full comparison vector recomputes its exact classification.",magneticCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (magneticCheck && true)=true
 rw [magneticCheckPassed]
 rfl
end SFT.Physics.MagneticRawValidationWitnesses
