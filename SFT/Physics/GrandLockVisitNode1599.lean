import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits21
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1599_2 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode9211 done dep) after1598 [] = .ok after1598 := rfl
theorem children1599_1 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode9211 done dep) before1598 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after1598 := by
 change (visit sourceDictionary534 531 visitedNode9211 before1598 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode9211 done dep) done []) = _
 rewrite [visitCall1598]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode9211 done dep) after1598 [] = _
 exact children1599_2
theorem children1599_0 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode9211 done dep) before1597 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok after1598 := by
 change (visit sourceDictionary534 531 visitedNode9211 before1597 "SFT-MATH-EXACT-ARITHMETIC-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode9211 done dep) done ["SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [visitCall1597]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode9211 done dep) after1597 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact children1599_1
theorem visitCall1599 : visit sourceDictionary534 532 visitedNode9179 before1599 "SFT-MATH-ORBIT-NUMBER-THEORY-002" = .ok after1599 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 531 visitedNode9211 done dep) before1597 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (put done.1 "SFT-MATH-ORBIT-NUMBER-THEORY-002" (),done.2+1)) = _
 rewrite [children1599_0]
 rfl
#print axioms visitCall1599
end SFT.Physics.GrandLockDependencyTrace
