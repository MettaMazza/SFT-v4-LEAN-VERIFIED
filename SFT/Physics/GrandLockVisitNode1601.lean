import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits21
import SFT.Physics.GrandLockVisitNode1599
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1601_4 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) after1600 [] = .ok after1600 := rfl
theorem children1601_3 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) before1600 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after1600 := by
 change (visit sourceDictionary534 532 visitedNode9179 before1600 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) done []) = _
 rewrite [visitCall1600]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) after1600 [] = _
 exact children1601_4
theorem children1601_2 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) before1599 ["SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after1600 := by
 change (visit sourceDictionary534 532 visitedNode9179 before1599 "SFT-MATH-ORBIT-NUMBER-THEORY-002" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) done ["SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall1599]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) after1599 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children1601_3
theorem children1601_1 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) before1596 ["SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after1600 := by
 change (visit sourceDictionary534 532 visitedNode9179 before1596 "SFT-FOUNDATION-FOLD-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) done ["SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall1596]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) after1596 ["SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children1601_2
theorem children1601_0 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) before1595 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after1600 := by
 change (visit sourceDictionary534 532 visitedNode9179 before1595 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) done ["SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall1595]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) after1595 ["SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children1601_1
theorem visitCall1601 : visit sourceDictionary534 533 visitedNode9150 before1601 "SFT-PHYS-VACUUM-ODD-RECURRENCE-003" = .ok after1601 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 532 visitedNode9179 done dep) before1595 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (put done.1 "SFT-PHYS-VACUUM-ODD-RECURRENCE-003" (),done.2+1)) = _
 rewrite [children1601_0]
 rfl
#print axioms visitCall1601
end SFT.Physics.GrandLockDependencyTrace
