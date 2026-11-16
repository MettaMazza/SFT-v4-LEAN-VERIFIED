import SFT.Physics.CollectiveRadiationCertificate
namespace SFT.Physics.CollectiveRadiationWitnesses
open CollectiveRadiationCertificate LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match certificate with | .error _ => false | .ok c => c.energyExact && c.uvClosed && c.scaleCovariant
theorem witness0Passed : witness0=true := by decide +kernel
def witness1 : Bool := match certificate with | .error _ => false | .ok c => c.fourthPower && c.acoustic
theorem witness1Passed : witness1=true := by decide +kernel
def witness2 : Bool := match certificate with | .error _ => false | .ok c => c.laser
theorem witness2Passed : witness2=true := by decide +kernel
def witness3 : Bool := match certificate with | .error _ => false | .ok c => c.plasma
theorem witness3Passed : witness3=true := by decide +kernel
def witness4 : Bool := match certificate with | .error _ => false | .ok c => c.alfven
theorem witness4Passed : witness4=true := by decide +kernel
def witnesses : List Witness := [⟨"occupation","The complete finite word census preserves energy, closes its ultraviolet support and is exactly scale covariant.",witness0⟩,⟨"radiation-acoustic","Three-space radiation is fourth-power and fixed boundaries give whole harmonics.",witness1⟩,⟨"laser","Strict inversion, gain-over-loss and positive reciprocal linewidth close together.",witness2⟩,⟨"plasma","Oscillation and screening share the exact charge stiffness.",witness3⟩,⟨"alfven","Magnetic tension over inertia gives an exact positive squared carrier.",witness4⟩]
end SFT.Physics.CollectiveRadiationWitnesses
