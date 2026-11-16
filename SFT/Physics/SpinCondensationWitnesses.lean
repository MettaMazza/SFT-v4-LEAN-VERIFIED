import SFT.Physics.SpinStatisticsCertificateProof
namespace SFT.Physics.SpinCondensationWitnesses
open SpinStatisticsCondensationCertificate SpinStatisticsCertificateProof
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalOccupation : Bool := match certificate with | .error _ => false | .ok c => c.occupation
def formalWeights : Bool := match certificate with | .error _ => false | .ok c => c.weights
def formalSpin : Bool := match certificate with | .error _ => false | .ok c => c.spin
def formalCold : Bool := match certificate with | .error _ => false | .ok c => c.cold
def witnesses : List Witness := [⟨"occupation","The complete finite preserving and alternating occupation censuses are closed.",formalOccupation⟩,⟨"weights","Every admitted finite occupation measure is exact and normalized.",formalWeights⟩,⟨"spin","The two-label composition and typed return orbits are closed.",formalSpin⟩,⟨"condensation","The first finite lock crossing and unique minimum-throw ground word are closed.",formalCold⟩]
theorem formalOccupationPassed : formalOccupation=true := by decide +kernel
theorem formalWeightsPassed : formalWeights=true := by decide +kernel
theorem formalSpinPassed : formalSpin=true := by decide +kernel
theorem formalColdPassed : formalCold=true := by decide +kernel
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (formalOccupation && (formalWeights && (formalSpin && (formalCold && true)))) = true
 rw [formalOccupationPassed,formalWeightsPassed,formalSpinPassed,formalColdPassed]
 rfl
end SFT.Physics.SpinCondensationWitnesses
