import SFT.Physics.CollectiveRadiationCertificate
namespace SFT.Physics.CollectiveObservationWitnesses
open CollectiveRadiationCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalOccupation : Bool := match certificate with | .error _ => false | .ok c => c.energyExact && c.scaleCovariant
def formalResponse : Bool := match certificate with | .error _ => false | .ok c => c.fourthPower && c.acoustic && c.laser
def formalCollective : Bool := match certificate with | .error _ => false | .ok c => c.plasma && c.alfven
def witnesses : List Witness := [⟨"occupation","Finite support and scale covariance are closed.",formalOccupation⟩,⟨"response","Fourth power, acoustics and laser are closed.",formalResponse⟩,⟨"collective","Plasma and Alfvén squared carriers are closed.",formalCollective⟩]
theorem formalOccupationPassed : formalOccupation=true := by decide +kernel
theorem formalResponsePassed : formalResponse=true := by decide +kernel
theorem formalCollectivePassed : formalCollective=true := by decide +kernel
theorem allWitnessesPass : witnesses.all Witness.passed=true := by decide +kernel
end SFT.Physics.CollectiveObservationWitnesses
