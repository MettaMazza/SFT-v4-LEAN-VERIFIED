import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode710
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents711_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state711_5 [] = .ok state711_5 := rfl
theorem parents711_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state711_4 ["SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state711_5 := rfl
theorem parents711_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state711_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state711_5 := rfl
theorem parents711_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state711_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state711_5 := rfl
theorem parents711_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state711_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state711_5 := rfl
theorem parents711_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state711_0 ["SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state711_5 := by
 change (reachesOne sourceDictionary534 534 memoNode11468 "SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]) = _
 rewrite [rootCall710]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state711_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = _
 exact parents711_1
theorem rootCall711 : reachesOne sourceDictionary534 535 memoNode11468 "SFT-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027" = .ok result711 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state711_0 ["SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]; pure (result.1,put result.2 "SFT-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027" result.1)) = _
 rewrite [parents711_0]
 rfl
#print axioms rootCall711
end SFT.Physics.GrandLockRootTrace
