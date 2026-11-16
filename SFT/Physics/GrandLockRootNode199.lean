import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents199_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_7 [] = .ok state199_7 := rfl
theorem parents199_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_6 ["SFT-PHYS-SPACETIME-LENGTH-RELATION-001"] = .ok state199_7 := rfl
theorem parents199_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_5 ["SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"] = .ok state199_7 := rfl
theorem parents199_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_4 ["SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"] = .ok state199_7 := rfl
theorem parents199_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_3 ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"] = .ok state199_7 := rfl
theorem parents199_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_2 ["SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"] = .ok state199_7 := rfl
theorem parents199_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"] = .ok state199_7 := rfl
theorem parents199_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"] = .ok state199_7 := by
 change (reachesOne sourceDictionary534 534 memoNode3533 "SFT-PHYS-MECH-EVENT-CHANGE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"]) = _
 rewrite [rootCall198]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"] = _
 exact parents199_1
theorem rootCall199 : reachesOne sourceDictionary534 535 memoNode3533 "SFT-PHYS-GRAVITY-EQUIVALENCE-001" = .ok result199 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state199_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-LENGTH-RELATION-001"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-EQUIVALENCE-001" result.1)) = _
 rewrite [parents199_0]
 rfl
#print axioms rootCall199
end SFT.Physics.GrandLockRootTrace
