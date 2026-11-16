import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch01_00
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition01 : combinations 1 (words 4) = (batch 1 0) := rfl
theorem originalSize01 : (combinations 1 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (16,16) := by
 rw [originalPartition01]
 exact originalBatch01_00
#print axioms originalPartition01
#print axioms originalSize01
end SFT.Physics.QuantumSupportWalshBatch
