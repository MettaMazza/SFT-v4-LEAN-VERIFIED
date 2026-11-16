import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch04_02 :
 (batch 4 512).foldlM (step (.integer 4)) (0,0) = .ok (256,25) := rfl
#print axioms originalBatch04_02
end SFT.Physics.QuantumSupportWalshBatch
