import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents154_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_6 [] = .ok state154_6 := rfl
theorem parents154_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_5 ["SFT-PHYS-FIELD-SOURCE-RESPONSE-001"] = .ok state154_6 := rfl
theorem parents154_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_4 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"] = .ok state154_6 := rfl
theorem parents154_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_3 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"] = .ok state154_6 := rfl
theorem parents154_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_2 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"] = .ok state154_6 := rfl
theorem parents154_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"] = .ok state154_6 := rfl
theorem parents154_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"] = .ok state154_6 := by
 change (reachesOne sourceDictionary534 534 memoNode2970 "SFT-MATH-GEOMETRY-TOPOLOGY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"]) = _
 rewrite [rootCall153]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"] = _
 exact parents154_1
theorem rootCall154 : reachesOne sourceDictionary534 535 memoNode2970 "SFT-PHYS-FIELD-GEOMETRIC-DILUTION-001" = .ok result154 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state154_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-SOURCE-RESPONSE-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-GEOMETRIC-DILUTION-001" result.1)) = _
 rewrite [parents154_0]
 rfl
#print axioms rootCall154
end SFT.Physics.GrandLockRootTrace
