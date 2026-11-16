import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch07_44 :
 (batch 7 11264).foldlM (step (.integer 4)) (0,0) = .ok (176,0) := rfl
#print axioms originalBatch07_44
end SFT.Physics.QuantumSupportWalshBatch
