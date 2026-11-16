import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parse_legacyRows : recordMap (fun row=>do text (← field row "claim_id")) (recordFilter (fun row=> !SymmetricRecords.truthy (getDefault row "measurement_receipt_hash")) original_rows) = .ok original_legacyRows := rfl
#print axioms parse_legacyRows
end SFT.Physics.GrandLockObservationAnalysisProofs
