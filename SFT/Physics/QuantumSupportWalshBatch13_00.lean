import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch13_00 :
 (batch 13 0).foldlM (step (.integer 4)) (0,0) = .ok (256,0) := rfl
#print axioms originalBatch13_00
end SFT.Physics.QuantumSupportWalshBatch
