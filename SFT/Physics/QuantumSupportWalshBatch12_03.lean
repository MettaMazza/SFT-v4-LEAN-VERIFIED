import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch12_03 :
 (batch 12 768).foldlM (step (.integer 4)) (0,0) = .ok (256,0) := rfl
#print axioms originalBatch12_03
end SFT.Physics.QuantumSupportWalshBatch
