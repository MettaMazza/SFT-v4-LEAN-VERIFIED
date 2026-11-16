import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch02_00 :
 (batch 2 0).foldlM (step (.integer 4)) (0,0) = .ok (120,120) := rfl
#print axioms originalBatch02_00
end SFT.Physics.QuantumSupportWalshBatch
