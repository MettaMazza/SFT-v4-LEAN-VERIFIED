import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem field_formal : field originalTarget "formal_grand_lock" = .ok (snapshot703) := rfl
#print axioms field_formal
end SFT.Physics.GrandLockObservationAnalysisProofs
