import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch10_20 :
 (batch 10 5120).foldlM (step (.integer 4)) (0,0) = .ok (256,0) := rfl
#print axioms originalBatch10_20
end SFT.Physics.QuantumSupportWalshBatch
