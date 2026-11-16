import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents539_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state539_5 [] = .ok state539_5 := rfl
theorem parents539_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state539_4 ["SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state539_5 := rfl
theorem parents539_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state539_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state539_5 := rfl
theorem parents539_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state539_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state539_5 := rfl
theorem parents539_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state539_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state539_5 := rfl
theorem parents539_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state539_0 ["SFT-PHYS-THERMO-LANDAUER-DEMON-TERMINAL-018","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state539_5 := by
 change (reachesOne sourceDictionary534 534 memoNode8537 "SFT-PHYS-THERMO-LANDAUER-DEMON-TERMINAL-018" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]) = _
 rewrite [rootCall538]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state539_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = _
 exact parents539_1
theorem rootCall539 : reachesOne sourceDictionary534 535 memoNode8537 "SFT-PHYS-THERMO-LANDAUER-EMPIRICAL-019" = .ok result539 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state539_0 ["SFT-PHYS-THERMO-LANDAUER-DEMON-TERMINAL-018","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]; pure (result.1,put result.2 "SFT-PHYS-THERMO-LANDAUER-EMPIRICAL-019" result.1)) = _
 rewrite [parents539_0]
 rfl
#print axioms rootCall539
end SFT.Physics.GrandLockRootTrace
