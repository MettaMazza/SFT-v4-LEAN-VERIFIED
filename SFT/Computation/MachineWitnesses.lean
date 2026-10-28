import SFT.Computation.MachineExecution
namespace SFT.Computation.MachineWitnesses
open StateTransition StateWords
structure Witness where
  name : String
  statement : String
  passed : Bool

def traceCheck : Bool := match create ["held","returned"] ["fold"] [("held","fold","returned"),("returned","fold","held")] with
 | .error _ => false
 | .ok system => match run system "held" ["fold","fold"] with
   | .error _ => false
   | .ok trace => decide (trace = ["held","returned","held"])
def wordsCheck : Bool := match generatedWords ["held","returned"] ["place-1","place-2"] with
 | .error _ => false
 | .ok words => decide (words.length = 7)
def rewriteCheck : Bool := match exactRewrite ["held","held"] "place-2" ["place-1","place-2"] "returned" with
 | .error _ => false
 | .ok word => decide (word = ["held","returned"])
def witnesses : List Witness := [
 ⟨"formal_computation-witness-1","formal_computation exact operational witness 1 for SFT-COMP-FORM-ABSTRACT-MACHINE-001",traceCheck⟩,
 ⟨"formal_computation-witness-2","formal_computation exact operational witness 2 for SFT-COMP-FORM-ABSTRACT-MACHINE-001",wordsCheck⟩,
 ⟨"formal_computation-witness-3","formal_computation exact operational witness 3 for SFT-COMP-FORM-ABSTRACT-MACHINE-001",rewriteCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Computation.MachineWitnesses
