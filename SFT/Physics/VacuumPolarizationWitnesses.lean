import SFT.Physics.VacuumPolarization
namespace SFT.Physics.VacuumPolarizationWitnesses
open VacuumPolarization
structure Witness where
 name : String
 statement : String
 passed : Bool
def exactCheck : Bool := match support with | .error _ => false | .ok p => p.1.numerator == 1 && p.1.denominator == 2
theorem exactCheckPassed : exactCheck = true := rfl
def reducedCheck : Bool := match support with | .error _ => false | .ok p => p.2.numerator == 1 && p.2.denominator == 1
theorem reducedCheckPassed : reducedCheck = true := rfl
def independentCheck : Bool := match support with | .error _ => false | .ok p => p.1.numerator * p.2.denominator < p.2.numerator * p.1.denominator
theorem independentCheckPassed : independentCheck = true := rfl
def witnesses : List Witness := [⟨"screened","The screened carrier is the exact vacuum floor.",exactCheck⟩,⟨"exposed","One Fold exposure returns complete bare support.",reducedCheck⟩,⟨"direction","Exposed support is strictly greater than screened support.",independentCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Physics.VacuumPolarizationWitnesses
