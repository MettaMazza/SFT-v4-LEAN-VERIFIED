import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents291_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state291_1 [] = .ok state291_1 := rfl
theorem parents291_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state291_0 ["SFT-FOUNDATION-FORM-GRAMMAR-001"] = .ok state291_1 := by
 change (reachesOne sourceDictionary534 532 memoNode4857 "SFT-FOUNDATION-FORM-GRAMMAR-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next []) = _
 rewrite [rootCall290]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state291_1 [] = _
 exact parents291_1
theorem rootCall291 : reachesOne sourceDictionary534 533 memoNode4857 "SFT-FOUNDATION-FORM-ENFORCEMENT-001" = .ok result291 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state291_0 ["SFT-FOUNDATION-FORM-GRAMMAR-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-FORM-ENFORCEMENT-001" result.1)) = _
 rewrite [parents291_0]
 rfl
#print axioms rootCall291
end SFT.Physics.GrandLockRootTrace
