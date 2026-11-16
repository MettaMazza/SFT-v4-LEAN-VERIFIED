import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode135
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents136_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state136_3 [] = .ok state136_3 := rfl
theorem parents136_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state136_2 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state136_3 := rfl
theorem parents136_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state136_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state136_3 := rfl
theorem parents136_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state136_0 ["SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state136_3 := by
 change (reachesOne sourceDictionary534 533 memoNode2560 "SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"]) = _
 rewrite [rootCall135]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state136_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = _
 exact parents136_1
theorem rootCall136 : reachesOne sourceDictionary534 534 memoNode2560 "SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003" = .ok result136 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state136_0 ["SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"]; pure (result.1,put result.2 "SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003" result.1)) = _
 rewrite [parents136_0]
 rfl
#print axioms rootCall136
end SFT.Physics.GrandLockRootTrace
