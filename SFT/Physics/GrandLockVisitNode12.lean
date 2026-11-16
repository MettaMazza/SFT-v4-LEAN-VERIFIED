import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits0
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children12_2 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode269 done dep) after11 [] = .ok after11 := rfl
theorem children12_1 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode269 done dep) before11 ["SFT-FOUNDATION-FOLD-001"] = .ok after11 := by
 change (visit sourceDictionary534 532 visitedNode269 before11 "SFT-FOUNDATION-FOLD-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode269 done dep) done []) = _
 rewrite [visitCall11]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode269 done dep) after11 [] = _
 exact children12_2
theorem children12_0 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode269 done dep) before10 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-FOLD-001"] = .ok after11 := by
 change (visit sourceDictionary534 532 visitedNode269 before10 "SFT-FOUNDATION-COUNT-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode269 done dep) done ["SFT-FOUNDATION-FOLD-001"]) = _
 rewrite [visitCall10]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode269 done dep) after10 ["SFT-FOUNDATION-FOLD-001"] = _
 exact children12_1
theorem visitCall12 : visit sourceDictionary534 533 visitedNode71 before12 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" = .ok after12 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 532 visitedNode269 done dep) before10 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-FOLD-001"]; pure (put done.1 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" (),done.2+1)) = _
 rewrite [children12_0]
 rfl
#print axioms visitCall12
end SFT.Physics.GrandLockDependencyTrace
