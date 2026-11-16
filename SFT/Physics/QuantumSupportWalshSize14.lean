import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch14_00
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition14 : combinations 14 (words 4) = (batch 14 0) := rfl
theorem originalSize14 : (combinations 14 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (120,0) := by
 rw [originalPartition14]
 exact originalBatch14_00
#print axioms originalPartition14
#print axioms originalSize14
end SFT.Physics.QuantumSupportWalshBatch
