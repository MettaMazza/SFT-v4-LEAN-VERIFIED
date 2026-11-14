import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Physics.MolecularSpectroscopyEmpiricalWitnesses
open MolecularSpectroscopyMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"target-free-exact-vector","All four molecular carriers are exact positive fractions before source release.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (carrierCheck && true)=true
 rw [carrierCheckPassed]
 rfl
end SFT.Physics.MolecularSpectroscopyEmpiricalWitnesses
