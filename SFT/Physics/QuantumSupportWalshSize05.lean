import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshBatch05_00
import SFT.Physics.QuantumSupportWalshBatch05_01
import SFT.Physics.QuantumSupportWalshBatch05_02
import SFT.Physics.QuantumSupportWalshBatch05_03
import SFT.Physics.QuantumSupportWalshBatch05_04
import SFT.Physics.QuantumSupportWalshBatch05_05
import SFT.Physics.QuantumSupportWalshBatch05_06
import SFT.Physics.QuantumSupportWalshBatch05_07
import SFT.Physics.QuantumSupportWalshBatch05_08
import SFT.Physics.QuantumSupportWalshBatch05_09
import SFT.Physics.QuantumSupportWalshBatch05_10
import SFT.Physics.QuantumSupportWalshBatch05_11
import SFT.Physics.QuantumSupportWalshBatch05_12
import SFT.Physics.QuantumSupportWalshBatch05_13
import SFT.Physics.QuantumSupportWalshBatch05_14
import SFT.Physics.QuantumSupportWalshBatch05_15
import SFT.Physics.QuantumSupportWalshBatch05_16
import SFT.Physics.QuantumSupportWalshBatch05_17
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalPartition05 : combinations 5 (words 4) = (batch 5 0) ++ (batch 5 256) ++ (batch 5 512) ++ (batch 5 768) ++ (batch 5 1024) ++ (batch 5 1280) ++ (batch 5 1536) ++ (batch 5 1792) ++ (batch 5 2048) ++ (batch 5 2304) ++ (batch 5 2560) ++ (batch 5 2816) ++ (batch 5 3072) ++ (batch 5 3328) ++ (batch 5 3584) ++ (batch 5 3840) ++ (batch 5 4096) ++ (batch 5 4352) := rfl
theorem originalSize05 : (combinations 5 (words 4)).foldlM (step (.integer 4)) (0,0) = .ok (4368,0) := by
 rw [originalPartition05]
 exact (appendResults (.integer 4) (batch 5 0) ((batch 5 256) ++ ((batch 5 512) ++ ((batch 5 768) ++ ((batch 5 1024) ++ ((batch 5 1280) ++ ((batch 5 1536) ++ ((batch 5 1792) ++ ((batch 5 2048) ++ ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352))))))))))))))))) 256 0 4112 0 originalBatch05_00 (appendResults (.integer 4) (batch 5 256) ((batch 5 512) ++ ((batch 5 768) ++ ((batch 5 1024) ++ ((batch 5 1280) ++ ((batch 5 1536) ++ ((batch 5 1792) ++ ((batch 5 2048) ++ ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352)))))))))))))))) 256 0 3856 0 originalBatch05_01 (appendResults (.integer 4) (batch 5 512) ((batch 5 768) ++ ((batch 5 1024) ++ ((batch 5 1280) ++ ((batch 5 1536) ++ ((batch 5 1792) ++ ((batch 5 2048) ++ ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352))))))))))))))) 256 0 3600 0 originalBatch05_02 (appendResults (.integer 4) (batch 5 768) ((batch 5 1024) ++ ((batch 5 1280) ++ ((batch 5 1536) ++ ((batch 5 1792) ++ ((batch 5 2048) ++ ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352)))))))))))))) 256 0 3344 0 originalBatch05_03 (appendResults (.integer 4) (batch 5 1024) ((batch 5 1280) ++ ((batch 5 1536) ++ ((batch 5 1792) ++ ((batch 5 2048) ++ ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352))))))))))))) 256 0 3088 0 originalBatch05_04 (appendResults (.integer 4) (batch 5 1280) ((batch 5 1536) ++ ((batch 5 1792) ++ ((batch 5 2048) ++ ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352)))))))))))) 256 0 2832 0 originalBatch05_05 (appendResults (.integer 4) (batch 5 1536) ((batch 5 1792) ++ ((batch 5 2048) ++ ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352))))))))))) 256 0 2576 0 originalBatch05_06 (appendResults (.integer 4) (batch 5 1792) ((batch 5 2048) ++ ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352)))))))))) 256 0 2320 0 originalBatch05_07 (appendResults (.integer 4) (batch 5 2048) ((batch 5 2304) ++ ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352))))))))) 256 0 2064 0 originalBatch05_08 (appendResults (.integer 4) (batch 5 2304) ((batch 5 2560) ++ ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352)))))))) 256 0 1808 0 originalBatch05_09 (appendResults (.integer 4) (batch 5 2560) ((batch 5 2816) ++ ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352))))))) 256 0 1552 0 originalBatch05_10 (appendResults (.integer 4) (batch 5 2816) ((batch 5 3072) ++ ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352)))))) 256 0 1296 0 originalBatch05_11 (appendResults (.integer 4) (batch 5 3072) ((batch 5 3328) ++ ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352))))) 256 0 1040 0 originalBatch05_12 (appendResults (.integer 4) (batch 5 3328) ((batch 5 3584) ++ ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352)))) 256 0 784 0 originalBatch05_13 (appendResults (.integer 4) (batch 5 3584) ((batch 5 3840) ++ ((batch 5 4096) ++ (batch 5 4352))) 256 0 528 0 originalBatch05_14 (appendResults (.integer 4) (batch 5 3840) ((batch 5 4096) ++ (batch 5 4352)) 256 0 272 0 originalBatch05_15 (appendResults (.integer 4) (batch 5 4096) (batch 5 4352) 256 0 16 0 originalBatch05_16 originalBatch05_17)))))))))))))))))
#print axioms originalPartition05
#print axioms originalSize05
end SFT.Physics.QuantumSupportWalshBatch
