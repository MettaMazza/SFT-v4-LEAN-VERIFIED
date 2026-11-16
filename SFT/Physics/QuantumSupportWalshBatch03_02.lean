import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch03_02 :
 (batch 3 512).foldlM (step (.integer 4)) (0,0) = .ok (48,0) := rfl
#print axioms originalBatch03_02
end SFT.Physics.QuantumSupportWalshBatch
