import SFT.Physics.HadronReggeMeasurement
namespace SFT.Physics.HadronReggeEmpiricalWitnesses
open HadronReggeMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-multiplets-and-affine-support","The complete exact partitions and equal normalized successor already exist before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.HadronReggeEmpiricalWitnesses
