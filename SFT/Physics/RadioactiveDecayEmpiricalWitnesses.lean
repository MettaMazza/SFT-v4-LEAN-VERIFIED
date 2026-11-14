import SFT.Physics.RadioactiveEmpiricalWitnesses
namespace SFT.Physics.RadioactiveDecayEmpiricalWitnesses
open RadioactiveEmpiricalWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-three-topology-and-survival-law","Three primitive transition classes and exact survival 1/2^k exist before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.RadioactiveDecayEmpiricalWitnesses
