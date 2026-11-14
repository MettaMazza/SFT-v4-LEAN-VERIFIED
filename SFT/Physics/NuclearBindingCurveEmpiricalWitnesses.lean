import SFT.Physics.NuclearBindingEmpiricalWitnesses
namespace SFT.Physics.NuclearBindingCurveEmpiricalWitnesses
open NuclearBindingEmpiricalWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-exact-coordinate","The exact A=62, Z=28, N=34 coordinate and rational score separation exist before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.NuclearBindingCurveEmpiricalWitnesses
