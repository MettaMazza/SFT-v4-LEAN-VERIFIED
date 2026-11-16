import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch01_00 :
 (batch 1 0).foldlM (step (.integer 4)) (0,0) = .ok (16,16) := rfl
#print axioms originalBatch01_00
end SFT.Physics.QuantumSupportWalshBatch
