import SFT.Physics.GrandLockObservationExtractionData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parse_formal : field snapshot703 "receipt_hash" = .ok original_formalReceipt := rfl
#print axioms parse_formal
end SFT.Physics.GrandLockObservationAnalysisProofs
