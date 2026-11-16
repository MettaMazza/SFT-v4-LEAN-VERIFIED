import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode208
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents209_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state209_3 [] = .ok state209_3 := rfl
theorem parents209_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state209_2 ["SFT-PHYS-SPACE-DIMENSION-THREE-001"] = .ok state209_3 := rfl
theorem parents209_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state209_1 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001"] = .ok state209_3 := rfl
theorem parents209_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state209_0 ["SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001"] = .ok state209_3 := by
 change (reachesOne sourceDictionary534 532 memoNode3595 "SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001"]) = _
 rewrite [rootCall208]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state209_1 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001"] = _
 exact parents209_1
theorem rootCall209 : reachesOne sourceDictionary534 533 memoNode3595 "SFT-PHYS-GRAVITY-LATTICE-CURVATURE-003" = .ok result209 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state209_0 ["SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-SPACE-DIMENSION-THREE-001"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-LATTICE-CURVATURE-003" result.1)) = _
 rewrite [parents209_0]
 rfl
#print axioms rootCall209
end SFT.Physics.GrandLockRootTrace
