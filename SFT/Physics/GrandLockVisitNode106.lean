import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits1
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children106_4 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) after105 [] = .ok after105 := rfl
theorem children106_3 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) before105 ["SFT-MATH-COMBINATORICS-001"] = .ok after105 := by
 change (visit sourceDictionary534 529 visitedNode1190 before105 "SFT-MATH-COMBINATORICS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) done []) = _
 rewrite [visitCall105]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) after105 [] = _
 exact children106_4
theorem children106_2 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) before104 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after105 := by
 change (visit sourceDictionary534 529 visitedNode1190 before104 "SFT-MATH-EXACT-ARITHMETIC-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) done ["SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall104]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) after104 ["SFT-MATH-COMBINATORICS-001"] = _
 exact children106_3
theorem children106_1 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) before103 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after105 := by
 change (visit sourceDictionary534 529 visitedNode1190 before103 "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) done ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall103]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) after103 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children106_2
theorem children106_0 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) before102 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = .ok after105 := by
 change (visit sourceDictionary534 529 visitedNode1190 before102 "SFT-FOUNDATION-PART-EQUIVALENCE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) done ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [visitCall102]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) after102 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"] = _
 exact children106_1
theorem visitCall106 : visit sourceDictionary534 530 visitedNode1162 before106 "SFT-MATH-PROBABILITY-STATISTICS-001" = .ok after106 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 529 visitedNode1190 done dep) before102 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001"]; pure (put done.1 "SFT-MATH-PROBABILITY-STATISTICS-001" (),done.2+1)) = _
 rewrite [children106_0]
 rfl
#print axioms visitCall106
end SFT.Physics.GrandLockDependencyTrace
