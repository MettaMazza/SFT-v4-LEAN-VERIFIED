import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode210
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents211_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state211_3 [] = .ok state211_3 := rfl
theorem parents211_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state211_2 ["SFT-PHYS-GRAVITY-WAVE-001"] = .ok state211_3 := rfl
theorem parents211_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state211_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-GRAVITY-WAVE-001"] = .ok state211_3 := rfl
theorem parents211_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state211_0 ["SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-GRAVITY-WAVE-001"] = .ok state211_3 := by
 change (reachesOne sourceDictionary534 534 memoNode3595 "SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-GRAVITY-WAVE-001"]) = _
 rewrite [rootCall210]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state211_1 ["SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-GRAVITY-WAVE-001"] = _
 exact parents211_1
theorem rootCall211 : reachesOne sourceDictionary534 535 memoNode3595 "SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003" = .ok result211 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state211_0 ["SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003","SFT-PHYS-SPACE-DIMENSION-THREE-001","SFT-PHYS-GRAVITY-WAVE-001"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003" result.1)) = _
 rewrite [parents211_0]
 rfl
#print axioms rootCall211
end SFT.Physics.GrandLockRootTrace
