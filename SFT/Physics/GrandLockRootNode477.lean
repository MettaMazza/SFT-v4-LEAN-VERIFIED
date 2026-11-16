import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents477_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state477_3 [] = .ok state477_3 := rfl
theorem parents477_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state477_2 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state477_3 := rfl
theorem parents477_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state477_1 ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state477_3 := rfl
theorem parents477_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state477_0 ["SFT-PHYS-GRAVITY-HORIZON-INFORMATION-003","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = .ok state477_3 := by
 change (reachesOne sourceDictionary534 532 memoNode7435 "SFT-PHYS-GRAVITY-HORIZON-INFORMATION-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"]) = _
 rewrite [rootCall476]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state477_1 ["SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"] = _
 exact parents477_1
theorem rootCall477 : reachesOne sourceDictionary534 533 memoNode7435 "SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003" = .ok result477 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state477_0 ["SFT-PHYS-GRAVITY-HORIZON-INFORMATION-003","SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001","SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"]; pure (result.1,put result.2 "SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003" result.1)) = _
 rewrite [parents477_0]
 rfl
#print axioms rootCall477
end SFT.Physics.GrandLockRootTrace
