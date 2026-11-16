import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits16
import SFT.Physics.GrandLockVisitNode1266
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children1267_6 : recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) after1266 [] = .ok after1266 := rfl
theorem children1267_5 : recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) before1266 ["SFT-PHYS-MECH-WORK-ENERGY-001"] = .ok after1266 := by
 change (visit sourceDictionary534 526 visitedNode6581 before1266 "SFT-PHYS-MECH-WORK-ENERGY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) done []) = _
 rewrite [visitCall1266]
 change recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) after1266 [] = _
 exact children1267_6
theorem children1267_4 : recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) before1212 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = .ok after1266 := by
 change (visit sourceDictionary534 526 visitedNode6581 before1212 "SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) done ["SFT-PHYS-MECH-WORK-ENERGY-001"]) = _
 rewrite [visitCall1212]
 change recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) after1212 ["SFT-PHYS-MECH-WORK-ENERGY-001"] = _
 exact children1267_5
theorem children1267_3 : recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) before1211 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = .ok after1266 := by
 change (visit sourceDictionary534 526 visitedNode6581 before1211 "SFT-INFO-CONSERVATION-LOSS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) done ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"]) = _
 rewrite [visitCall1211]
 change recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) after1211 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = _
 exact children1267_4
theorem children1267_2 : recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) before1210 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = .ok after1266 := by
 change (visit sourceDictionary534 526 visitedNode6581 before1210 "SFT-MATH-GEOMETRY-TOPOLOGY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) done ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"]) = _
 rewrite [visitCall1210]
 change recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) after1210 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = _
 exact children1267_3
theorem children1267_1 : recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) before1209 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = .ok after1266 := by
 change (visit sourceDictionary534 526 visitedNode6581 before1209 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) done ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"]) = _
 rewrite [visitCall1209]
 change recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) after1209 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = _
 exact children1267_2
theorem children1267_0 : recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) before1208 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = .ok after1266 := by
 change (visit sourceDictionary534 526 visitedNode6581 before1208 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) done ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"]) = _
 rewrite [visitCall1208]
 change recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) after1208 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"] = _
 exact children1267_1
theorem visitCall1267 : visit sourceDictionary534 527 visitedNode6564 before1267 "SFT-PHYS-MECH-POWER-001" = .ok after1267 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 526 visitedNode6581 done dep) before1208 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-WORK-ENERGY-001"]; pure (put done.1 "SFT-PHYS-MECH-POWER-001" (),done.2+1)) = _
 rewrite [children1267_0]
 rfl
#print axioms visitCall1267
end SFT.Physics.GrandLockDependencyTrace
