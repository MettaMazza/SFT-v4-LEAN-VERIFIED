import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits0
import SFT.Physics.GrandLockVisitNode78
import SFT.Physics.GrandLockVisitNode92
import SFT.Physics.GrandLockVisitNode115
import SFT.Physics.GrandLockVisitNode120
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children121_5 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) after120 [] = .ok after120 := rfl
theorem children121_4 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) before120 ["SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok after120 := by
 change (visit sourceDictionary534 532 visitedNode861 before120 "SFT-INFO-CLASSICAL-PROBABILISTIC-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) done []) = _
 rewrite [visitCall120]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) after120 [] = _
 exact children121_5
theorem children121_3 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) before115 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok after120 := by
 change (visit sourceDictionary534 532 visitedNode861 before115 "SFT-INFO-CONSERVATION-LOSS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) done ["SFT-INFO-CLASSICAL-PROBABILISTIC-001"]) = _
 rewrite [visitCall115]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) after115 ["SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = _
 exact children121_4
theorem children121_2 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) before92 ["SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok after120 := by
 change (visit sourceDictionary534 532 visitedNode861 before92 "SFT-INFO-QUANTITY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) done ["SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"]) = _
 rewrite [visitCall92]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) after92 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = _
 exact children121_3
theorem children121_1 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) before78 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok after120 := by
 change (visit sourceDictionary534 532 visitedNode861 before78 "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) done ["SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"]) = _
 rewrite [visitCall78]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) after78 ["SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = _
 exact children121_2
theorem children121_0 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) before69 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok after120 := by
 change (visit sourceDictionary534 532 visitedNode861 before69 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) done ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"]) = _
 rewrite [visitCall69]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) after69 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = _
 exact children121_1
theorem visitCall121 : visit sourceDictionary534 533 visitedNode834 before121 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" = .ok after121 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 532 visitedNode861 done dep) before69 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"]; pure (put done.1 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" (),done.2+1)) = _
 rewrite [children121_0]
 rfl
#print axioms visitCall121
end SFT.Physics.GrandLockDependencyTrace
