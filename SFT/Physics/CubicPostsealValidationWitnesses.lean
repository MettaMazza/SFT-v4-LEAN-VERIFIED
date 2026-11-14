import SFT.Physics.AtomicPostsealMeasurement
namespace SFT.Physics.CubicPostsealValidationWitnesses
open AtomicPostsealMeasurement
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"formal-count","The formal law remains exactly six.",formalCountCheck⟩,⟨"complete-nist-row","The registered NIST count is exactly six.",observedCountCheck⟩,⟨"postseal-equality","The sealed and observed positive counts are identical.",cubicEqualityCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (formalCountCheck && observedCountCheck && cubicEqualityCheck && true)=true
 rw [formalCountCheckPassed,observedCountCheckPassed,cubicEqualityCheckPassed]
 rfl
end SFT.Physics.CubicPostsealValidationWitnesses
