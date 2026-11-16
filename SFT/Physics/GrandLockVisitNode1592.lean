import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits20
import SFT.Physics.GrandLockVisitNode1589
import SFT.Physics.GrandLockVisitHits21
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1592_4 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) after1591 [] = .ok after1591 := rfl
theorem children1592_3 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) before1591 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok after1591 := by
 change (visit sourceDictionary534 533 visitedNode8501 before1591 "SFT-MATH-EXACT-ARITHMETIC-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) done []) = _
 rewrite [visitCall1591]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) after1591 [] = _
 exact children1592_4
theorem children1592_2 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) before1590 ["SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok after1591 := by
 change (visit sourceDictionary534 533 visitedNode8501 before1590 "SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) done ["SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [visitCall1590]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) after1590 ["SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact children1592_3
theorem children1592_1 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) before1589 ["SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok after1591 := by
 change (visit sourceDictionary534 533 visitedNode8501 before1589 "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) done ["SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [visitCall1589]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) after1589 ["SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact children1592_2
theorem children1592_0 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) before1529 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok after1591 := by
 change (visit sourceDictionary534 533 visitedNode8501 before1529 "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) done ["SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [visitCall1529]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) after1529 ["SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact children1592_1
theorem visitCall1592 : visit sourceDictionary534 534 visitedNode8422 before1592 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" = .ok after1592 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 533 visitedNode8501 done dep) before1529 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003","SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (put done.1 "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004" (),done.2+1)) = _
 rewrite [children1592_0]
 rfl
#print axioms visitCall1592
end SFT.Physics.GrandLockDependencyTrace
