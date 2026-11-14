import SFT.Physics.NuclearResidualForceMeasurement
namespace SFT.Physics.NuclearResidualForceEmpiricalWitnesses
open NuclearResidualForceMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-residual-and-range-order","Quarter-order neutral exchange and exact reciprocal ordering exist before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.NuclearResidualForceEmpiricalWitnesses
