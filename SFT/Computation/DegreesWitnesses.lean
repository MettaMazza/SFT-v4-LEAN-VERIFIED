import SFT.Computation.DegreeClasses
namespace SFT.Computation.DegreesWitnesses
open RecognitionDomain
structure Witness where
  name : String
  statement : String
  passed : Bool

def traceCheck : Bool := match completeEnumeration ["machine-a","machine-b"] with
 | .error _ => false
 | .ok [] => false
 | .ok (row :: _) => decide (row.2 = "machine-a")
def wordsCheck : Bool := match selfNegatingBoundary "accept" with
 | .ok result => decide (result = "reject")
 | .error _ => false
def rewriteCheck : Bool := match selfNegatingBoundary "reject" with
 | .ok result => decide (result = "accept")
 | .error _ => false
def witnesses : List Witness := [
 ⟨"computability-witness-1","computability exact operational witness 1 for SFT-COMP-CBL-DEGREES-001",traceCheck⟩,
 ⟨"computability-witness-2","computability exact operational witness 2 for SFT-COMP-CBL-DEGREES-001",wordsCheck⟩,
 ⟨"computability-witness-3","computability exact operational witness 3 for SFT-COMP-CBL-DEGREES-001",rewriteCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Computation.DegreesWitnesses
