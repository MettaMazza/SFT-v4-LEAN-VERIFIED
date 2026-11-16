import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem field_physics : field originalTarget "physics_claim_ids" = .ok (snapshot706) := rfl
#print axioms field_physics
end SFT.Physics.GrandLockObservationAnalysisProofs
