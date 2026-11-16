import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode206
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents207_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state207_3 [] = .ok state207_3 := rfl
theorem parents207_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state207_2 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state207_3 := rfl
theorem parents207_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state207_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state207_3 := rfl
theorem parents207_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state207_0 ["SFT-PHYS-SPACETIME-EXACT-INTERVAL-003","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = .ok state207_3 := by
 change (reachesOne sourceDictionary534 530 memoNode3595 "SFT-PHYS-SPACETIME-EXACT-INTERVAL-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) next ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"]) = _
 rewrite [rootCall206]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state207_1 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"] = _
 exact parents207_1
theorem rootCall207 : reachesOne sourceDictionary534 531 memoNode3595 "SFT-PHYS-GRAVITY-STATIC-CLOCK-003" = .ok result207 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 530 cache dep) state207_0 ["SFT-PHYS-SPACETIME-EXACT-INTERVAL-003","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-STATIC-CLOCK-003" result.1)) = _
 rewrite [parents207_0]
 rfl
#print axioms rootCall207
end SFT.Physics.GrandLockRootTrace
