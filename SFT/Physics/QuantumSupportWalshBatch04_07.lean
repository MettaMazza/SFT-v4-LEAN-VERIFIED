import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch04_07 :
 (batch 4 1792).foldlM (step (.integer 4)) (0,0) = .ok (28,6) := rfl
#print axioms originalBatch04_07
end SFT.Physics.QuantumSupportWalshBatch
