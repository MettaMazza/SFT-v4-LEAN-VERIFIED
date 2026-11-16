import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits16
import SFT.Physics.GrandLockVisitNode1265
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1266_6 : recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) after1265 [] = .ok after1265 := rfl
theorem children1266_5 : recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) before1265 ["SFT-PHYS-MECH-FORCE-001"] = .ok after1265 := by
 change (visit sourceDictionary534 525 visitedNode6604 before1265 "SFT-PHYS-MECH-FORCE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) done []) = _
 rewrite [visitCall1265]
 change recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) after1265 [] = _
 exact children1266_6
theorem children1266_4 : recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) before1217 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = .ok after1265 := by
 change (visit sourceDictionary534 525 visitedNode6604 before1217 "SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) done ["SFT-PHYS-MECH-FORCE-001"]) = _
 rewrite [visitCall1217]
 change recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) after1217 ["SFT-PHYS-MECH-FORCE-001"] = _
 exact children1266_5
theorem children1266_3 : recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) before1216 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = .ok after1265 := by
 change (visit sourceDictionary534 525 visitedNode6604 before1216 "SFT-INFO-CONSERVATION-LOSS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) done ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"]) = _
 rewrite [visitCall1216]
 change recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) after1216 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = _
 exact children1266_4
theorem children1266_2 : recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) before1215 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = .ok after1265 := by
 change (visit sourceDictionary534 525 visitedNode6604 before1215 "SFT-MATH-GEOMETRY-TOPOLOGY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) done ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"]) = _
 rewrite [visitCall1215]
 change recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) after1215 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = _
 exact children1266_3
theorem children1266_1 : recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) before1214 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = .ok after1265 := by
 change (visit sourceDictionary534 525 visitedNode6604 before1214 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) done ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"]) = _
 rewrite [visitCall1214]
 change recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) after1214 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = _
 exact children1266_2
theorem children1266_0 : recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) before1213 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = .ok after1265 := by
 change (visit sourceDictionary534 525 visitedNode6604 before1213 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) done ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"]) = _
 rewrite [visitCall1213]
 change recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) after1213 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"] = _
 exact children1266_1
theorem visitCall1266 : visit sourceDictionary534 526 visitedNode6581 before1266 "SFT-PHYS-MECH-WORK-ENERGY-001" = .ok after1266 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 525 visitedNode6604 done dep) before1213 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-FORCE-001"]; pure (put done.1 "SFT-PHYS-MECH-WORK-ENERGY-001" (),done.2+1)) = _
 rewrite [children1266_0]
 rfl
#print axioms visitCall1266
end SFT.Physics.GrandLockDependencyTrace
