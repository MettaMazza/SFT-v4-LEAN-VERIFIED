import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits21
import SFT.Physics.GrandLockVisitNode1601
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1604_4 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) after1603 [] = .ok after1603 := rfl
theorem children1604_3 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) before1603 ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok after1603 := by
 change (visit sourceDictionary534 533 visitedNode9150 before1603 "SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) done []) = _
 rewrite [visitCall1603]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) after1603 [] = _
 exact children1604_4
theorem children1604_2 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) before1602 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok after1603 := by
 change (visit sourceDictionary534 533 visitedNode9150 before1602 "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) done ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"]) = _
 rewrite [visitCall1602]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) after1602 ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = _
 exact children1604_3
theorem children1604_1 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) before1601 ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok after1603 := by
 change (visit sourceDictionary534 533 visitedNode9150 before1601 "SFT-PHYS-VACUUM-ODD-RECURRENCE-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) done ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"]) = _
 rewrite [visitCall1601]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) after1601 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = _
 exact children1604_2
theorem children1604_0 : recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) before1594 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok after1603 := by
 change (visit sourceDictionary534 533 visitedNode9150 before1594 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) done ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"]) = _
 rewrite [visitCall1594]
 change recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) after1594 ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = _
 exact children1604_1
theorem visitCall1604 : visit sourceDictionary534 534 visitedNode8422 before1604 "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003" = .ok after1604 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 533 visitedNode9150 done dep) before1594 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"]; pure (put done.1 "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003" (),done.2+1)) = _
 rewrite [children1604_0]
 rfl
#print axioms visitCall1604
end SFT.Physics.GrandLockDependencyTrace
