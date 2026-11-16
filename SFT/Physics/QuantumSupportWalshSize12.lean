import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch12_00
import SFT.Physics.QuantumSupportWalshBatch12_01
import SFT.Physics.QuantumSupportWalshBatch12_02
import SFT.Physics.QuantumSupportWalshBatch12_03
import SFT.Physics.QuantumSupportWalshBatch12_04
import SFT.Physics.QuantumSupportWalshBatch12_05
import SFT.Physics.QuantumSupportWalshBatch12_06
import SFT.Physics.QuantumSupportWalshBatch12_07
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition12 : combinations 12 (words 4) = (batch 12 0) ++ (batch 12 256) ++ (batch 12 512) ++ (batch 12 768) ++ (batch 12 1024) ++ (batch 12 1280) ++ (batch 12 1536) ++ (batch 12 1792) := rfl
theorem originalSize12 : (combinations 12 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (1820,0) := by
 rw [originalPartition12]
 exact (appendResults (.integer 4) (batch 12 0) ((batch 12 256) ++ ((batch 12 512) ++ ((batch 12 768) ++ ((batch 12 1024) ++ ((batch 12 1280) ++ ((batch 12 1536) ++ (batch 12 1792))))))) 256 0 1564 0 originalBatch12_00 (appendResults (.integer 4) (batch 12 256) ((batch 12 512) ++ ((batch 12 768) ++ ((batch 12 1024) ++ ((batch 12 1280) ++ ((batch 12 1536) ++ (batch 12 1792)))))) 256 0 1308 0 originalBatch12_01 (appendResults (.integer 4) (batch 12 512) ((batch 12 768) ++ ((batch 12 1024) ++ ((batch 12 1280) ++ ((batch 12 1536) ++ (batch 12 1792))))) 256 0 1052 0 originalBatch12_02 (appendResults (.integer 4) (batch 12 768) ((batch 12 1024) ++ ((batch 12 1280) ++ ((batch 12 1536) ++ (batch 12 1792)))) 256 0 796 0 originalBatch12_03 (appendResults (.integer 4) (batch 12 1024) ((batch 12 1280) ++ ((batch 12 1536) ++ (batch 12 1792))) 256 0 540 0 originalBatch12_04 (appendResults (.integer 4) (batch 12 1280) ((batch 12 1536) ++ (batch 12 1792)) 256 0 284 0 originalBatch12_05 (appendResults (.integer 4) (batch 12 1536) (batch 12 1792) 256 0 28 0 originalBatch12_06 originalBatch12_07)))))))
#print axioms originalPartition12
#print axioms originalSize12
end SFT.Physics.QuantumSupportWalshBatch
