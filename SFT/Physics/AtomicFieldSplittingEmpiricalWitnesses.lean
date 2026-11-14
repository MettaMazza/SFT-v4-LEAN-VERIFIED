import SFT.Physics.AtomicFieldSplittingMeasurement
namespace SFT.Physics.AtomicFieldSplittingEmpiricalWitnesses
open AtomicFieldSplittingMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-field-orders","The formal linear and quadratic scaling relations exist exactly before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.AtomicFieldSplittingEmpiricalWitnesses
