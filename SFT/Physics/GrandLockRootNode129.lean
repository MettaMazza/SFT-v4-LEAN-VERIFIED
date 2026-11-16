import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents129_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state129_2 [] = .ok state129_2 := rfl
theorem parents129_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state129_1 ["SFT-FOUNDATION-COUNT-001"] = .ok state129_2 := rfl
theorem parents129_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state129_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001"] = .ok state129_2 := by
 change (reachesOne sourceDictionary534 532 memoNode2464 "SFT-FOUNDATION-ONE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-FOUNDATION-COUNT-001"]) = _
 rewrite [rootCall128]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state129_1 ["SFT-FOUNDATION-COUNT-001"] = _
 exact parents129_1
theorem rootCall129 : reachesOne sourceDictionary534 533 memoNode2464 "SFT-FOUNDATION-PART-001" = .ok result129 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state129_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-PART-001" result.1)) = _
 rewrite [parents129_0]
 rfl
#print axioms rootCall129
end SFT.Physics.GrandLockRootTrace
