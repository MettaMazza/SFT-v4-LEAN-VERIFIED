import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents589_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state589_5 [] = .ok state589_5 := rfl
theorem parents589_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state589_4 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state589_5 := rfl
theorem parents589_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state589_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state589_5 := rfl
theorem parents589_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state589_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state589_5 := rfl
theorem parents589_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state589_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state589_5 := rfl
theorem parents589_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state589_0 ["SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state589_5 := by
 change (reachesOne sourceDictionary534 534 memoNode9369 "SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall588]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state589_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents589_1
theorem rootCall589 : reachesOne sourceDictionary534 535 memoNode9369 "SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048" = .ok result589 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state589_0 ["SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048" result.1)) = _
 rewrite [parents589_0]
 rfl
#print axioms rootCall589
end SFT.Physics.GrandLockRootTrace
