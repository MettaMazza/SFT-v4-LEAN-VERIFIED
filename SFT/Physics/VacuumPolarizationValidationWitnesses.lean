import SFT.Physics.VacuumAuthoritativeWitnesses
namespace SFT.Physics.VacuumPolarizationValidationWitnesses
open VacuumAuthoritativeWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"nonoverlap","The complete low-energy inverse interval lies above the Z-scale interval.",nonoverlapCheck⟩,⟨"direct-observation","The PDG direct-running row is retained.",polarizationCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (nonoverlapCheck && polarizationCheck && true)=true
 rw [nonoverlapCheckPassed,polarizationCheckPassed]
 rfl
end SFT.Physics.VacuumPolarizationValidationWitnesses
