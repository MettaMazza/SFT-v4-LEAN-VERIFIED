import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode215
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents216_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state216_3 [] = .ok state216_3 := rfl
theorem parents216_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state216_2 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state216_3 := rfl
theorem parents216_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state216_1 ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state216_3 := rfl
theorem parents216_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state216_0 ["SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state216_3 := by
 change (reachesOne sourceDictionary534 533 memoNode3847 "SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"]) = _
 rewrite [rootCall215]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state216_1 ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = _
 exact parents216_1
theorem rootCall216 : reachesOne sourceDictionary534 534 memoNode3847 "SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003" = .ok result216 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state216_0 ["SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003" result.1)) = _
 rewrite [parents216_0]
 rfl
#print axioms rootCall216
end SFT.Physics.GrandLockRootTrace
