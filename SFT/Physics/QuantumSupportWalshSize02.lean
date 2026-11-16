import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch02_00
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition02 : combinations 2 (words 4) = (batch 2 0) := rfl
theorem originalSize02 : (combinations 2 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (120,120) := by
 rw [originalPartition02]
 exact originalBatch02_00
#print axioms originalPartition02
#print axioms originalSize02
end SFT.Physics.QuantumSupportWalshBatch
