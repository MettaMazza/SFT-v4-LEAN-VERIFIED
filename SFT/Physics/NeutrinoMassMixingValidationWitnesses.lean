import SFT.Physics.NeutrinoComparisonMeasurement
namespace SFT.Physics.NeutrinoMassMixingValidationWitnesses
open NeutrinoComparisonMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-classification","The full comparison vector recomputes its exact classification.",neutrinoCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (neutrinoCheck && true)=true
 rw [neutrinoCheckPassed]
 rfl
end SFT.Physics.NeutrinoMassMixingValidationWitnesses
