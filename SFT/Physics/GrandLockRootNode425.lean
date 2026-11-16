import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents425_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state425_5 [] = .ok state425_5 := rfl
theorem parents425_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state425_4 ["SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok state425_5 := rfl
theorem parents425_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state425_3 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok state425_5 := rfl
theorem parents425_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state425_2 ["SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok state425_5 := rfl
theorem parents425_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state425_1 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok state425_5 := rfl
theorem parents425_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state425_0 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = .ok state425_5 := by
 change (reachesOne sourceDictionary534 533 memoNode6740 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"]) = _
 rewrite [rootCall424]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state425_1 ["SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"] = _
 exact parents425_1
theorem rootCall425 : reachesOne sourceDictionary534 534 memoNode6740 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" = .ok result425 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state425_0 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"]; pure (result.1,put result.2 "SFT-INFO-QUANTUM-CORRESPONDENCE-001" result.1)) = _
 rewrite [parents425_0]
 rfl
#print axioms rootCall425
end SFT.Physics.GrandLockRootTrace
