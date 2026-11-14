import SFT.Physics.VacuumAuthoritativeWitnesses
namespace SFT.Physics.VacuumExtractionValidationWitnesses
open VacuumAuthoritativeWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-work-vector","The adverse work row and favorable complete-cycle boundary are both retained.",extractionCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (extractionCheck && true)=true
 rw [extractionCheckPassed]
 rfl
end SFT.Physics.VacuumExtractionValidationWitnesses
