import SFT.Physics.MatterAuthoritativeWitnesses
namespace SFT.Physics.QuarkCKMValidationWitnesses
open MatterAuthoritativeWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-classification","The full comparison vector recomputes its exact classification.",quarkCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (quarkCheck && true)=true
 rw [quarkCheckPassed]
 rfl
end SFT.Physics.QuarkCKMValidationWitnesses
