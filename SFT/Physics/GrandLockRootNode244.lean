import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode243
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents244_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state244_3 [] = .ok state244_3 := rfl
theorem parents244_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state244_2 ["SFT-PHYS-NEUTRINO-CP-PHASE-002"] = .ok state244_3 := rfl
theorem parents244_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state244_1 ["SFT-PHYS-MATTER-CKM-FIBRE-003","SFT-PHYS-NEUTRINO-CP-PHASE-002"] = .ok state244_3 := rfl
theorem parents244_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state244_0 ["SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-MATTER-CKM-FIBRE-003","SFT-PHYS-NEUTRINO-CP-PHASE-002"] = .ok state244_3 := by
 change (reachesOne sourceDictionary534 533 memoNode4186 "SFT-PHYS-MATTER-QUARK-DRESSING-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-MATTER-CKM-FIBRE-003","SFT-PHYS-NEUTRINO-CP-PHASE-002"]) = _
 rewrite [rootCall243]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state244_1 ["SFT-PHYS-MATTER-CKM-FIBRE-003","SFT-PHYS-NEUTRINO-CP-PHASE-002"] = _
 exact parents244_1
theorem rootCall244 : reachesOne sourceDictionary534 534 memoNode4186 "SFT-PHYS-MATTER-CKM-PHYSICAL-003" = .ok result244 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state244_0 ["SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-MATTER-CKM-FIBRE-003","SFT-PHYS-NEUTRINO-CP-PHASE-002"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-CKM-PHYSICAL-003" result.1)) = _
 rewrite [parents244_0]
 rfl
#print axioms rootCall244
end SFT.Physics.GrandLockRootTrace
