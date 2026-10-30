import SFT.Mathematics.LimitComputations
namespace SFT.Mathematics.LimitContinuumWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := LimitComputations.finiteRungs
theorem check0Passed : check0 = true := LimitComputations.finiteRungsPassed
def check1 : Bool := LimitComputations.quadraticWitness
theorem check1Passed : check1 = true := LimitComputations.quadraticPassed
def check2 : Bool := LimitComputations.cubicWitness
theorem check2Passed : check2 = true := LimitComputations.cubicPassed
def check3 : Bool := LimitComputations.closureWitness
theorem check3Passed : check3 = true := LimitComputations.closurePassed
def witnesses : List Witness := [⟨"finite-rungs","Every generated dyadic rung through depth fourteen is positive and returns after its counted depth.",check0⟩,⟨"quadratic-curvature","The centered second difference of x squared is exactly two at every tested rational spacing.",check1⟩,⟨"cubic-convergence","The forward second-difference curvature of x cubed at the One has exact error six times the spacing, halving at each refinement.",check2⟩,⟨"finite-closure","The first five dyadic rungs plus the boundary rung reconstruct the One.",check3⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Mathematics.LimitContinuumWitnesses
