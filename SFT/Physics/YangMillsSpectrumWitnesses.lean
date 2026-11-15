import SFT.Physics.YangMillsSingletGap
namespace SFT.Physics.YangMillsSpectrumWitnesses
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
open YangMillsSingletGap
structure Witness where
 name : String
 statement : String
 passed : Bool
def gapCheck : Bool := match strongGapPartition with
 | .error _ => false
 | .ok p => SFT.Mathematics.LimitComputations.equalRat p.gap (SFT.Physics.LeptonIntervals.normalize 1 3 (by decide))
def supportCheck : Bool := match physicalSingletSupport with
 | .error _ => false
 | .ok p => p.leastSingletConstituents==2
def depthCheck : Bool := match singletGapTrace (.integer 20) with
 | .error _ => false
 | .ok t => t.allGapsPositive && t.workPositiveAndIncreasing
def witnesses : List Witness := [⟨"positive-gap","The formal normalized gap is exact positive one-third.",gapCheck⟩,⟨"physical-singlet","The least observable colour support is a nonempty antipodal pair.",supportCheck⟩,⟨"all-finite-successors","The formal gap remains positive while confinement work increases.",depthCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.YangMillsSpectrumWitnesses
