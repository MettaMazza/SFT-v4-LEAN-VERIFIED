import SFT.Computation.NumericalError
namespace SFT.Computation.ScientificSymbolicWitnesses
open SFT.Computation.NumericalError SFT.Foundation.ExactOperations
structure Witness where
 name : String
 statement : String
 passed : Bool

def checks : Bool × Bool × Bool :=
 match exactErrorLedger [.positive (normalizePositive 1 2 (by decide) (by decide)),.positive (normalizePositive 2 3 (by decide) (by decide))]
     [.positive (normalizePositive 1 3 (by decide) (by decide)),.positive (normalizePositive 2 3 (by decide) (by decide))] with
 | .error _ => (false,false,false)
 | .ok rows => match rows with
   | [first,second] => (first.2.2 == "held-below",second.2.2 == "equal",first.2.1.numerator == 1 && first.2.1.denominator == 6)
   | [] | [_] | _::_::_::_ => (false,false,false)
def witnesses : List Witness := [
 ⟨"scientific_computation-witness-1","scientific_computation exact operational witness 1 for SFT-COMP-SCI-SYMBOLIC-001",checks.1⟩,
 ⟨"scientific_computation-witness-2","scientific_computation exact operational witness 2 for SFT-COMP-SCI-SYMBOLIC-001",checks.2.1⟩,
 ⟨"scientific_computation-witness-3","scientific_computation exact operational witness 3 for SFT-COMP-SCI-SYMBOLIC-001",checks.2.2⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := by decide
end SFT.Computation.ScientificSymbolicWitnesses
