import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch13_00
import SFT.Physics.QuantumSupportWalshBatch13_01
import SFT.Physics.QuantumSupportWalshBatch13_02
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition13 : combinations 13 (words 4) = (batch 13 0) ++ (batch 13 256) ++ (batch 13 512) := rfl
theorem originalSize13 : (combinations 13 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (560,0) := by
 rw [originalPartition13]
 exact (appendResults (.integer 4) (batch 13 0) ((batch 13 256) ++ (batch 13 512)) 256 0 304 0 originalBatch13_00 (appendResults (.integer 4) (batch 13 256) (batch 13 512) 256 0 48 0 originalBatch13_01 originalBatch13_02))
#print axioms originalPartition13
#print axioms originalSize13
end SFT.Physics.QuantumSupportWalshBatch
