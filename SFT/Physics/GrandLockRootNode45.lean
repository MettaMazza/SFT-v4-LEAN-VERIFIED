import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode44
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents45_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state45_4 [] = .ok state45_4 := rfl
theorem parents45_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state45_3 ["SFT-MATH-COMBINATORICS-001"] = .ok state45_4 := rfl
theorem parents45_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state45_2 ["SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001"] = .ok state45_4 := rfl
theorem parents45_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state45_1 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001"] = .ok state45_4 := rfl
theorem parents45_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state45_0 ["SFT-FOUNDATION-FORM-GRAMMAR-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001"] = .ok state45_4 := by
 change (reachesOne sourceDictionary534 533 memoNode906 "SFT-FOUNDATION-FORM-GRAMMAR-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall44]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state45_1 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001"] = _
 exact parents45_1
theorem rootCall45 : reachesOne sourceDictionary534 534 memoNode906 "SFT-MATH-GRAPH-NETWORK-001" = .ok result45 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state45_0 ["SFT-FOUNDATION-FORM-GRAMMAR-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-MATH-GRAPH-NETWORK-001" result.1)) = _
 rewrite [parents45_0]
 rfl
#print axioms rootCall45
end SFT.Physics.GrandLockRootTrace
