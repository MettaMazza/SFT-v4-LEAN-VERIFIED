import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents224_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_7 [] = .ok state224_7 := rfl
theorem parents224_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_6 ["SFT-PHYS-GRAVITY-FIELD-SOURCE-001"] = .ok state224_7 := rfl
theorem parents224_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_5 ["SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"] = .ok state224_7 := rfl
theorem parents224_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_4 ["SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"] = .ok state224_7 := rfl
theorem parents224_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_3 ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"] = .ok state224_7 := rfl
theorem parents224_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_2 ["SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"] = .ok state224_7 := rfl
theorem parents224_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"] = .ok state224_7 := rfl
theorem parents224_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"] = .ok state224_7 := by
 change (reachesOne sourceDictionary534 534 memoNode3944 "SFT-PHYS-MECH-EVENT-CHANGE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"]) = _
 rewrite [rootCall223]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"] = _
 exact parents224_1
theorem rootCall224 : reachesOne sourceDictionary534 535 memoNode3944 "SFT-PHYS-GRAVITY-WAVE-001" = .ok result224 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state224_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-WAVE-001" result.1)) = _
 rewrite [parents224_0]
 rfl
#print axioms rootCall224
end SFT.Physics.GrandLockRootTrace
