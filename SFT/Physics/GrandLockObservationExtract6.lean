import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem field_empiricalCount : field originalTarget "empirical_claim_count" = .ok (original_empiricalCount) := rfl
#print axioms field_empiricalCount
end SFT.Physics.GrandLockObservationAnalysisProofs
