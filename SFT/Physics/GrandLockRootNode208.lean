import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode207
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents208_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state208_3 [] = .ok state208_3 := rfl
theorem parents208_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state208_2 ["SFT-PHYS-MECH-ACCELERATION-001"] = .ok state208_3 := rfl
theorem parents208_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state208_1 ["SFT-PHYS-GRAVITY-EQUIVALENCE-001","SFT-PHYS-MECH-ACCELERATION-001"] = .ok state208_3 := rfl
theorem parents208_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state208_0 ["SFT-PHYS-GRAVITY-STATIC-CLOCK-003","SFT-PHYS-GRAVITY-EQUIVALENCE-001","SFT-PHYS-MECH-ACCELERATION-001"] = .ok state208_3 := by
 change (reachesOne sourceDictionary534 531 memoNode3595 "SFT-PHYS-GRAVITY-STATIC-CLOCK-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) next ["SFT-PHYS-GRAVITY-EQUIVALENCE-001","SFT-PHYS-MECH-ACCELERATION-001"]) = _
 rewrite [rootCall207]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state208_1 ["SFT-PHYS-GRAVITY-EQUIVALENCE-001","SFT-PHYS-MECH-ACCELERATION-001"] = _
 exact parents208_1
theorem rootCall208 : reachesOne sourceDictionary534 532 memoNode3595 "SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003" = .ok result208 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 531 cache dep) state208_0 ["SFT-PHYS-GRAVITY-STATIC-CLOCK-003","SFT-PHYS-GRAVITY-EQUIVALENCE-001","SFT-PHYS-MECH-ACCELERATION-001"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003" result.1)) = _
 rewrite [parents208_0]
 rfl
#print axioms rootCall208
end SFT.Physics.GrandLockRootTrace
