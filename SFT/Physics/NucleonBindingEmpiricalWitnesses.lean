import SFT.Physics.NucleonBindingMeasurement
namespace SFT.Physics.NucleonBindingEmpiricalWitnesses
open NucleonBindingMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-ledger-and-order","The exact structural dominance and neutron/proton ordering exist before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.NucleonBindingEmpiricalWitnesses
