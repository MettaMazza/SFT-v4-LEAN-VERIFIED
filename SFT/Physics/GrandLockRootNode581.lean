import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents581_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_6 [] = .ok state581_6 := rfl
theorem parents581_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_5 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state581_6 := rfl
theorem parents581_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_4 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state581_6 := rfl
theorem parents581_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_3 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state581_6 := rfl
theorem parents581_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_2 ["SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state581_6 := rfl
theorem parents581_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_1 ["SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053","SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state581_6 := rfl
theorem parents581_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_0 ["SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030","SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053","SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state581_6 := by
 change (reachesOne sourceDictionary534 534 memoNode9163 "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053","SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall580]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_1 ["SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053","SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents581_1
theorem rootCall581 : reachesOne sourceDictionary534 535 memoNode9163 "SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054" = .ok result581 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state581_0 ["SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030","SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053","SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054" result.1)) = _
 rewrite [parents581_0]
 rfl
#print axioms rootCall581
end SFT.Physics.GrandLockRootTrace
