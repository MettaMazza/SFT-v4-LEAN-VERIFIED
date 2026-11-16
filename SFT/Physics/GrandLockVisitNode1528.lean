import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits20
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1528_9 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1527 [] = .ok after1527 := rfl
theorem children1528_8 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1527 ["SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1527 "SFT-MATH-COMBINATORICS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done []) = _
 rewrite [visitCall1527]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1527 [] = _
 exact children1528_9
theorem children1528_7 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1526 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1526 "SFT-MATH-EXACT-ARITHMETIC-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done ["SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall1526]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1526 ["SFT-MATH-COMBINATORICS-001"] = _
 exact children1528_8
theorem children1528_6 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1525 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1525 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall1525]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1525 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children1528_7
theorem children1528_5 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1524 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1524 "SFT-FOUNDATION-FOLD-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall1524]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1524 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children1528_6
theorem children1528_4 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1523 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1523 "SFT-FOUNDATION-PART-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall1523]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1523 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children1528_5
theorem children1528_3 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1522 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1522 "SFT-FOUNDATION-COUNT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall1522]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1522 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children1528_4
theorem children1528_2 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1521 ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1521 "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall1521]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1521 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children1528_3
theorem children1528_1 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1520 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1520 "SFT-PHYS-SPACE-DIMENSION-THREE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall1520]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1520 ["SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children1528_2
theorem children1528_0 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1519 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after1527 := by
 change (visit sourceDictionary534 533 visitedNode8458 before1519 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) done ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall1519]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) after1519 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children1528_1
theorem visitCall1528 : visit sourceDictionary534 534 visitedNode8422 before1528 "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001" = .ok after1528 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8458 done dep) before1519 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]; pure (put done.1 "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001" (),done.2+1)) = _
 rewrite [children1528_0]
 rfl
#print axioms visitCall1528
end SFT.Physics.GrandLockDependencyTrace
