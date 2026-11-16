import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents173_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_6 [] = .ok state173_6 := rfl
theorem parents173_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_5 ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"] = .ok state173_6 := rfl
theorem parents173_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_4 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"] = .ok state173_6 := rfl
theorem parents173_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_3 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"] = .ok state173_6 := rfl
theorem parents173_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_2 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"] = .ok state173_6 := rfl
theorem parents173_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"] = .ok state173_6 := rfl
theorem parents173_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"] = .ok state173_6 := by
 change (reachesOne sourceDictionary534 534 memoNode3198 "SFT-MATH-GEOMETRY-TOPOLOGY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"]) = _
 rewrite [rootCall172]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"] = _
 exact parents173_1
theorem rootCall173 : reachesOne sourceDictionary534 535 memoNode3198 "SFT-PHYS-FIELD-RADIATION-001" = .ok result173 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state173_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-RADIATION-001" result.1)) = _
 rewrite [parents173_0]
 rfl
#print axioms rootCall173
end SFT.Physics.GrandLockRootTrace
