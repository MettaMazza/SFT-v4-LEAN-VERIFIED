import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents135_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state135_3 [] = .ok state135_3 := rfl
theorem parents135_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state135_2 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state135_3 := rfl
theorem parents135_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state135_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state135_3 := rfl
theorem parents135_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state135_0 ["SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state135_3 := by
 change (reachesOne sourceDictionary534 532 memoNode2560 "SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall134]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state135_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents135_1
theorem rootCall135 : reachesOne sourceDictionary534 533 memoNode2560 "SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003" = .ok result135 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state135_0 ["SFT-PHYS-DYNAMICS-STATIONARY-SPECTRUM-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003" result.1)) = _
 rewrite [parents135_0]
 rfl
#print axioms rootCall135
end SFT.Physics.GrandLockRootTrace
