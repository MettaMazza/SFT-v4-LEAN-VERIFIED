import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem field_legacy : field originalTarget "legacy_empirical_materialization_without_separate_measurement_receipt" = .ok (snapshot704) := rfl
#print axioms field_legacy
end SFT.Physics.GrandLockObservationAnalysisProofs
