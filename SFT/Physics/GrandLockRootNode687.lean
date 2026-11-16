import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents687_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state687_3 [] = .ok state687_3 := rfl
theorem parents687_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state687_2 ["SFT-MATH-OPTIMIZATION-001"] = .ok state687_3 := rfl
theorem parents687_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state687_1 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-OPTIMIZATION-001"] = .ok state687_3 := rfl
theorem parents687_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state687_0 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-OPTIMIZATION-001"] = .ok state687_3 := by
 change (reachesOne sourceDictionary534 533 memoNode11241 "SFT-FOUNDATION-FORM-ENFORCEMENT-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-OPTIMIZATION-001"]) = _
 rewrite [rootCall686]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state687_1 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-OPTIMIZATION-001"] = _
 exact parents687_1
theorem rootCall687 : reachesOne sourceDictionary534 534 memoNode11241 "SFT-MATH-DYNAMICAL-SYSTEMS-001" = .ok result687 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state687_0 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-OPTIMIZATION-001"]; pure (result.1,put result.2 "SFT-MATH-DYNAMICAL-SYSTEMS-001" result.1)) = _
 rewrite [parents687_0]
 rfl
#print axioms rootCall687
end SFT.Physics.GrandLockRootTrace
