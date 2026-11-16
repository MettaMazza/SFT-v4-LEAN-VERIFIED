import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents62_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state62_2 [] = .ok state62_2 := rfl
theorem parents62_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state62_1 ["SFT-FOUNDATION-FOLD-001"] = .ok state62_2 := rfl
theorem parents62_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state62_0 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-FOLD-001"] = .ok state62_2 := by
 change (reachesOne sourceDictionary534 531 memoNode1165 "SFT-FOUNDATION-COUNT-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) next ["SFT-FOUNDATION-FOLD-001"]) = _
 rewrite [rootCall61]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state62_1 ["SFT-FOUNDATION-FOLD-001"] = _
 exact parents62_1
theorem rootCall62 : reachesOne sourceDictionary534 532 memoNode1165 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" = .ok result62 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state62_0 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-FOLD-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" result.1)) = _
 rewrite [parents62_0]
 rfl
#print axioms rootCall62
end SFT.Physics.GrandLockRootTrace
