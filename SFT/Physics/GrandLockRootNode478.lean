import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode477
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents478_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state478_3 [] = .ok state478_3 := rfl
theorem parents478_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state478_2 ["SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"] = .ok state478_3 := rfl
theorem parents478_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state478_1 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"] = .ok state478_3 := rfl
theorem parents478_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state478_0 ["SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"] = .ok state478_3 := by
 change (reachesOne sourceDictionary534 533 memoNode7435 "SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"]) = _
 rewrite [rootCall477]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state478_1 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"] = _
 exact parents478_1
theorem rootCall478 : reachesOne sourceDictionary534 534 memoNode7435 "SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003" = .ok result478 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state478_0 ["SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"]; pure (result.1,put result.2 "SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003" result.1)) = _
 rewrite [parents478_0]
 rfl
#print axioms rootCall478
end SFT.Physics.GrandLockRootTrace
