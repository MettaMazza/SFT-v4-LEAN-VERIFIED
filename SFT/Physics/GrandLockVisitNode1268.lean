import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockTraceFoldStep
import SFT.Physics.GrandLockVisitUnfold528
import SFT.Physics.GrandLockVisitHits16
import SFT.Physics.GrandLockVisitNode1267
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
noncomputable def step1268 (state : Complete) (dep : String) : Except String Complete := visit sourceDictionary534 527 (put visitedNode6539 "SFT-PHYS-MECH-ANGULAR-MOTION-001" ()) state dep
theorem children1268_6 : recordFold step1268 after1267 [] = .ok after1267 := rfl
theorem children1268_5 : recordFold step1268 before1267 ["SFT-PHYS-MECH-POWER-001"] = .ok after1267 := sourceFoldCall step1268 before1267 after1267 after1267 "SFT-PHYS-MECH-POWER-001" [] visitCall1267 children1268_6
theorem children1268_4 : recordFold step1268 before1207 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] = .ok after1267 := sourceFoldCall step1268 before1207 after1207 after1267 "SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001" ["SFT-PHYS-MECH-POWER-001"] visitCall1207 children1268_5
theorem children1268_3 : recordFold step1268 before1206 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] = .ok after1267 := sourceFoldCall step1268 before1206 after1206 after1267 "SFT-INFO-CONSERVATION-LOSS-001" ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] visitCall1206 children1268_4
theorem children1268_2 : recordFold step1268 before1205 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] = .ok after1267 := sourceFoldCall step1268 before1205 after1205 after1267 "SFT-MATH-GEOMETRY-TOPOLOGY-001" ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] visitCall1205 children1268_3
theorem children1268_1 : recordFold step1268 before1204 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] = .ok after1267 := sourceFoldCall step1268 before1204 after1204 after1267 "SFT-MATH-DYNAMICAL-SYSTEMS-001" ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] visitCall1204 children1268_2
theorem children1268_0 : recordFold step1268 before1203 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] = .ok after1267 := sourceFoldCall step1268 before1203 after1203 after1267 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] visitCall1203 children1268_1
theorem visitCall1268 : visit sourceDictionary534 528 visitedNode6539 before1268 "SFT-PHYS-MECH-ANGULAR-MOTION-001" = .ok after1268 :=
 visitCallFromFold528 sourceDictionary534 visitedNode6539 before1268 after1267 "SFT-PHYS-MECH-ANGULAR-MOTION-001" ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-POWER-001"] (by rfl) (by rfl) (by rfl) children1268_0
#print axioms visitCall1268
end SFT.Physics.GrandLockDependencyTrace
