import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch08_20 :
 (batch 8 5120).foldlM (step (.integer 4)) (0,0) = .ok (256,2) := rfl
#print axioms originalBatch08_20
end SFT.Physics.QuantumSupportWalshBatch
