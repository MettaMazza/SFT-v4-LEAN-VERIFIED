import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents1_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state1_1 [] = .ok state1_1 := rfl
theorem parents1_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state1_0 ["SFT-FOUNDATION-ONE-001"] = .ok state1_1 := by
 change (reachesOne sourceDictionary534 532 memoNode0 "SFT-FOUNDATION-ONE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next []) = _
 rewrite [rootCall0]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state1_1 [] = _
 exact parents1_1
theorem rootCall1 : reachesOne sourceDictionary534 533 memoNode0 "SFT-FOUNDATION-COUNT-001" = .ok result1 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state1_0 ["SFT-FOUNDATION-ONE-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-COUNT-001" result.1)) = _
 rewrite [parents1_0]
 rfl
#print axioms rootCall1
end SFT.Physics.GrandLockRootTrace
