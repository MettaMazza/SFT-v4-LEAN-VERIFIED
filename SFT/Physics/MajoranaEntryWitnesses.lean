import SFT.Physics.MajoranaStructure
namespace SFT.Physics.MajoranaEntryWitnesses
open MajoranaStructure
structure Witness where
 name : String
 statement : String
 passed : Bool
def identityCheck : Bool := match majoranaStructure with
 | .error _ => false
 | .ok f => decide (f.diracPairSeparation=some (⟨1,2,by decide,by decide⟩ : Rat)) && f.selfAntipodalLock && !f.genericHandSelfAntipodal
def witnesses : List Witness := [⟨"majorana","All discriminator conditions close exactly.",identityCheck⟩]
theorem identityCheckPassed : identityCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MajoranaEntryWitnesses
