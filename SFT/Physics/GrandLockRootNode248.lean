import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode247
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents248_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state248_3 [] = .ok state248_3 := rfl
theorem parents248_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state248_2 ["SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok state248_3 := rfl
theorem parents248_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state248_1 ["SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok state248_3 := rfl
theorem parents248_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state248_0 ["SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok state248_3 := by
 change (reachesOne sourceDictionary534 534 memoNode4327 "SFT-PHYS-MATTER-CKM-TERMINAL-004" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"]) = _
 rewrite [rootCall247]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state248_1 ["SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = _
 exact parents248_1
theorem rootCall248 : reachesOne sourceDictionary534 535 memoNode4327 "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004" = .ok result248 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state248_0 ["SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004" result.1)) = _
 rewrite [parents248_0]
 rfl
#print axioms rootCall248
end SFT.Physics.GrandLockRootTrace
