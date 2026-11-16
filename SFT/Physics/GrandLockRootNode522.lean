import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents522_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state522_4 [] = .ok state522_4 := rfl
theorem parents522_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state522_3 ["SFT-INFO-QUANTITY-001"] = .ok state522_4 := rfl
theorem parents522_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state522_2 ["SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = .ok state522_4 := rfl
theorem parents522_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state522_1 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = .ok state522_4 := rfl
theorem parents522_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state522_0 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = .ok state522_4 := by
 change (reachesOne sourceDictionary534 533 memoNode8307 "SFT-FOUNDATION-PART-EQUIVALENCE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"]) = _
 rewrite [rootCall521]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state522_1 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"] = _
 exact parents522_1
theorem rootCall522 : reachesOne sourceDictionary534 534 memoNode8307 "SFT-INFO-ENTROPY-UNCERTAINTY-001" = .ok result522 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state522_0 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001"]; pure (result.1,put result.2 "SFT-INFO-ENTROPY-UNCERTAINTY-001" result.1)) = _
 rewrite [parents522_0]
 rfl
#print axioms rootCall522
end SFT.Physics.GrandLockRootTrace
