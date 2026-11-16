import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits1
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children112_4 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) after111 [] = .ok after111 := rfl
theorem children112_3 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) before111 ["SFT-INFO-QUANTITY-001"] = .ok after111 := by
 change (visit sourceDictionary534 529 visitedNode1226 before111 "SFT-INFO-QUANTITY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) done []) = _
 rewrite [visitCall111]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) after111 [] = _
 exact children112_4
theorem children112_2 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) before110 ["SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = .ok after111 := by
 change (visit sourceDictionary534 529 visitedNode1226 before110 "SFT-INFO-SYMBOL-DISTINCTION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) done ["SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall110]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) after110 ["SFT-INFO-QUANTITY-001"] = _
 exact children112_3
theorem children112_1 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) before109 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = .ok after111 := by
 change (visit sourceDictionary534 529 visitedNode1226 before109 "SFT-MATH-PROBABILITY-STATISTICS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) done ["SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall109]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) after109 ["SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = _
 exact children112_2
theorem children112_0 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) before108 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = .ok after111 := by
 change (visit sourceDictionary534 529 visitedNode1226 before108 "SFT-FOUNDATION-PART-EQUIVALENCE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) done ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"]) = _
 rewrite [visitCall108]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) after108 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = _
 exact children112_1
theorem visitCall112 : visit sourceDictionary534 530 visitedNode1162 before112 "SFT-INFO-ENTROPY-UNCERTAINTY-001" = .ok after112 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1226 done dep) before108 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"]; pure (put done.1 "SFT-INFO-ENTROPY-UNCERTAINTY-001" (),done.2+1)) = _
 rewrite [children112_0]
 rfl
#print axioms visitCall112
end SFT.Physics.GrandLockDependencyTrace
