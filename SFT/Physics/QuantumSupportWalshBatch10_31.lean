import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch10_31 :
 (batch 10 7936).foldlM (step (.integer 4)) (0,0) = .ok (72,0) := rfl
#print axioms originalBatch10_31
end SFT.Physics.QuantumSupportWalshBatch
