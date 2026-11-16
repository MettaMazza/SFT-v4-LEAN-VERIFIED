import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents270_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state270_3 [] = .ok state270_3 := rfl
theorem parents270_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state270_2 ["SFT-MATH-DISCRETE-001"] = .ok state270_3 := rfl
theorem parents270_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state270_1 ["SFT-FOUNDATION-COUNT-001","SFT-MATH-DISCRETE-001"] = .ok state270_3 := rfl
theorem parents270_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state270_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-MATH-DISCRETE-001"] = .ok state270_3 := by
 change (reachesOne sourceDictionary534 534 memoNode4641 "SFT-PHYS-STRUCT-GENERATOR-THREE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-COUNT-001","SFT-MATH-DISCRETE-001"]) = _
 rewrite [rootCall269]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state270_1 ["SFT-FOUNDATION-COUNT-001","SFT-MATH-DISCRETE-001"] = _
 exact parents270_1
theorem rootCall270 : reachesOne sourceDictionary534 535 memoNode4641 "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003" = .ok result270 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state270_0 ["SFT-PHYS-STRUCT-GENERATOR-THREE-001","SFT-FOUNDATION-COUNT-001","SFT-MATH-DISCRETE-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003" result.1)) = _
 rewrite [parents270_0]
 rfl
#print axioms rootCall270
end SFT.Physics.GrandLockRootTrace
