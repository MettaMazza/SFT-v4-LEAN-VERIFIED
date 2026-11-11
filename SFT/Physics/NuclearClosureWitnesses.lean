import SFT.Physics.NuclearCompositions
namespace SFT.Physics.NuclearClosureWitnesses
open SFT.Physics.NuclearClosure
structure Witness where
 name : String
 statement : String
 passed : Bool

def thresholdCheck : Bool := match spinOrbitThreshold with
 | .ok n => n == 3
 | .error _ => false

def prefixCheck : Bool := match closurePrefix (.integer 8) with
 | .ok ns => ns == [2,8,20,28,50,82,126,184]
 | .error _ => false

def intermediateCheck : Bool := match closurePrefix (.integer 8) with
 | .ok ns => !(ns.any (fun n => 82<n && n<126))
 | .error _ => false

def witnesses : List Witness := [⟨"whole-gap-threshold","The exact two-thirds coupling reaches its first whole spin-orbit gap at angular count three.",thresholdCheck⟩,⟨"closure-prefix","The first eight generated closures are exact.",prefixCheck⟩,⟨"no-intermediate-generated-closure","The successor law has no closure strictly between 82 and 126.",intermediateCheck⟩]
theorem thresholdCheckPassed : thresholdCheck=true := rfl
theorem prefixCheckPassed : prefixCheck=true := rfl
theorem intermediateCheckPassed : intermediateCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.NuclearClosureWitnesses
