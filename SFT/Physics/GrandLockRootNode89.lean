import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents89_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state89_3 [] = .ok state89_3 := rfl
theorem parents89_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state89_2 ["SFT-FOUNDATION-PART-001"] = .ok state89_3 := rfl
theorem parents89_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state89_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok state89_3 := rfl
theorem parents89_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state89_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok state89_3 := by
 change (reachesOne sourceDictionary534 532 memoNode1572 "SFT-FOUNDATION-ONE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]) = _
 rewrite [rootCall88]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state89_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = _
 exact parents89_1
theorem rootCall89 : reachesOne sourceDictionary534 533 memoNode1572 "SFT-FOUNDATION-FOLD-001" = .ok result89 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state89_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-FOLD-001" result.1)) = _
 rewrite [parents89_0]
 rfl
#print axioms rootCall89
end SFT.Physics.GrandLockRootTrace
