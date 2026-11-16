import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode244
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents245_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state245_3 [] = .ok state245_3 := rfl
theorem parents245_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state245_2 ["SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok state245_3 := rfl
theorem parents245_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state245_1 ["SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok state245_3 := rfl
theorem parents245_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state245_0 ["SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok state245_3 := by
 change (reachesOne sourceDictionary534 534 memoNode4186 "SFT-PHYS-MATTER-CKM-PHYSICAL-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"]) = _
 rewrite [rootCall244]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state245_1 ["SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = _
 exact parents245_1
theorem rootCall245 : reachesOne sourceDictionary534 535 memoNode4186 "SFT-PHYS-MATTER-BARYON-PHOTON-003" = .ok result245 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state245_0 ["SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-BARYON-PHOTON-003" result.1)) = _
 rewrite [parents245_0]
 rfl
#print axioms rootCall245
end SFT.Physics.GrandLockRootTrace
