import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode129
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents130_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state130_3 [] = .ok state130_3 := rfl
theorem parents130_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state130_2 ["SFT-MATH-ORDER-LATTICE-001"] = .ok state130_3 := rfl
theorem parents130_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state130_1 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state130_3 := rfl
theorem parents130_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state130_0 ["SFT-FOUNDATION-PART-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001"] = .ok state130_3 := by
 change (reachesOne sourceDictionary534 533 memoNode2464 "SFT-FOUNDATION-PART-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001"]) = _
 rewrite [rootCall129]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state130_1 ["SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001"] = _
 exact parents130_1
theorem rootCall130 : reachesOne sourceDictionary534 534 memoNode2464 "SFT-MATH-GEOMETRY-TOPOLOGY-001" = .ok result130 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state130_0 ["SFT-FOUNDATION-PART-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001"]; pure (result.1,put result.2 "SFT-MATH-GEOMETRY-TOPOLOGY-001" result.1)) = _
 rewrite [parents130_0]
 rfl
#print axioms rootCall130
end SFT.Physics.GrandLockRootTrace
