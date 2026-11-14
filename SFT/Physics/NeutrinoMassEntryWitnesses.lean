import SFT.Physics.NeutrinoLadder
namespace SFT.Physics.NeutrinoMassEntryWitnesses
open NeutrinoLadder
structure Witness where
 name : String
 statement : String
 passed : Bool
def identityCheck : Bool := match neutrinoMassSquares with
 | .error _ => false
 | .ok f => decide (f.lightest=originalMassSquares.lightest) && decide (f.middle=originalMassSquares.middle) && decide (f.heavy=originalMassSquares.heavy)
def witnesses : List Witness := [⟨"positive-order","All three exact mass squares are positive and ordered.",identityCheck⟩]
theorem identityCheckPassed : identityCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.NeutrinoMassEntryWitnesses
