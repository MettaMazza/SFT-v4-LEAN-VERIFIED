import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents671_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state671_5 [] = .ok state671_5 := rfl
theorem parents671_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state671_4 ["SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state671_5 := rfl
theorem parents671_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state671_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state671_5 := rfl
theorem parents671_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state671_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state671_5 := rfl
theorem parents671_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state671_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state671_5 := rfl
theorem parents671_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state671_0 ["SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state671_5 := by
 change (reachesOne sourceDictionary534 534 memoNode10984 "SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]) = _
 rewrite [rootCall670]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state671_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = _
 exact parents671_1
theorem rootCall671 : reachesOne sourceDictionary534 535 memoNode10984 "SFT-PHYS-VALIDATION-VACUUM-DENSITY-SCALE-036" = .ok result671 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state671_0 ["SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-VACUUM-DENSITY-SCALE-036" result.1)) = _
 rewrite [parents671_0]
 rfl
#print axioms rootCall671
end SFT.Physics.GrandLockRootTrace
