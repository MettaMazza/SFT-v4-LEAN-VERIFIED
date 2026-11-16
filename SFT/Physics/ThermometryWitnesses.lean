import SFT.Physics.ThermalEquilibriumCertificateProof
namespace SFT.Physics.ThermometryWitnesses
open ThermalEquilibriumResponseCertificate ThermalEquilibriumCertificateProof
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalTemperature : Bool := match certificate with | .error _ => false | .ok c => c.temperature
def formalFreezeout : Bool := match certificate with | .error _ => false | .ok c => c.equilibrium && c.canonical && c.weights
def formalVisibility : Bool := match certificate with | .error _ => false | .ok c => c.fluctuation && c.noise
def witnesses : List Witness := [⟨"temperature","The exact finite mean and total identity are closed.",formalTemperature⟩,⟨"equilibrium","The complete paired-population and canonical censuses are closed.",formalFreezeout⟩,⟨"response","The complementary fluctuation-response and deterministic cycle are closed.",formalVisibility⟩]
theorem formalTemperaturePassed : formalTemperature=true := by
 unfold formalTemperature
 rw [originalCertificate]
theorem formalFreezeoutPassed : formalFreezeout=true := by
 unfold formalFreezeout
 rw [originalCertificate]
 rfl
theorem formalVisibilityPassed : formalVisibility=true := by
 unfold formalVisibility
 rw [originalCertificate]
 rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (formalTemperature && (formalFreezeout && (formalVisibility && true))) = true
 rw [formalTemperaturePassed,formalFreezeoutPassed,formalVisibilityPassed]
 rfl
end SFT.Physics.ThermometryWitnesses
