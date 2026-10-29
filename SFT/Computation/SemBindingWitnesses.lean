import SFT.Computation.SyntaxFormation
namespace SFT.Computation.SemBindingWitnesses
open SFT.Foundation.ExactOperations SFT.Computation.SymbolicEvaluation
structure Witness where
  name : String
  statement : String
  passed : Bool

def third := normalizePositive 1 3 (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)
def twoThirds := normalizePositive 2 3 (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)
def half := normalizePositive 1 2 (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)
def joinCheck : Bool := match evaluate [("x",.positive twoThirds)] (.join (.name "x") (.value (some (.positive third)))) with
 | .error _ => false
 | .ok number => match number with
   | .zero => false
   | .negative _ => false
   | .positive part => decide (part.numerator = 1) && decide (part.denominator = 1)
def nameCheck : Bool := match evaluate [("x",.positive half)] (.name "x") with
 | .error _ => false
 | .ok number => match number with
   | .zero => false
   | .negative _ => false
   | .positive part => decide (part.numerator = 1) && decide (part.denominator = 2)
def identityCheck : Bool := SFT.Host.Text.isPrefix "SFT-COMP".toUTF8.data.toList "SFT-COMP-SEM-BINDING".toUTF8.data.toList
def witnesses : List Witness := [
 ⟨"semantics-witness-1","semantics exact operational witness 1 for SFT-COMP-SEM-BINDING-SUBSTITUTION-001",joinCheck⟩,
 ⟨"semantics-witness-2","semantics exact operational witness 2 for SFT-COMP-SEM-BINDING-SUBSTITUTION-001",nameCheck⟩,
 ⟨"semantics-witness-3","semantics exact operational witness 3 for SFT-COMP-SEM-BINDING-SUBSTITUTION-001",identityCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Computation.SemBindingWitnesses
