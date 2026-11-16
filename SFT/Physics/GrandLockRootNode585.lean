import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents585_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_6 [] = .ok state585_6 := rfl
theorem parents585_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_5 ["SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state585_6 := rfl
theorem parents585_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_4 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state585_6 := rfl
theorem parents585_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state585_6 := rfl
theorem parents585_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state585_6 := rfl
theorem parents585_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state585_6 := rfl
theorem parents585_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_0 ["SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = .ok state585_6 := by
 change (reachesOne sourceDictionary534 534 memoNode9266 "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-PROBABILITY-STATISTICS-001"]) = _
 rewrite [rootCall584]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-PROBABILITY-STATISTICS-001"] = _
 exact parents585_1
theorem rootCall585 : reachesOne sourceDictionary534 535 memoNode9266 "SFT-PHYS-VALIDATION-COSMIC-TRANSPORT-MEASURED-VALUE-055" = .ok result585 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state585_0 ["SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-PROBABILITY-STATISTICS-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-COSMIC-TRANSPORT-MEASURED-VALUE-055" result.1)) = _
 rewrite [parents585_0]
 rfl
#print axioms rootCall585
end SFT.Physics.GrandLockRootTrace
