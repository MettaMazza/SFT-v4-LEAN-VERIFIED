import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch07_07 :
 (batch 7 1792).foldlM (step (.integer 4)) (0,0) = .ok (256,0) := rfl
#print axioms originalBatch07_07
end SFT.Physics.QuantumSupportWalshBatch
