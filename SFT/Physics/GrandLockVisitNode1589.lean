import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitNode1564
import SFT.Physics.GrandLockVisitHits20
import SFT.Physics.GrandLockVisitNode1588
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1589_3 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) after1588 [] = .ok after1588 := rfl
theorem children1589_2 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) before1588 ["SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = .ok after1588 := by
 change (visit sourceDictionary534 532 visitedNode8541 before1588 "SFT-PHYS-FIELD-INVERSE-SQUARE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) done []) = _
 rewrite [visitCall1588]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) after1588 [] = _
 exact children1589_3
theorem children1589_1 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) before1565 ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = .ok after1588 := by
 change (visit sourceDictionary534 532 visitedNode8541 before1565 "SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) done ["SFT-PHYS-FIELD-INVERSE-SQUARE-001"]) = _
 rewrite [visitCall1565]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) after1565 ["SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = _
 exact children1589_2
theorem children1589_0 : recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) before1564 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = .ok after1588 := by
 change (visit sourceDictionary534 532 visitedNode8541 before1564 "SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) done ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"]) = _
 rewrite [visitCall1564]
 change recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) after1564 ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"] = _
 exact children1589_1
theorem visitCall1589 : visit sourceDictionary534 533 visitedNode8501 before1589 "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003" = .ok after1589 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 532 visitedNode8541 done dep) before1564 ["SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001"]; pure (put done.1 "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003" (),done.2+1)) = _
 rewrite [children1589_0]
 rfl
#print axioms visitCall1589
end SFT.Physics.GrandLockDependencyTrace
