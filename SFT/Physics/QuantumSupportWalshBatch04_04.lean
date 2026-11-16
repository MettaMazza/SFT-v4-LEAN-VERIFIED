import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch04_04 :
 (batch 4 1024).foldlM (step (.integer 4)) (0,0) = .ok (256,20) := rfl
#print axioms originalBatch04_04
end SFT.Physics.QuantumSupportWalshBatch
