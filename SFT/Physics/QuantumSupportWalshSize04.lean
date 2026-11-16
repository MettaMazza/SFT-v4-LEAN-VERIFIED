import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch04_00
import SFT.Physics.QuantumSupportWalshBatch04_01
import SFT.Physics.QuantumSupportWalshBatch04_02
import SFT.Physics.QuantumSupportWalshBatch04_03
import SFT.Physics.QuantumSupportWalshBatch04_04
import SFT.Physics.QuantumSupportWalshBatch04_05
import SFT.Physics.QuantumSupportWalshBatch04_06
import SFT.Physics.QuantumSupportWalshBatch04_07
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition04 : combinations 4 (words 4) = (batch 4 0) ++ (batch 4 256) ++ (batch 4 512) ++ (batch 4 768) ++ (batch 4 1024) ++ (batch 4 1280) ++ (batch 4 1536) ++ (batch 4 1792) := rfl
theorem originalSize04 : (combinations 4 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (1820,140) := by
 rw [originalPartition04]
 exact (appendResults (.integer 4) (batch 4 0) ((batch 4 256) ++ ((batch 4 512) ++ ((batch 4 768) ++ ((batch 4 1024) ++ ((batch 4 1280) ++ ((batch 4 1536) ++ (batch 4 1792))))))) 256 19 1564 121 originalBatch04_00 (appendResults (.integer 4) (batch 4 256) ((batch 4 512) ++ ((batch 4 768) ++ ((batch 4 1024) ++ ((batch 4 1280) ++ ((batch 4 1536) ++ (batch 4 1792)))))) 256 19 1308 102 originalBatch04_01 (appendResults (.integer 4) (batch 4 512) ((batch 4 768) ++ ((batch 4 1024) ++ ((batch 4 1280) ++ ((batch 4 1536) ++ (batch 4 1792))))) 256 25 1052 77 originalBatch04_02 (appendResults (.integer 4) (batch 4 768) ((batch 4 1024) ++ ((batch 4 1280) ++ ((batch 4 1536) ++ (batch 4 1792)))) 256 18 796 59 originalBatch04_03 (appendResults (.integer 4) (batch 4 1024) ((batch 4 1280) ++ ((batch 4 1536) ++ (batch 4 1792))) 256 20 540 39 originalBatch04_04 (appendResults (.integer 4) (batch 4 1280) ((batch 4 1536) ++ (batch 4 1792)) 256 19 284 20 originalBatch04_05 (appendResults (.integer 4) (batch 4 1536) (batch 4 1792) 256 14 28 6 originalBatch04_06 originalBatch04_07)))))))
#print axioms originalPartition04
#print axioms originalSize04
end SFT.Physics.QuantumSupportWalshBatch
