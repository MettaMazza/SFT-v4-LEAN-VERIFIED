import SFT.Physics.QuantumSupportWalshGuardAssembly
import SFT.Physics.QuantumSupportWalshSize01
import SFT.Physics.QuantumSupportWalshSize02
import SFT.Physics.QuantumSupportWalshSize03
import SFT.Physics.QuantumSupportWalshSize04
import SFT.Physics.QuantumSupportWalshSize05
import SFT.Physics.QuantumSupportWalshSize06
import SFT.Physics.QuantumSupportWalshSize07
import SFT.Physics.QuantumSupportWalshSize08
import SFT.Physics.QuantumSupportWalshSize09
import SFT.Physics.QuantumSupportWalshSize10
import SFT.Physics.QuantumSupportWalshSize11
import SFT.Physics.QuantumSupportWalshSize12
import SFT.Physics.QuantumSupportWalshSize13
import SFT.Physics.QuantumSupportWalshSize14
import SFT.Physics.QuantumSupportWalshSize15
import SFT.Physics.QuantumSupportWalshSize16
namespace SFT.Physics.QuantumSupportWalshOrderedAssembly
open QuantumSupportWalsh QuantumSupportPreparation QuantumSupportWalshBatch GeneratorOperations
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
def sizeStep (p : Nat × Nat) (size : Nat) : Except String (Nat × Nat) :=
 (combinations (size+1) (words 4)).foldlM (step (.integer 4)) p
theorem orderedCons (size : Nat) (rest : List Nat) (p q result : Nat × Nat)
 (head : sizeStep p size=.ok q) (tail : rest.foldlM sizeStep q=.ok result) :
 (size::rest).foldlM sizeStep p=.ok result := by
 change (do let q ← sizeStep p size; rest.foldlM sizeStep q)=.ok result
 rw [head]
 exact tail
theorem originalFourthSizes : (List.range 16).foldlM sizeStep (273,65)=.ok (65808,372) := by
 exact (orderedCons 0 [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15] (273,65) (289,81) (65808,372) (foldFromZero (.integer 4) (combinations 1 (words 4)) 16 16 273 65 originalSize01) (orderedCons 1 [2,3,4,5,6,7,8,9,10,11,12,13,14,15] (289,81) (409,201) (65808,372) (foldFromZero (.integer 4) (combinations 2 (words 4)) 120 120 289 81 originalSize02) (orderedCons 2 [3,4,5,6,7,8,9,10,11,12,13,14,15] (409,201) (969,201) (65808,372) (foldFromZero (.integer 4) (combinations 3 (words 4)) 560 0 409 201 originalSize03) (orderedCons 3 [4,5,6,7,8,9,10,11,12,13,14,15] (969,201) (2789,341) (65808,372) (foldFromZero (.integer 4) (combinations 4 (words 4)) 1820 140 969 201 originalSize04) (orderedCons 4 [5,6,7,8,9,10,11,12,13,14,15] (2789,341) (7157,341) (65808,372) (foldFromZero (.integer 4) (combinations 5 (words 4)) 4368 0 2789 341 originalSize05) (orderedCons 5 [6,7,8,9,10,11,12,13,14,15] (7157,341) (15165,341) (65808,372) (foldFromZero (.integer 4) (combinations 6 (words 4)) 8008 0 7157 341 originalSize06) (orderedCons 6 [7,8,9,10,11,12,13,14,15] (15165,341) (26605,341) (65808,372) (foldFromZero (.integer 4) (combinations 7 (words 4)) 11440 0 15165 341 originalSize07) (orderedCons 7 [8,9,10,11,12,13,14,15] (26605,341) (39475,371) (65808,372) (foldFromZero (.integer 4) (combinations 8 (words 4)) 12870 30 26605 341 originalSize08) (orderedCons 8 [9,10,11,12,13,14,15] (39475,371) (50915,371) (65808,372) (foldFromZero (.integer 4) (combinations 9 (words 4)) 11440 0 39475 371 originalSize09) (orderedCons 9 [10,11,12,13,14,15] (50915,371) (58923,371) (65808,372) (foldFromZero (.integer 4) (combinations 10 (words 4)) 8008 0 50915 371 originalSize10) (orderedCons 10 [11,12,13,14,15] (58923,371) (63291,371) (65808,372) (foldFromZero (.integer 4) (combinations 11 (words 4)) 4368 0 58923 371 originalSize11) (orderedCons 11 [12,13,14,15] (63291,371) (65111,371) (65808,372) (foldFromZero (.integer 4) (combinations 12 (words 4)) 1820 0 63291 371 originalSize12) (orderedCons 12 [13,14,15] (65111,371) (65671,371) (65808,372) (foldFromZero (.integer 4) (combinations 13 (words 4)) 560 0 65111 371 originalSize13) (orderedCons 13 [14,15] (65671,371) (65791,371) (65808,372) (foldFromZero (.integer 4) (combinations 14 (words 4)) 120 0 65671 371 originalSize14) (orderedCons 14 [15] (65791,371) (65807,371) (65808,372) (foldFromZero (.integer 4) (combinations 15 (words 4)) 16 0 65791 371 originalSize15) (orderedCons 15 [] (65807,371) (65808,372) (65808,372) (foldFromZero (.integer 4) (combinations 16 (words 4)) 1 1 65807 371 originalSize16) (Eq.refl (Except.ok (65808,372)))))))))))))))))))
theorem originalFourthDepth : depthStep (273,65) 3=.ok (65808,372) :=
 (originalFourthGuard (273,65)).trans originalFourthSizes
theorem depthLast (earlier : List Nat) (index : Nat) (p result : Nat × Nat)
 (prior : earlier.foldlM depthStep (0,0)=.ok p) (last : depthStep p index=.ok result) :
 (earlier++[index]).foldlM depthStep (0,0)=.ok result := by
 rw [depthAppend,prior]
 change (Except.bind (depthStep p index) (fun q => Except.ok q))=.ok result
 rw [last]
 rfl
theorem originalAllDepthTotals : (List.range 4).foldlM depthStep (0,0)=.ok (65808,372) :=
 depthLast [0,1,2] 3 (273,65) (65808,372) originalFirstThreeTotals originalFourthDepth
theorem sourceCensusResult (input : CountInput) (limit total saturated : Nat)
 (accepted : SpinStatisticsCondensation.positiveWhole input "Walsh census depth"=.ok limit)
 (counts : (List.range limit).foldlM depthStep (0,0)=.ok (total,saturated)) :
 completeWalshCensus input=.ok ⟨limit,total,saturated,true⟩ := by
 rw [originalRepresentation]
 unfold assembledCensus
 rw [accepted]
 change (do let p ← (List.range limit).foldlM depthStep (0,0); pure (WalshCensus.mk limit p.1 p.2 true))=Except.ok (WalshCensus.mk limit total saturated true)
 rw [counts]
 rfl
theorem originalCompleteCensus : completeWalshCensus (.integer 4)=.ok ⟨4,65808,372,true⟩ :=
 sourceCensusResult (.integer 4) 4 65808 372 rfl originalAllDepthTotals
#print axioms orderedCons
#print axioms originalFourthSizes
#print axioms originalFourthDepth
#print axioms depthLast
#print axioms originalAllDepthTotals
#print axioms sourceCensusResult
#print axioms originalCompleteCensus
end SFT.Physics.QuantumSupportWalshOrderedAssembly
