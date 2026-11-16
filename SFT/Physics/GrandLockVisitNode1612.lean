import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits21
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1612_3 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) after1611 [] = .ok after1611 := rfl
theorem children1612_2 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) before1611 ["SFT-FOUNDATION-PART-001"] = .ok after1611 := by
 change (visit sourceDictionary534 532 visitedNode9353 before1611 "SFT-FOUNDATION-PART-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) done []) = _
 rewrite [visitCall1611]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) after1611 [] = _
 exact children1612_3
theorem children1612_1 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) before1610 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok after1611 := by
 change (visit sourceDictionary534 532 visitedNode9353 before1610 "SFT-FOUNDATION-COUNT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) done ["SFT-FOUNDATION-PART-001"]) = _
 rewrite [visitCall1610]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) after1610 ["SFT-FOUNDATION-PART-001"] = _
 exact children1612_2
theorem children1612_0 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) before1609 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok after1611 := by
 change (visit sourceDictionary534 532 visitedNode9353 before1609 "SFT-FOUNDATION-ONE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) done ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]) = _
 rewrite [visitCall1609]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) after1609 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = _
 exact children1612_1
theorem visitCall1612 : visit sourceDictionary534 533 visitedNode9323 before1612 "SFT-FOUNDATION-EXACT-OPERATIONS-001" = .ok after1612 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9353 done dep) before1609 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]; pure (put done.1 "SFT-FOUNDATION-EXACT-OPERATIONS-001" (),done.2+1)) = _
 rewrite [children1612_0]
 rfl
#print axioms visitCall1612
end SFT.Physics.GrandLockDependencyTrace
