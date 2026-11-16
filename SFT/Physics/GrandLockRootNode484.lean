import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents484_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_7 [] = .ok state484_7 := rfl
theorem parents484_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_6 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state484_7 := rfl
theorem parents484_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_5 ["SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state484_7 := rfl
theorem parents484_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_4 ["SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state484_7 := rfl
theorem parents484_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_3 ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state484_7 := rfl
theorem parents484_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_2 ["SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state484_7 := rfl
theorem parents484_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state484_7 := rfl
theorem parents484_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state484_7 := by
 change (reachesOne sourceDictionary534 534 memoNode7556 "SFT-PHYS-MECH-EVENT-CHANGE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"]) = _
 rewrite [rootCall483]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_1 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = _
 exact parents484_1
theorem rootCall484 : reachesOne sourceDictionary534 535 memoNode7556 "SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001" = .ok result484 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state484_0 ["SFT-PHYS-MECH-EVENT-CHANGE-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001","SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-MATTER-MASS-ENERGY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"]; pure (result.1,put result.2 "SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001" result.1)) = _
 rewrite [parents484_0]
 rfl
#print axioms rootCall484
end SFT.Physics.GrandLockRootTrace
