import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents490_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_7 [] = .ok state490_7 := rfl
theorem parents490_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_6 ["SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"] = .ok state490_7 := rfl
theorem parents490_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_5 ["SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"] = .ok state490_7 := rfl
theorem parents490_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_4 ["SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"] = .ok state490_7 := rfl
theorem parents490_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_3 ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"] = .ok state490_7 := rfl
theorem parents490_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_2 ["SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"] = .ok state490_7 := rfl
theorem parents490_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"] = .ok state490_7 := rfl
theorem parents490_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"] = .ok state490_7 := by
 change (reachesOne sourceDictionary534 534 memoNode7643 "SFT-PHYS-MECH-EVENT-CHANGE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"]) = _
 rewrite [rootCall489]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"] = _
 exact parents490_1
theorem rootCall490 : reachesOne sourceDictionary534 535 memoNode7643 "SFT-PHYS-SPACETIME-LIMIT-SPEED-001" = .ok result490 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state490_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001"]; pure (result.1,put result.2 "SFT-PHYS-SPACETIME-LIMIT-SPEED-001" result.1)) = _
 rewrite [parents490_0]
 rfl
#print axioms rootCall490
end SFT.Physics.GrandLockRootTrace
