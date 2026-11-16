import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents661_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state661_5 [] = .ok state661_5 := rfl
theorem parents661_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state661_4 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state661_5 := rfl
theorem parents661_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state661_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state661_5 := rfl
theorem parents661_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state661_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state661_5 := rfl
theorem parents661_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state661_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state661_5 := rfl
theorem parents661_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state661_0 ["SFT-PHYS-STRONG-CP-BARYON-STABILITY-TERMINAL-063","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state661_5 := by
 change (reachesOne sourceDictionary534 534 memoNode10756 "SFT-PHYS-STRONG-CP-BARYON-STABILITY-TERMINAL-063" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall660]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state661_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents661_1
theorem rootCall661 : reachesOne sourceDictionary534 535 memoNode10756 "SFT-PHYS-VALIDATION-STRONG-CP-BARYON-STABILITY-064" = .ok result661 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state661_0 ["SFT-PHYS-STRONG-CP-BARYON-STABILITY-TERMINAL-063","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-STRONG-CP-BARYON-STABILITY-064" result.1)) = _
 rewrite [parents661_0]
 rfl
#print axioms rootCall661
end SFT.Physics.GrandLockRootTrace
