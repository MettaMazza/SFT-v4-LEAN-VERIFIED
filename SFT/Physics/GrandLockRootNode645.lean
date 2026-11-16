import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents645_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state645_5 [] = .ok state645_5 := rfl
theorem parents645_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state645_4 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state645_5 := rfl
theorem parents645_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state645_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state645_5 := rfl
theorem parents645_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state645_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state645_5 := rfl
theorem parents645_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state645_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state645_5 := rfl
theorem parents645_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state645_0 ["SFT-PHYS-MATTER-PROTON-ELECTRON-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state645_5 := by
 change (reachesOne sourceDictionary534 534 memoNode10440 "SFT-PHYS-MATTER-PROTON-ELECTRON-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall644]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state645_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents645_1
theorem rootCall645 : reachesOne sourceDictionary534 535 memoNode10440 "SFT-PHYS-VALIDATION-PROTON-ELECTRON-003" = .ok result645 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state645_0 ["SFT-PHYS-MATTER-PROTON-ELECTRON-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-PROTON-ELECTRON-003" result.1)) = _
 rewrite [parents645_0]
 rfl
#print axioms rootCall645
end SFT.Physics.GrandLockRootTrace
