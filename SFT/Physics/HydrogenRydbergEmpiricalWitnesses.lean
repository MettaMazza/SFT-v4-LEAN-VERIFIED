import SFT.Physics.HydrogenRydbergMeasurement
namespace SFT.Physics.HydrogenRydbergEmpiricalWitnesses
open HydrogenRydbergMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-exact-scale","The terminal hydrogen scale is an exact positive interval before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.HydrogenRydbergEmpiricalWitnesses
