import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents44_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state44_3 [] = .ok state44_3 := rfl
theorem parents44_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state44_2 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001"] = .ok state44_3 := rfl
theorem parents44_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state44_1 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001"] = .ok state44_3 := rfl
theorem parents44_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state44_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001"] = .ok state44_3 := by
 change (reachesOne sourceDictionary534 532 memoNode906 "SFT-FOUNDATION-ONE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001"]) = _
 rewrite [rootCall43]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state44_1 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001"] = _
 exact parents44_1
theorem rootCall44 : reachesOne sourceDictionary534 533 memoNode906 "SFT-FOUNDATION-FORM-GRAMMAR-001" = .ok result44 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state44_0 ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-FORM-GRAMMAR-001" result.1)) = _
 rewrite [parents44_0]
 rfl
#print axioms rootCall44
end SFT.Physics.GrandLockRootTrace
