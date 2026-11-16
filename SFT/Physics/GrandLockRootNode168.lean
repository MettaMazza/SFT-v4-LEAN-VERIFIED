import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents168_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_6 [] = .ok state168_6 := rfl
theorem parents168_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_5 ["SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state168_6 := rfl
theorem parents168_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_4 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state168_6 := rfl
theorem parents168_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_3 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state168_6 := rfl
theorem parents168_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_2 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state168_6 := rfl
theorem parents168_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state168_6 := rfl
theorem parents168_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state168_6 := by
 change (reachesOne sourceDictionary534 534 memoNode3173 "SFT-MATH-GEOMETRY-TOPOLOGY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"]) = _
 rewrite [rootCall167]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = _
 exact parents168_1
theorem rootCall168 : reachesOne sourceDictionary534 535 memoNode3173 "SFT-PHYS-FIELD-MAGNETIC-001" = .ok result168 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state168_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-MAGNETIC-001" result.1)) = _
 rewrite [parents168_0]
 rfl
#print axioms rootCall168
end SFT.Physics.GrandLockRootTrace
