import SFT.Physics.GrandLockObservationOriginalData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics.GrandLockObservationAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem original_boundaryExact : boundaryExact original_boundary original_requiredTrue = true := rfl
#print axioms original_boundaryExact
end SFT.Physics.GrandLockObservationAnalysisProofs
