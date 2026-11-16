import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parse_ids : recordMap (fun row=>do text (← field row "claim_id")) original_rows = .ok original_ids := rfl
#print axioms parse_ids
end SFT.Physics.GrandLockObservationAnalysisProofs
