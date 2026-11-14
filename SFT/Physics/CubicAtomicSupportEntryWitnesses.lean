import SFT.Physics.CubicAtomicSupport
namespace SFT.Physics.CubicAtomicSupportEntryWitnesses
open CubicAtomicSupport LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
def coordinationCheck : Bool := match cubicCoordination with
 | .error _ => false
 | .ok n => n == 6
def weightCheck : Bool := match cubicNeighbourWeight with
 | .error _ => false
 | .ok q => q == normalize 1 12 (by decide)
def balanceCheck : Bool := match cubicBalance with
 | .error _ => false
 | .ok q => q == normalize 1 2 (by decide)
def witnesses : List Witness := [⟨"coordination","Binary directions on three axes force six neighbours.",coordinationCheck⟩,⟨"neighbour-weight","Each complete neighbour receives one-twelfth.",weightCheck⟩,⟨"half-balance","All six neighbour weights recompose the half-One.",balanceCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.CubicAtomicSupportEntryWitnesses
