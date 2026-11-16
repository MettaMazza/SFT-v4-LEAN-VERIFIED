import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents34_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state34_3 [] = .ok state34_3 := rfl
theorem parents34_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state34_2 ["SFT-FOUNDATION-PART-001"] = .ok state34_3 := rfl
theorem parents34_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state34_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok state34_3 := rfl
theorem parents34_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state34_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok state34_3 := by
 change (reachesOne sourceDictionary534 532 memoNode656 "SFT-FOUNDATION-ONE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]) = _
 rewrite [rootCall33]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state34_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = _
 exact parents34_1
theorem rootCall34 : reachesOne sourceDictionary534 533 memoNode656 "SFT-FOUNDATION-EXACT-OPERATIONS-001" = .ok result34 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state34_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-EXACT-OPERATIONS-001" result.1)) = _
 rewrite [parents34_0]
 rfl
#print axioms rootCall34
end SFT.Physics.GrandLockRootTrace
