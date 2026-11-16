import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits21
import SFT.Physics.GrandLockVisitNode1612
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1614_3 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) after1613 [] = .ok after1613 := rfl
theorem children1614_2 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) before1613 ["SFT-FOUNDATION-PART-EQUIVALENCE-001"] = .ok after1613 := by
 change (visit sourceDictionary534 533 visitedNode9323 before1613 "SFT-FOUNDATION-PART-EQUIVALENCE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) done []) = _
 rewrite [visitCall1613]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) after1613 [] = _
 exact children1614_3
theorem children1614_1 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) before1612 ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"] = .ok after1613 := by
 change (visit sourceDictionary534 533 visitedNode9323 before1612 "SFT-FOUNDATION-EXACT-OPERATIONS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) done ["SFT-FOUNDATION-PART-EQUIVALENCE-001"]) = _
 rewrite [visitCall1612]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) after1612 ["SFT-FOUNDATION-PART-EQUIVALENCE-001"] = _
 exact children1614_2
theorem children1614_0 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) before1608 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"] = .ok after1613 := by
 change (visit sourceDictionary534 533 visitedNode9323 before1608 "SFT-FOUNDATION-FOLD-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) done ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"]) = _
 rewrite [visitCall1608]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) after1608 ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"] = _
 exact children1614_1
theorem visitCall1614 : visit sourceDictionary534 534 visitedNode9304 before1614 "SFT-FOUNDATION-HALF-ONE-001" = .ok after1614 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9323 done dep) before1608 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"]; pure (put done.1 "SFT-FOUNDATION-HALF-ONE-001" (),done.2+1)) = _
 rewrite [children1614_0]
 rfl
#print axioms visitCall1614
end SFT.Physics.GrandLockDependencyTrace
