import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch08_35 :
 (batch 8 8960).foldlM (step (.integer 4)) (0,0) = .ok (256,0) := rfl
#print axioms originalBatch08_35
end SFT.Physics.QuantumSupportWalshBatch
