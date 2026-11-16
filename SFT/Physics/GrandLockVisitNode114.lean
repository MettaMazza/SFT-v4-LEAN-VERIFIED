import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitNode106
import SFT.Physics.GrandLockVisitHits1
import SFT.Physics.GrandLockVisitNode112
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children114_4 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) after113 [] = .ok after113 := rfl
theorem children114_3 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) before113 ["SFT-INFO-QUANTITY-001"] = .ok after113 := by
 change (visit sourceDictionary534 530 visitedNode1162 before113 "SFT-INFO-QUANTITY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) done []) = _
 rewrite [visitCall113]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) after113 [] = _
 exact children114_4
theorem children114_2 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) before112 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"] = .ok after113 := by
 change (visit sourceDictionary534 530 visitedNode1162 before112 "SFT-INFO-ENTROPY-UNCERTAINTY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) done ["SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall112]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) after112 ["SFT-INFO-QUANTITY-001"] = _
 exact children114_3
theorem children114_1 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) before107 ["SFT-MATH-COMBINATORICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"] = .ok after113 := by
 change (visit sourceDictionary534 530 visitedNode1162 before107 "SFT-MATH-COMBINATORICS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) done ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall107]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) after107 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"] = _
 exact children114_2
theorem children114_0 : recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) before106 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"] = .ok after113 := by
 change (visit sourceDictionary534 530 visitedNode1162 before106 "SFT-MATH-PROBABILITY-STATISTICS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) done ["SFT-MATH-COMBINATORICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall106]
 change recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) after106 ["SFT-MATH-COMBINATORICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"] = _
 exact children114_1
theorem visitCall114 : visit sourceDictionary534 531 visitedNode1108 before114 "SFT-INFO-MUTUAL-CONDITIONAL-001" = .ok after114 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 530 visitedNode1162 done dep) before106 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-QUANTITY-001"]; pure (put done.1 "SFT-INFO-MUTUAL-CONDITIONAL-001" (),done.2+1)) = _
 rewrite [children114_0]
 rfl
#print axioms visitCall114
end SFT.Physics.GrandLockDependencyTrace
