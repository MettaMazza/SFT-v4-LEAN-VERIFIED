import SFT.Physics.GrandLockObservationOriginalData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics.GrandLockObservationAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem original_uniqueVector : uniqueVector original_ids original_empiricalCount = true := rfl
#print axioms original_uniqueVector
end SFT.Physics.GrandLockObservationAnalysisProofs
