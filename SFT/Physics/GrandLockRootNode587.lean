import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents587_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state587_5 [] = .ok state587_5 := rfl
theorem parents587_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state587_4 ["SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state587_5 := rfl
theorem parents587_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state587_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state587_5 := rfl
theorem parents587_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state587_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state587_5 := rfl
theorem parents587_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state587_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state587_5 := rfl
theorem parents587_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state587_0 ["SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state587_5 := by
 change (reachesOne sourceDictionary534 534 memoNode9320 "SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-PROBABILITY-STATISTICS-001"]) = _
 rewrite [rootCall586]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state587_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = _
 exact parents587_1
theorem rootCall587 : reachesOne sourceDictionary534 535 memoNode9320 "SFT-PHYS-VALIDATION-CRITICALITY-MEASURED-VALUE-056" = .ok result587 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state587_0 ["SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-PROBABILITY-STATISTICS-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-CRITICALITY-MEASURED-VALUE-056" result.1)) = _
 rewrite [parents587_0]
 rfl
#print axioms rootCall587
end SFT.Physics.GrandLockRootTrace
