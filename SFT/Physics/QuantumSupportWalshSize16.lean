import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch16_00
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition16 : combinations 16 (words 4) = (batch 16 0) := rfl
theorem originalSize16 : (combinations 16 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (1,1) := by
 rw [originalPartition16]
 exact originalBatch16_00
#print axioms originalPartition16
#print axioms originalSize16
end SFT.Physics.QuantumSupportWalshBatch
