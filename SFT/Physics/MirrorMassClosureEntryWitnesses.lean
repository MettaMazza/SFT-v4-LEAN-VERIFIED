import SFT.Physics.MirrorMassClosure
namespace SFT.Physics.MirrorMassClosureEntryWitnesses
open MirrorMassClosure
structure Witness where
 name : String
 statement : String
 passed : Bool
def mirrorCheck : Bool := match mirrorMassClosure with
 | .error _ => false
 | .ok result => result.mirrorClosed
def witnesses : List Witness := [⟨"mirror","Positions and shortfalls are exact reversed tuples.",mirrorCheck⟩]
theorem mirrorCheckPassed : mirrorCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MirrorMassClosureEntryWitnesses
