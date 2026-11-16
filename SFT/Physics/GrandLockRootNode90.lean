import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode89
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents90_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state90_3 [] = .ok state90_3 := rfl
theorem parents90_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state90_2 ["SFT-FOUNDATION-PART-EQUIVALENCE-001"] = .ok state90_3 := rfl
theorem parents90_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state90_1 ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"] = .ok state90_3 := rfl
theorem parents90_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state90_0 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"] = .ok state90_3 := by
 change (reachesOne sourceDictionary534 533 memoNode1572 "SFT-FOUNDATION-FOLD-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"]) = _
 rewrite [rootCall89]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state90_1 ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"] = _
 exact parents90_1
theorem rootCall90 : reachesOne sourceDictionary534 534 memoNode1572 "SFT-FOUNDATION-HALF-ONE-001" = .ok result90 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state90_0 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-HALF-ONE-001" result.1)) = _
 rewrite [parents90_0]
 rfl
#print axioms rootCall90
end SFT.Physics.GrandLockRootTrace
