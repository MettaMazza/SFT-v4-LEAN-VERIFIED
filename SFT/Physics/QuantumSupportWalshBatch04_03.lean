import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch04_03 :
 (batch 4 768).foldlM (step (.integer 4)) (0,0) = .ok (256,18) := rfl
#print axioms originalBatch04_03
end SFT.Physics.QuantumSupportWalshBatch
