import SFT.Physics.RunningConvergenceCensus0
import SFT.Physics.RunningConvergenceCensus1
import SFT.Physics.RunningConvergenceCensus2
import SFT.Physics.RunningConvergenceCensus3
import SFT.Physics.RunningConvergenceCensus4
import SFT.Physics.RunningConvergenceCensus5
import SFT.Physics.RunningConvergenceCensus6
import SFT.Physics.RunningConvergenceCensus7
import SFT.Physics.RunningConvergenceCensus8
import SFT.Physics.RunningConvergenceCensus9
import SFT.Physics.RunningConvergenceCensus10
import SFT.Physics.RunningConvergenceCensus11
import SFT.Physics.RunningConvergenceCensus12
import SFT.Physics.RunningConvergenceCensus13
import SFT.Physics.RunningConvergenceCensus14
import SFT.Physics.RunningConvergenceCensus15
import SFT.Physics.RunningConvergenceCensus16
import SFT.Physics.RunningConvergenceCensus17
import SFT.Physics.RunningConvergenceCensus18
import SFT.Physics.RunningConvergenceCensus19
import SFT.Physics.RunningConvergenceCensus20
import SFT.Physics.RunningConvergenceCensus21
import SFT.Physics.RunningConvergenceCensus22
import SFT.Physics.RunningConvergenceCensus23
import SFT.Physics.RunningConvergenceCensus24
import SFT.Physics.RunningConvergenceCensus25
import SFT.Physics.RunningConvergenceCensus26
namespace SFT.Physics.RunningConvergenceGrammar
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
 cases c with
 | mk sectorDomain scaleGeneration couplingForm successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension =>
  cases sectorDomain <;> cases scaleGeneration <;> cases couplingForm
  · exact uniqueCensus0 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus1 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus2 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus3 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus4 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus5 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus6 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus7 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus8 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus9 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus10 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus11 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus12 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus13 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus14 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus15 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus16 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus17 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus18 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus19 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus20 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus21 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus22 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus23 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus24 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus25 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
  · exact uniqueCensus26 successorLaw pairGapLaw convergenceLaw physicalTranslation targetBoundary extension
theorem survivorPasses : survives survivor = true := (uniqueSurvivor survivor).mpr rfl
end SFT.Physics.RunningConvergenceGrammar
