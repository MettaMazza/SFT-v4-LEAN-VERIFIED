import SFT.Physics.QuantumSupportWalsh
namespace SFT.Physics.QuantumSupportOrthogonality
open QuantumSupportWalsh GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- The original census uses every diagonal and off-diagonal row at these depths.
def originalRowChecks (d : Nat) : Except String Bool := do
 let c ← orthogonalityCertificate (.integer (.ofNat d))
 pure (c.diagonalComplete && c.offDiagonalCancels)
theorem originalDepthOne : originalRowChecks 1=.ok true := rfl
theorem originalDepthTwo : originalRowChecks 2=.ok true := rfl
theorem originalDepthThree : originalRowChecks 3=.ok true := rfl
theorem originalDepthFour : originalRowChecks 4=.ok true := rfl
end SFT.Physics.QuantumSupportOrthogonality
