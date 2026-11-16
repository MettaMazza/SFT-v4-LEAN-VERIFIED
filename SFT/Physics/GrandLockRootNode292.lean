import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode291
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents292_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state292_1 [] = .ok state292_1 := rfl
theorem parents292_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state292_0 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001"] = .ok state292_1 := by
 change (reachesOne sourceDictionary534 533 memoNode4857 "SFT-FOUNDATION-FORM-ENFORCEMENT-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next []) = _
 rewrite [rootCall291]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state292_1 [] = _
 exact parents292_1
theorem rootCall292 : reachesOne sourceDictionary534 534 memoNode4857 "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001" = .ok result292 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state292_0 ["SFT-FOUNDATION-FORM-ENFORCEMENT-001"]; pure (result.1,put result.2 "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001" result.1)) = _
 rewrite [parents292_0]
 rfl
#print axioms rootCall292
end SFT.Physics.GrandLockRootTrace
