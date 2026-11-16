import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parse_measurements : recordMap (fun row=>do pure (SymmetricRecords.truthy (getDefault row "measurement_receipt_hash") || member (← text (← field row "claim_id")) original_legacy)) original_rows = .ok original_measurements := rfl
#print axioms parse_measurements
end SFT.Physics.GrandLockObservationAnalysisProofs
