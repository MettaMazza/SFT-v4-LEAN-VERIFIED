import SFT.Physics.YangMillsSingletGap
namespace SFT.Physics.YangMillsSingletGapWitnesses
open YangMillsSingletGap SFT.Mathematics.LimitComputations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def partitionCheck : Bool := match strongGapPartition with
 | .error _ => false
 | .ok p => equalRat p.gap (SFT.Physics.LeptonIntervals.normalize 1 3 (by decide)) && equalRat p.coupling (SFT.Physics.LeptonIntervals.normalize 2 3 (by decide)) && p.complete
def periodCheck : Bool := match strongGapPartition with
 | .error _ => false
 | .ok p => p.gapToCoupling && p.couplingToGap
def singletCheck : Bool := match physicalSingletSupport with
 | .error _ => false
 | .ok p => p.leastSingletConstituents==2 && p.isolatedColourObservationRecord.isEmpty
def depthCheck : Bool := match singletGapTrace (.integer 24) with
 | .error _ => false
 | .ok t => t.allGapsPositive && t.gapDepthInvariant && t.workPositiveAndIncreasing
def carrierCheck : Bool := match singletGapTrace (.integer 24) with
 | .error _ => false
 | .ok t => t.localCarrierOneSpeed && t.localCarrierConfined && t.localMasslessnessNotPhysicalGaplessness
def witnesses : List Witness := [⟨"exact-partition","The strong gap and coupling are one-third and two-thirds and reassemble the One.",partitionCheck⟩,⟨"period-two","The exact shares exchange under Fold and return after two actions.",periodCheck⟩,⟨"nonempty-singlet","The least physical colour closure is an antipodal pair and isolated colour remains unobserved.",singletCheck⟩,⟨"all-finite-depths","Every checked successor retains a positive one-third gap and increasing confinement work.",depthCheck⟩,⟨"carrier-distinction","The local carrier remains massless and confined while the physical singlet gap remains positive.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.YangMillsSingletGapWitnesses
