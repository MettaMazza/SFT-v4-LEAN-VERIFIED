import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitNode1528
import SFT.Physics.GrandLockVisitNode1592
import SFT.Physics.GrandLockVisitHits21
import SFT.Physics.GrandLockVisitNode1604
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1605_4 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) after1604 [] = .ok after1604 := rfl
theorem children1605_3 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) before1604 ["SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = .ok after1604 := by
 change (visit sourceDictionary534 534 visitedNode8422 before1604 "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) done []) = _
 rewrite [visitCall1604]
 change recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) after1604 [] = _
 exact children1605_4
theorem children1605_2 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) before1593 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = .ok after1604 := by
 change (visit sourceDictionary534 534 visitedNode8422 before1593 "SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) done ["SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"]) = _
 rewrite [visitCall1593]
 change recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) after1593 ["SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = _
 exact children1605_3
theorem children1605_1 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) before1592 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = .ok after1604 := by
 change (visit sourceDictionary534 534 visitedNode8422 before1592 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) done ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"]) = _
 rewrite [visitCall1592]
 change recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) after1592 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = _
 exact children1605_2
theorem children1605_0 : recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) before1528 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = .ok after1604 := by
 change (visit sourceDictionary534 534 visitedNode8422 before1528 "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) done ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"]) = _
 rewrite [visitCall1528]
 change recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) after1528 ["SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"] = _
 exact children1605_1
theorem visitCall1605 : visit sourceDictionary534 535 visitedNode0 before1605 "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004" = .ok after1605 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 534 visitedNode8422 done dep) before1528 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004","SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"]; pure (put done.1 "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004" (),done.2+1)) = _
 rewrite [children1605_0]
 rfl
#print axioms visitCall1605
end SFT.Physics.GrandLockDependencyTrace
