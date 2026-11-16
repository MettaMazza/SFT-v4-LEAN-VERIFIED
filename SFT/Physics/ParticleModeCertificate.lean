import SFT.Physics.ParticleModePlacement
import SFT.Physics.ParticleModeTransport
namespace SFT.Physics.ParticleModeCertificate
open ParticleModeFibres ParticleModeCoordinates ParticleModeCover ParticleModePlacement ParticleModeTransport
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
structure Certificate where
 fibres : Bool
 coordinates : Bool
 cover : Bool
 placement : Bool
 mass : Bool
 dual : Bool
 reach : Bool
 transition : Bool

def generatedTraces (volume : Nat) : List SFT.Host.Canonical.Value :=
 (List.range volume).map (fun i=>.text (SFT.Host.Text.append "generated-trace-"
  (SFT.Host.Canonical.render (.integer (.ofNat (i+1))))))
def theoremCertificate : Except String Certificate := do
 let fibres ← mFoldTheoremCertificate (.integer 12)
 let coordinates ← generationCoordinates
 let volume := 3^3
 let binaryCover ← leastCoverDepth (.integer 2) (.integer (.ofNat volume))
 let colourCover ← leastCoverDepth (.integer 3) (.integer (.ofNat volume))
 let placement ← placeRecurrentParticleModes (generatedTraces volume)
 let mass ← massPatternTransport
 let dual5 ← colourBinaryDual (.integer 5)
 let dual7 ← colourBinaryDual (.integer 7)
 let third ← LeptonRatios.divide (wholeRatio 1) (wholeRatio (2*3^5-1))
 let reach ← (List.range 6).mapM (fun i=>ParticleModeReach.massRatioReach (.integer (.ofNat (i+1))))
 let transition ← transitionModeCertificate
 pure ⟨fibres.allFibresComplete && fibres.fixedModeFormula,
  coordinates.allThree && coordinates.orderIsomorphic && !coordinates.coordinatesAreMassValues,
  binaryCover.minimal && binaryCover.depth==5 && colourCover.minimal && colourCover.depth==3,
  placement.complete && placement.injective && placement.internalDepthNotSpatialDimension,
  mass.completeSectorTable && mass.oldSiteFractionEqualsMassClaimRejected,
  dual5==normalize 1 95 (by decide) && dual7==normalize 1 383 (by decide) && third==normalize 1 485 (by decide),
  reach.all ParticleModeReach.Result.identity,transition.complete && !transition.universalObservedMixingRates⟩
theorem originalCompleteCertificate : theoremCertificate=.ok ⟨true,true,true,true,true,true,true,true⟩ := rfl
#print axioms theoremCertificate
#print axioms originalCompleteCertificate
end SFT.Physics.ParticleModeCertificate
