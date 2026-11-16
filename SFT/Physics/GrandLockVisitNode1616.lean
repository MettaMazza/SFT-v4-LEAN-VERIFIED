import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits21
import SFT.Physics.GrandLockVisitNode1614
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1616_4 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) after1615 [] = .ok after1615 := rfl
theorem children1616_3 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) before1615 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok after1615 := by
 change (visit sourceDictionary534 534 visitedNode9304 before1615 "SFT-MATH-EXACT-ARITHMETIC-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) done []) = _
 rewrite [visitCall1615]
 change recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) after1615 [] = _
 exact children1616_4
theorem children1616_2 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) before1614 ["SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok after1615 := by
 change (visit sourceDictionary534 534 visitedNode9304 before1614 "SFT-FOUNDATION-HALF-ONE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) done ["SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [visitCall1614]
 change recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) after1614 ["SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact children1616_3
theorem children1616_1 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) before1607 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok after1615 := by
 change (visit sourceDictionary534 534 visitedNode9304 before1607 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) done ["SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [visitCall1607]
 change recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) after1607 ["SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact children1616_2
theorem children1616_0 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) before1606 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok after1615 := by
 change (visit sourceDictionary534 534 visitedNode9304 before1606 "SFT-PHYS-SPACE-DIMENSION-THREE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) done ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [visitCall1606]
 change recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) after1606 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact children1616_1
theorem visitCall1616 : visit sourceDictionary534 535 visitedNode0 before1616 "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004" = .ok after1616 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 534 visitedNode9304 done dep) before1606 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-HALF-ONE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (put done.1 "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004" (),done.2+1)) = _
 rewrite [children1616_0]
 rfl
#print axioms visitCall1616
end SFT.Physics.GrandLockDependencyTrace
