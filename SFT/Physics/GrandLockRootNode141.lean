import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents141_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_6 [] = .ok state141_6 := rfl
theorem parents141_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_5 ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state141_6 := rfl
theorem parents141_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_4 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state141_6 := rfl
theorem parents141_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_3 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state141_6 := rfl
theorem parents141_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_2 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state141_6 := rfl
theorem parents141_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state141_6 := rfl
theorem parents141_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state141_6 := by
 change (reachesOne sourceDictionary534 534 memoNode2689 "SFT-MATH-GEOMETRY-TOPOLOGY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"]) = _
 rewrite [rootCall140]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = _
 exact parents141_1
theorem rootCall141 : reachesOne sourceDictionary534 535 memoNode2689 "SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001" = .ok result141 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state141_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001" result.1)) = _
 rewrite [parents141_0]
 rfl
#print axioms rootCall141
end SFT.Physics.GrandLockRootTrace
