import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode94
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents95_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state95_2 [] = .ok state95_2 := rfl
theorem parents95_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state95_1 ["SFT-MATH-LIMIT-CONTINUUM-002"] = .ok state95_2 := rfl
theorem parents95_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state95_0 ["SFT-MATH-EXACT-RELATIONS-002","SFT-MATH-LIMIT-CONTINUUM-002"] = .ok state95_2 := by
 change (reachesOne sourceDictionary534 532 memoNode1669 "SFT-MATH-EXACT-RELATIONS-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-MATH-LIMIT-CONTINUUM-002"]) = _
 rewrite [rootCall94]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state95_1 ["SFT-MATH-LIMIT-CONTINUUM-002"] = _
 exact parents95_1
theorem rootCall95 : reachesOne sourceDictionary534 533 memoNode1669 "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002" = .ok result95 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state95_0 ["SFT-MATH-EXACT-RELATIONS-002","SFT-MATH-LIMIT-CONTINUUM-002"]; pure (result.1,put result.2 "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002" result.1)) = _
 rewrite [parents95_0]
 rfl
#print axioms rootCall95
end SFT.Physics.GrandLockRootTrace
