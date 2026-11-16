import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode93
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents94_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state94_2 [] = .ok state94_2 := rfl
theorem parents94_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state94_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state94_2 := rfl
theorem parents94_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state94_0 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state94_2 := by
 change (reachesOne sourceDictionary534 531 memoNode1669 "SFT-MATH-EXACT-ARITHMETIC-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [rootCall93]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state94_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact parents94_1
theorem rootCall94 : reachesOne sourceDictionary534 532 memoNode1669 "SFT-MATH-EXACT-RELATIONS-002" = .ok result94 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state94_0 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (result.1,put result.2 "SFT-MATH-EXACT-RELATIONS-002" result.1)) = _
 rewrite [parents94_0]
 rfl
#print axioms rootCall94
end SFT.Physics.GrandLockRootTrace
