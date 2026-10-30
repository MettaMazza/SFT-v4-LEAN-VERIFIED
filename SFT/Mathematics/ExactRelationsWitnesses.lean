import SFT.Mathematics.HoldingComplement
import Init.Data.Nat.Lcm
namespace SFT.Mathematics.ExactRelationsWitnesses
open ExactRatioRelations
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := let z := compose (ratio 3 2 (by decide) (by decide)) (ratio 2 3 (by decide) (by decide)); z.numerator == 1 && z.denominator == 1
theorem check0Passed : check0 = true := rfl
def check1 : Bool := let z := compose (ratio 8 1 (by decide) (by decide)) (ratio 1 8 (by decide) (by decide)); z.numerator == 1 && z.denominator == 1
theorem check1Passed : check1 = true := rfl
def check2 : Bool := let z := compose (ratio 5 3 (by decide) (by decide)) (ratio 3 2 (by decide) (by decide)); z.numerator == 5 && z.denominator == 2
theorem check2Passed : check2 = true := rfl
def check3 : Bool := let z := HoldingComplement.complement 0; z.numerator == 1 && z.denominator == 2
theorem check3Passed : check3 = true := rfl
def check4 : Bool := Nat.lcm (Nat.lcm 2 3) 4 == 12
theorem check4Passed : check4 = true := rfl
def witnesses : List Witness := [⟨"reciprocal","The ratio three-of-two composed with two-of-three returns the One.",check0⟩,⟨"count-measure","Eight equal one-of-eight parts reconstruct the One.",check1⟩,⟨"telescoping","The exact views five-of-three and three-of-two compose to five-of-two.",check2⟩,⟨"threshold","The binary holding complement is the unique one-of-two part.",check3⟩,⟨"joint-return","Periods two, three and four first return together at twelve.",check4⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Mathematics.ExactRelationsWitnesses
