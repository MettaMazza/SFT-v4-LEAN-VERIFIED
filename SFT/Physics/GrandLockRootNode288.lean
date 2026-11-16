import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents288_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state288_3 [] = .ok state288_3 := rfl
theorem parents288_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state288_2 ["SFT-FOUNDATION-PART-001"] = .ok state288_3 := rfl
theorem parents288_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state288_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok state288_3 := rfl
theorem parents288_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state288_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = .ok state288_3 := by
 change (reachesOne sourceDictionary534 533 memoNode4814 "SFT-FOUNDATION-ONE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]) = _
 rewrite [rootCall287]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state288_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"] = _
 exact parents288_1
theorem rootCall288 : reachesOne sourceDictionary534 534 memoNode4814 "SFT-FOUNDATION-PART-EQUIVALENCE-001" = .ok result288 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state288_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-PART-EQUIVALENCE-001" result.1)) = _
 rewrite [parents288_0]
 rfl
#print axioms rootCall288
end SFT.Physics.GrandLockRootTrace
