import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalBatch09_06 :
 (batch 9 1536).foldlM (step (.integer 4)) (0,0) = .ok (256,0) := rfl
#print axioms originalBatch09_06
end SFT.Physics.QuantumSupportWalshBatch
