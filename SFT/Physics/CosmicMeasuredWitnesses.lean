import SFT.Physics.CosmicComponentTransport
namespace SFT.Physics.CosmicMeasuredWitnesses
open CosmicComponentTransport LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalEquality : Bool := match matterVacuumEqualityCube with | .error _ => false | .ok q => q == normalize 11 5 (by decide)
def formalOnset : Bool := match accelerationOnsetCube with | .error _ => false | .ok q => q == normalize 22 5 (by decide)
def formalAcceleration : Bool := match presentAccelerationMagnitude with | .error _ => false | .ok q => q == normalize 17 32 (by decide)
def witnesses : List Witness := [⟨"equality-exact","Matter-vacuum equality is exactly 11/5.",formalEquality⟩,⟨"onset-exact","Acceleration onset is exactly 22/5.",formalOnset⟩,⟨"acceleration-exact","Present acceleration magnitude is exactly 17/32.",formalAcceleration⟩]
theorem formalEqualityPassed : formalEquality=true := rfl
theorem formalOnsetPassed : formalOnset=true := rfl
theorem formalAccelerationPassed : formalAcceleration=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.CosmicMeasuredWitnesses
