import SFT.Computation.DynamicProgrammingTrace
namespace SFT.Computation.DynamicProgrammingWitnesses
structure Witness where
  name : String
  statement : String
  passed : Bool

def searchCheck : Bool := match SearchTrace.exactSearch ["a","b","c"] "b" with
 | .error _ => false
 | .ok result => decide (result = ("position-2","b"))
def recursion := OrderingTrace.structuralRecursion ["seed"] ["p1","p2"] (fun value position => value ++ [position])
def finalCheck : Bool := match recursion with
 | .error _ => false
 | .ok values => decide (values.getLast? = some ["seed","p1","p2"])
def countCheck : Bool := match recursion with
 | .error _ => false
 | .ok values => decide (values.length = 3)
def witnesses : List Witness := [
 ⟨"algorithms-witness-1","algorithms exact operational witness 1 for SFT-COMP-ALG-DYNAMIC-PROGRAMMING-001",searchCheck⟩,
 ⟨"algorithms-witness-2","algorithms exact operational witness 2 for SFT-COMP-ALG-DYNAMIC-PROGRAMMING-001",finalCheck⟩,
 ⟨"algorithms-witness-3","algorithms exact operational witness 3 for SFT-COMP-ALG-DYNAMIC-PROGRAMMING-001",countCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Computation.DynamicProgrammingWitnesses
