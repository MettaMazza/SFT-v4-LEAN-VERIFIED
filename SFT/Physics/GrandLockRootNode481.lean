import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents481_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_6 [] = .ok state481_6 := rfl
theorem parents481_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_5 ["SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state481_6 := rfl
theorem parents481_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_4 ["SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state481_6 := rfl
theorem parents481_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_3 ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state481_6 := rfl
theorem parents481_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_2 ["SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state481_6 := rfl
theorem parents481_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state481_6 := rfl
theorem parents481_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = .ok state481_6 := by
 change (reachesOne sourceDictionary534 534 memoNode7529 "SFT-PHYS-MECH-EVENT-CHANGE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001"]) = _
 rewrite [rootCall480]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001"] = _
 exact parents481_1
theorem rootCall481 : reachesOne sourceDictionary534 535 memoNode7529 "SFT-PHYS-SPACETIME-EVENT-RELATION-001" = .ok result481 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state481_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001"]; pure (result.1,put result.2 "SFT-PHYS-SPACETIME-EVENT-RELATION-001" result.1)) = _
 rewrite [parents481_0]
 rfl
#print axioms rootCall481
end SFT.Physics.GrandLockRootTrace
