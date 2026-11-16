import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode90
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents91_8 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_8 [] = .ok state91_8 := rfl
theorem parents91_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_7 ["SFT-MATH-COMBINATORICS-001"] = .ok state91_8 := rfl
theorem parents91_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_6 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"] = .ok state91_8 := rfl
theorem parents91_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_5 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"] = .ok state91_8 := rfl
theorem parents91_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_4 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"] = .ok state91_8 := rfl
theorem parents91_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_3 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"] = .ok state91_8 := rfl
theorem parents91_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_2 ["SFT-FOUNDATION-PART-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"] = .ok state91_8 := rfl
theorem parents91_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_1 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"] = .ok state91_8 := rfl
theorem parents91_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_0 ["SFT-FOUNDATION-HALF-ONE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"] = .ok state91_8 := by
 change (reachesOne sourceDictionary534 534 memoNode1572 "SFT-FOUNDATION-HALF-ONE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"]) = _
 rewrite [rootCall90]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_1 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"] = _
 exact parents91_1
theorem rootCall91 : reachesOne sourceDictionary534 535 memoNode1572 "SFT-PHYS-COUPLED-ENSEMBLE-SYNCHRONIZATION-TERMINAL-007" = .ok result91 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state91_0 ["SFT-FOUNDATION-HALF-ONE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001"]; pure (result.1,put result.2 "SFT-PHYS-COUPLED-ENSEMBLE-SYNCHRONIZATION-TERMINAL-007" result.1)) = _
 rewrite [parents91_0]
 rfl
#print axioms rootCall91
end SFT.Physics.GrandLockRootTrace
