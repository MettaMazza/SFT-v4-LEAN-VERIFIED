import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents637_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_7 [] = .ok state637_7 := rfl
theorem parents637_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_6 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state637_7 := rfl
theorem parents637_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_5 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state637_7 := rfl
theorem parents637_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_4 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state637_7 := rfl
theorem parents637_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_3 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state637_7 := rfl
theorem parents637_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_2 ["SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state637_7 := rfl
theorem parents637_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_1 ["SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003","SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state637_7 := rfl
theorem parents637_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_0 ["SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003","SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003","SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state637_7 := by
 change (reachesOne sourceDictionary534 534 memoNode10292 "SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003","SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall636]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_1 ["SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003","SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents637_1
theorem rootCall637 : reachesOne sourceDictionary534 535 memoNode10292 "SFT-PHYS-VALIDATION-NONSTANDARD-SPACETIME-003" = .ok result637 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state637_0 ["SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003","SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003","SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-NONSTANDARD-SPACETIME-003" result.1)) = _
 rewrite [parents637_0]
 rfl
#print axioms rootCall637
end SFT.Physics.GrandLockRootTrace
