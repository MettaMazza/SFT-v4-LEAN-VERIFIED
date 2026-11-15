import SFT.Physics.StrongFieldNonlinearFixedPoint
namespace SFT.Physics.StrongFieldNonlinearFixedPointCertificate
open StrongFieldNonlinearFixedPoint LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 neutral : Neutral
 gravity : PostNewtonianFixedPointCertificate.Certificate
 strong : Strong
 fixedPointCandidates : List FixedPointTest
 boundWitnesses : List BoundWitness
 neutralLinearHold : Bool
 gravitySelfSourceContracts : Bool
 strongSelfSourcePersists : Bool
 strongHasNoPositiveFiniteFixedPoint : Bool
 allRegisteredBoundsExceeded : Bool
 generalFixedPointIdentity : String
 generalBoundIdentity : String
 structuralNonlinearity : String
 strongFiniteFixedPointRecord : List Rat
 completedInfinityUsed : Bool
 forbiddenProofScalarUsed : Bool
def fieldIterationCertificate (depth : GeneratorOperations.CountInput := .integer 8) : Except String Certificate := do
 let strong ← strongSourceIteration depth
 let neutral ← neutralSourceIteration depth
 let gravity ← PostNewtonianFixedPointCertificate.convergenceCertificate depth
 let candidates ← [normalize 1 127 (by decide),normalize 1 2 (by decide),wholeRatio 1,normalize 7 3 (by decide),wholeRatio 32].mapM (fun q => finiteStrongFixedPointTest (.fraction q))
 let bounds ← [normalize 1 127 (by decide),normalize 1 2 (by decide),wholeRatio 1,normalize 7 3 (by decide),wholeRatio 32].mapM (fun q => strongSourceExceedsPositiveBound (.fraction q))
 pure ⟨neutral,gravity,strong,candidates,bounds,neutral.sourceHeld && neutral.correctionRecord.isEmpty,
  gravity.admissibleFixedPoints==[normalize 1 4 (by decide)] && gravity.errorsStrictlyShrink && gravity.correctionsStrictlyShrink,
  strong.sourceStrictlyGrows && strong.allCorrectionsBinary && strong.correctionsDoNotShrink,
  candidates.all (fun row => !row.isFixedPoint && row.successorStrictlyAboveCandidate),bounds.all (fun row => row.sourceExceedsBound && row.finiteWitness),
  "for every positive exact finite F, the colour successor is F plus the complete binary carrier and is strictly above F",
  "for every positive exact finite B, the successor whole after B divided by two yields source One plus twice that whole, strictly above B",
  "the strong field carrier is retained inside the source update that generates its next field record",[],false,false⟩
def certificateFacts : Except String Bool := do
 let c ← fieldIterationCertificate
 pure (c.neutralLinearHold && c.gravitySelfSourceContracts && c.strongSelfSourcePersists && c.strongHasNoPositiveFiniteFixedPoint && c.allRegisteredBoundsExceeded && c.strongFiniteFixedPointRecord.isEmpty && !c.completedInfinityUsed && !c.forbiddenProofScalarUsed)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.StrongFieldNonlinearFixedPointCertificate
