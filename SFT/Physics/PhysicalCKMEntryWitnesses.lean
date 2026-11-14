import SFT.Physics.MatterIdentityGraphs
namespace SFT.Physics.PhysicalCKMEntryWitnesses
open MatterIdentityGraphs
structure Witness where
 name : String
 statement : String
 passed : Bool
def identityCheck : Bool := match ckmPhysicalIdentity with
 | .error _ => false
 | .ok f => decide (f.apexSquared=(⟨1,6,by decide,by decide⟩ : Rat))
def witnesses : List Witness := [⟨"apex","The squared apex is the reciprocal of six counted channels.",identityCheck⟩]
theorem identityCheckPassed : identityCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.PhysicalCKMEntryWitnesses
