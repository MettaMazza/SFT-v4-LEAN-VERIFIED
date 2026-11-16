import SFT.Physics.GrandLockObservationOriginalData
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics.GrandLockObservationAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem original_receiptBound : receiptBound original_formalReceipt = true := rfl
#print axioms original_receiptBound
end SFT.Physics.GrandLockObservationAnalysisProofs
