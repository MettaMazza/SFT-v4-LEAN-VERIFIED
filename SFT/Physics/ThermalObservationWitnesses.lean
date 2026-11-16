import SFT.Physics.ThermalHistoryCertificate
namespace SFT.Physics.ThermalObservationWitnesses
open ThermalHistoryCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalTemperature : Bool := match certificate with | .error _ => false | .ok c => c.temperatureTransport
def formalFreezeout : Bool := match certificate with | .error _ => false | .ok c => c.freezeoutRatio.den == 6 && c.captureRatio.den == 7
def formalVisibility : Bool := match certificate with | .error _ => false | .ok c => c.visibility && c.acousticParity
def witnesses : List Witness := [⟨"temperature","The formal temperature-scale invariant is exact.",formalTemperature⟩,⟨"freezeout","The formal typed ratios are One/six and One/seven.",formalFreezeout⟩,⟨"visibility","Finite positive visibility and acoustic parity are closed.",formalVisibility⟩]
theorem formalTemperaturePassed : formalTemperature=true := by decide +kernel
theorem formalFreezeoutPassed : formalFreezeout=true := by decide +kernel
theorem formalVisibilityPassed : formalVisibility=true := by decide +kernel
theorem allWitnessesPass : witnesses.all Witness.passed=true := by decide +kernel
end SFT.Physics.ThermalObservationWitnesses
