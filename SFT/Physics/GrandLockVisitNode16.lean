import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits0
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children16_3 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) after15 [] = .ok after15 := rfl
theorem children16_2 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) before15 ["SFT-FOUNDATION-PART-001"] = .ok after15 := by
 change (visit sourceDictionary534 532 visitedNode320 before15 "SFT-FOUNDATION-PART-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) done []) = _
 rewrite [visitCall15]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) after15 [] = _
 exact children16_3
theorem children16_1 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) before14 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok after15 := by
 change (visit sourceDictionary534 532 visitedNode320 before14 "SFT-FOUNDATION-COUNT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) done ["SFT-FOUNDATION-PART-001"]) = _
 rewrite [visitCall14]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) after14 ["SFT-FOUNDATION-PART-001"] = _
 exact children16_2
theorem children16_0 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) before13 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok after15 := by
 change (visit sourceDictionary534 532 visitedNode320 before13 "SFT-FOUNDATION-ONE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) done ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]) = _
 rewrite [visitCall13]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) after13 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = _
 exact children16_1
theorem visitCall16 : visit sourceDictionary534 533 visitedNode71 before16 "SFT-FOUNDATION-PART-EQUIVALENCE-001" = .ok after16 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 532 visitedNode320 done dep) before13 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]; pure (put done.1 "SFT-FOUNDATION-PART-EQUIVALENCE-001" (),done.2+1)) = _
 rewrite [children16_0]
 rfl
#print axioms visitCall16
end SFT.Physics.GrandLockDependencyTrace
