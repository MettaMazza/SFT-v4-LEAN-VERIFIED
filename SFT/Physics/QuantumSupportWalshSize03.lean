import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch03_00
import SFT.Physics.QuantumSupportWalshBatch03_01
import SFT.Physics.QuantumSupportWalshBatch03_02
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition03 : combinations 3 (words 4) = (batch 3 0) ++ (batch 3 256) ++ (batch 3 512) := rfl
theorem originalSize03 : (combinations 3 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (560,0) := by
 rw [originalPartition03]
 exact (appendResults (.integer 4) (batch 3 0) ((batch 3 256) ++ (batch 3 512)) 256 0 304 0 originalBatch03_00 (appendResults (.integer 4) (batch 3 256) (batch 3 512) 256 0 48 0 originalBatch03_01 originalBatch03_02))
#print axioms originalPartition03
#print axioms originalSize03
end SFT.Physics.QuantumSupportWalshBatch
