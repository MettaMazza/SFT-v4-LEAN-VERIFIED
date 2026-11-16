import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents603_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state603_5 [] = .ok state603_5 := rfl
theorem parents603_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state603_4 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state603_5 := rfl
theorem parents603_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state603_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state603_5 := rfl
theorem parents603_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state603_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state603_5 := rfl
theorem parents603_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state603_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state603_5 := rfl
theorem parents603_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state603_0 ["SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state603_5 := by
 change (reachesOne sourceDictionary534 534 memoNode9661 "SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall602]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state603_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents603_1
theorem rootCall603 : reachesOne sourceDictionary534 535 memoNode9661 "SFT-PHYS-VALIDATION-FINITE-LOOPS-003" = .ok result603 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state603_0 ["SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-FINITE-LOOPS-003" result.1)) = _
 rewrite [parents603_0]
 rfl
#print axioms rootCall603
end SFT.Physics.GrandLockRootTrace
