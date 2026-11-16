import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch16_00 :
 (batch 16 0).foldlM (step (.integer 4)) (0,0) = .ok (1,1) := rfl
#print axioms originalBatch16_00
end SFT.Physics.QuantumSupportWalshBatch
