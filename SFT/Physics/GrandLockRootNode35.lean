import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode34
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents35_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state35_2 [] = .ok state35_2 := rfl
theorem parents35_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state35_1 ["SFT-FOUNDATION-HALF-ONE-001"] = .ok state35_2 := rfl
theorem parents35_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state35_0 ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-HALF-ONE-001"] = .ok state35_2 := by
 change (reachesOne sourceDictionary534 533 memoNode656 "SFT-FOUNDATION-EXACT-OPERATIONS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-HALF-ONE-001"]) = _
 rewrite [rootCall34]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state35_1 ["SFT-FOUNDATION-HALF-ONE-001"] = _
 exact parents35_1
theorem rootCall35 : reachesOne sourceDictionary534 534 memoNode656 "SFT-FOUNDATION-FOLD-DYNAMICS-001" = .ok result35 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state35_0 ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-HALF-ONE-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-FOLD-DYNAMICS-001" result.1)) = _
 rewrite [parents35_0]
 rfl
#print axioms rootCall35
end SFT.Physics.GrandLockRootTrace
