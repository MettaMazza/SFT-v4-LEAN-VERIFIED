import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch08_10 :
 (batch 8 2560).foldlM (step (.integer 4)) (0,0) = .ok (256,1) := rfl
#print axioms originalBatch08_10
end SFT.Physics.QuantumSupportWalshBatch
