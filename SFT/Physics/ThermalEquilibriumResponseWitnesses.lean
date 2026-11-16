import SFT.Physics.ThermalEquilibriumCertificateProof
namespace SFT.Physics.ThermalEquilibriumResponseWitnesses
open ThermalEquilibriumResponseCertificate ThermalEquilibriumCertificateProof
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match certificate with | .error _ => false | .ok c => c.temperature
theorem witness0Passed : witness0=true := by
 unfold witness0
 rw [originalCertificate]
def witness1 : Bool := match certificate with | .error _ => false | .ok c => c.equilibrium
theorem witness1Passed : witness1=true := by
 unfold witness1
 rw [originalCertificate]
def witness2 : Bool := match certificate with | .error _ => false | .ok c => c.canonical && c.weights
theorem witness2Passed : witness2=true := by
 unfold witness2
 rw [originalCertificate]
 rfl
def witness3 : Bool := match certificate with | .error _ => false | .ok c => c.fluctuation && c.noise
theorem witness3Passed : witness3=true := by
 unfold witness3
 rw [originalCertificate]
 rfl
def witnesses : List Witness := [⟨"temperature","Exact total and mean identity holds.",witness0⟩,⟨"equilibrium","Complete paired populations uniquely force half-One.",witness1⟩,⟨"canonical","Every tested complete level grammar has one dyadic maximum and exact weights.",witness2⟩,⟨"response","Fluctuation, response and deterministic noise share one exact balance.",witness3⟩]
end SFT.Physics.ThermalEquilibriumResponseWitnesses
