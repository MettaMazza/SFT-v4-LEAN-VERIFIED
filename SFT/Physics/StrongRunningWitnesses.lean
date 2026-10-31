import SFT.Physics.StrongRunning
namespace SFT.Physics.StrongRunningWitnesses
open StrongRunning
structure Witness where
 name : String
 statement : String
 passed : Bool
def exactCheck : Bool := colourPrefix 4 == [1,3,5,7]
theorem exactCheckPassed : exactCheck = true := rfl
def reducedCheck : Bool := (List.zip (colourPrefix 7) ((colourPrefix 7).drop 1)).all (fun p => p.2 - p.1 == 2)
theorem reducedCheckPassed : reducedCheck = true := rfl
def independentCheck : Bool := neutralPrefix 7 == [1,1,1,1,1,1,1]
theorem independentCheckPassed : independentCheck = true := rfl
def witnesses : List Witness := [⟨"colour-prefix","Four positive running levels yield the first four odd counts.",exactCheck⟩,⟨"binary-successor","Every colour successor adds exactly two.",reducedCheck⟩,⟨"neutral-hold","A neutral carrier retains the One across the same finite prefix.",independentCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Physics.StrongRunningWitnesses
