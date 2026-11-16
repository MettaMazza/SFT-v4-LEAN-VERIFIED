import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch08_44 :
 (batch 8 11264).foldlM (step (.integer 4)) (0,0) = .ok (256,0) := rfl
#print axioms originalBatch08_44
end SFT.Physics.QuantumSupportWalshBatch
