import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch08_50 :
 (batch 8 12800).foldlM (step (.integer 4)) (0,0) = .ok (70,1) := rfl
#print axioms originalBatch08_50
end SFT.Physics.QuantumSupportWalshBatch
