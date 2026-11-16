import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents681_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state681_5 [] = .ok state681_5 := rfl
theorem parents681_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state681_4 ["SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state681_5 := rfl
theorem parents681_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state681_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state681_5 := rfl
theorem parents681_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state681_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state681_5 := rfl
theorem parents681_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state681_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state681_5 := rfl
theorem parents681_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state681_0 ["SFT-PHYS-SPACETIME-VELOCITY-COMPOSITION-TERMINAL-033","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = .ok state681_5 := by
 change (reachesOne sourceDictionary534 534 memoNode11144 "SFT-PHYS-SPACETIME-VELOCITY-COMPOSITION-TERMINAL-033" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]) = _
 rewrite [rootCall680]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state681_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"] = _
 exact parents681_1
theorem rootCall681 : reachesOne sourceDictionary534 535 memoNode11144 "SFT-PHYS-VALIDATION-VELOCITY-COMPOSITION-034" = .ok result681 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state681_0 ["SFT-PHYS-SPACETIME-VELOCITY-COMPOSITION-TERMINAL-033","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-VELOCITY-COMPOSITION-034" result.1)) = _
 rewrite [parents681_0]
 rfl
#print axioms rootCall681
end SFT.Physics.GrandLockRootTrace
