import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch15_00
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition15 : combinations 15 (words 4) = (batch 15 0) := rfl
theorem originalSize15 : (combinations 15 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (16,0) := by
 rw [originalPartition15]
 exact originalBatch15_00
#print axioms originalPartition15
#print axioms originalSize15
end SFT.Physics.QuantumSupportWalshBatch
