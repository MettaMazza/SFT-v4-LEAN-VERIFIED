import SFT.Mathematics.SelfSimilarConvergence
namespace SFT.Mathematics.SelfSimilarWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := SelfSimilarConvergence.originalLocalWitness
theorem check0Passed : check0 = true := SelfSimilarConvergence.originalLocalWitnessPassed
def check1 : Bool := SelfSimilarConvergence.originalSupportWitness
theorem check1Passed : check1 = true := SelfSimilarConvergence.originalSupportWitnessPassed
def check2 : Bool := SelfSimilarConvergence.originalExponentWitness
theorem check2Passed : check2 = true := SelfSimilarConvergence.originalExponentWitnessPassed
def check3 : Bool := SelfSimilarConvergence.originalGapWitness
theorem check3Passed : check3 = true := SelfSimilarConvergence.originalGapWitnessPassed
def check4 : Bool := SelfSimilarConvergence.originalBracketWitness
theorem check4Passed : check4 = true := SelfSimilarConvergence.originalBracketWitnessPassed
def witnesses : List Witness := [⟨"chaotic-rate","The separation two-of-thirty-five advances to four-of-thirty-five before cast.",check0⟩,⟨"support","Ternary support has three, nine and twenty-seven states at depths one, two and three.",check1⟩,⟨"unit-power","Only exponent One among whole exponents One through four gives exact halving when rank doubles.",check2⟩,⟨"gap-formula","The exact gap formula is positive and strictly decreases through depth fourteen.",check3⟩,⟨"finite-bracket","The first eleven exact gap terms sum below eleven-of-sixty.",check4⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Mathematics.SelfSimilarWitnesses
