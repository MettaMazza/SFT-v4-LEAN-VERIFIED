import SFT.Physics.GrandLockObservationOriginalData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics.GrandLockObservationAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem original_hashesRetained : hashesRetained original_hashes = true := rfl
#print axioms original_hashesRetained
end SFT.Physics.GrandLockObservationAnalysisProofs
