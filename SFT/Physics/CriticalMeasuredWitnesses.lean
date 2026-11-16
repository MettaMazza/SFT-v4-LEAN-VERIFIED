import SFT.Physics.CriticalityUniversality
namespace SFT.Physics.CriticalMeasuredWitnesses
open CriticalityUniversality LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def criticalVector : Bool := let v := meanFieldExponents; v.beta == normalize 1 2 (by decide) && v.gamma == normalize 1 1 (by decide) && v.nu == normalize 1 2 (by decide) && v.delta == normalize 3 1 (by decide)
def cascadeVector : Bool := add cascadeExponents.structureFunction (normalize 1 1 (by decide)) == cascadeExponents.spectrumMagnitude
def witnesses : List Witness := [⟨"critical-vector","The formal critical vector is exactly one-half, One, one-half and three.",criticalVector⟩,⟨"cascade-vector","The formal cascade vector is exactly two-thirds and falling five-thirds magnitude.",cascadeVector⟩]
theorem criticalVectorPassed : criticalVector=true := rfl
theorem cascadeVectorPassed : cascadeVector=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.CriticalMeasuredWitnesses
