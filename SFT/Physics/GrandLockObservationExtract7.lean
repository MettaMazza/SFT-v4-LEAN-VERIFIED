import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem field_sourceCount : field originalTarget "unique_external_source_id_count" = .ok (original_sourceCount) := rfl
#print axioms field_sourceCount
end SFT.Physics.GrandLockObservationAnalysisProofs
