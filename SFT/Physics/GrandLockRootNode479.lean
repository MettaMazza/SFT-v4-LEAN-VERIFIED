import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode478
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents479_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state479_3 [] = .ok state479_3 := rfl
theorem parents479_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state479_2 ["SFT-COMP-CBL-HALTING-001"] = .ok state479_3 := rfl
theorem parents479_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state479_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-COMP-CBL-HALTING-001"] = .ok state479_3 := rfl
theorem parents479_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state479_0 ["SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-COMP-CBL-HALTING-001"] = .ok state479_3 := by
 change (reachesOne sourceDictionary534 534 memoNode7435 "SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-COMP-CBL-HALTING-001"]) = _
 rewrite [rootCall478]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state479_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-COMP-CBL-HALTING-001"] = _
 exact parents479_1
theorem rootCall479 : reachesOne sourceDictionary534 535 memoNode7435 "SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003" = .ok result479 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state479_0 ["SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-COMP-CBL-HALTING-001"]; pure (result.1,put result.2 "SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003" result.1)) = _
 rewrite [parents479_0]
 rfl
#print axioms rootCall479
end SFT.Physics.GrandLockRootTrace
