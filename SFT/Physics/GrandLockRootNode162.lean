import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents162_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_6 [] = .ok state162_6 := rfl
theorem parents162_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_5 ["SFT-MATH-GEOMETRY-TOPOLOGY-001"] = .ok state162_6 := rfl
theorem parents162_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_4 ["SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001"] = .ok state162_6 := rfl
theorem parents162_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_3 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001"] = .ok state162_6 := rfl
theorem parents162_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_2 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001"] = .ok state162_6 := rfl
theorem parents162_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001"] = .ok state162_6 := rfl
theorem parents162_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_0 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001"] = .ok state162_6 := by
 change (reachesOne sourceDictionary534 533 memoNode3084 "SFT-PHYS-SPACE-DIMENSION-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001"]) = _
 rewrite [rootCall161]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_1 ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001"] = _
 exact parents162_1
theorem rootCall162 : reachesOne sourceDictionary534 534 memoNode3084 "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001" = .ok result162 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state162_0 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001"]; pure (result.1,put result.2 "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001" result.1)) = _
 rewrite [parents162_0]
 rfl
#print axioms rootCall162
end SFT.Physics.GrandLockRootTrace
