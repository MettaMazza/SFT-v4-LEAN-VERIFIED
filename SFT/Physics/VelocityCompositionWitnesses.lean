import SFT.Physics.VelocityComposition
namespace SFT.Physics.VelocityCompositionWitnesses
open VelocityComposition
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def completeBilinearCensus : Bool := bilinearCandidates.length == 4 && (bilinearCandidates.filter BilinearCandidate.limitAbsorbing).length == 1
def typedRestAndLimit : Bool := match theoremCertificate with
 | .error _ => false
 | .ok c => c.typedRestIdentity && c.limitingSpeedAbsorbing
def closureAndAssociativity : Bool := match theoremCertificate with
 | .error _ => false
 | .ok c => c.closure && c.strictSublimit && c.associativity
def heldPairReconstruction : Bool := match theoremCertificate with
 | .error _ => false
 | .ok c => c.pairEquivalence
def lowSpeedBoundary : Bool := match theoremCertificate with
 | .error _ => false
 | .ok c => c.lowSpeedDifferenceExact
theorem completeBilinearCensusPassed : completeBilinearCensus = true := by decide +kernel
theorem typedRestAndLimitPassed : typedRestAndLimit = true := by decide +kernel
theorem closureAndAssociativityPassed : closureAndAssociativity = true := by decide +kernel
theorem heldPairReconstructionPassed : heldPairReconstruction = true := by decide +kernel
theorem lowSpeedBoundaryPassed : lowSpeedBoundary = true := by decide +kernel
end SFT.Physics.VelocityCompositionWitnesses
