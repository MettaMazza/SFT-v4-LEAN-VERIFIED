import SFT.Physics.SpinStatisticsCertificateProof
namespace SFT.Physics.SpinStatisticsCondensationWitnesses
open SpinStatisticsCondensationCertificate SpinStatisticsCertificateProof
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match certificate with | .error _ => false | .ok c => c.occupation
theorem witness0Passed : witness0=true := by
 unfold witness0
 rw [originalCertificate]
def witness1 : Bool := match certificate with | .error _ => false | .ok c => c.weights
theorem witness1Passed : witness1=true := by
 unfold witness1
 rw [originalCertificate]
def witness2 : Bool := match certificate with | .error _ => false | .ok c => c.spin
theorem witness2Passed : witness2=true := by
 unfold witness2
 rw [originalCertificate]
def witness3 : Bool := match certificate with | .error _ => false | .ok c => c.cold
theorem witness3Passed : witness3=true := by
 unfold witness3
 rw [originalCertificate]
def witnesses : List Witness := [⟨"occupation","Complete finite preserving and alternating occupation counts match their forced combinatorial forms.",witness0⟩,⟨"weights","Every admitted finite canonical occupation measure is exact and normalized.",witness1⟩,⟨"spin","The complete two-label census and typed return orbits force the spin-statistics composition.",witness2⟩,⟨"condensation","Every tested finite grammar has one first lock crossing and one minimum-throw shared-ground word.",witness3⟩]
end SFT.Physics.SpinStatisticsCondensationWitnesses
