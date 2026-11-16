import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode395
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents396_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state396_4 [] = .ok state396_4 := rfl
theorem parents396_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state396_3 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state396_4 := rfl
theorem parents396_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state396_2 ["SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state396_4 := rfl
theorem parents396_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state396_1 ["SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state396_4 := rfl
theorem parents396_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state396_0 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state396_4 := by
 change (reachesOne sourceDictionary534 533 memoNode6218 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [rootCall395]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state396_1 ["SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact parents396_1
theorem rootCall396 : reachesOne sourceDictionary534 534 memoNode6218 "SFT-PHYS-VACUUM-ODD-RECURRENCE-003" = .ok result396 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state396_0 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-FOUNDATION-FOLD-001","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (result.1,put result.2 "SFT-PHYS-VACUUM-ODD-RECURRENCE-003" result.1)) = _
 rewrite [parents396_0]
 rfl
#print axioms rootCall396
end SFT.Physics.GrandLockRootTrace
