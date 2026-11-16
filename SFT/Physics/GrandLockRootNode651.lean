import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents651_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_7 [] = .ok state651_7 := rfl
theorem parents651_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_6 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state651_7 := rfl
theorem parents651_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_5 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state651_7 := rfl
theorem parents651_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_4 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state651_7 := rfl
theorem parents651_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_3 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state651_7 := rfl
theorem parents651_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_2 ["SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state651_7 := rfl
theorem parents651_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_1 ["SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state651_7 := rfl
theorem parents651_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_0 ["SFT-PHYS-MATTER-QUARK-CUBICS-003","SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state651_7 := by
 change (reachesOne sourceDictionary534 534 memoNode10547 "SFT-PHYS-MATTER-QUARK-CUBICS-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall650]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_1 ["SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents651_1
theorem rootCall651 : reachesOne sourceDictionary534 535 memoNode10547 "SFT-PHYS-VALIDATION-QUARK-CKM-003" = .ok result651 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state651_0 ["SFT-PHYS-MATTER-QUARK-CUBICS-003","SFT-PHYS-MATTER-QUARK-DRESSING-003","SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-QUARK-CKM-003" result.1)) = _
 rewrite [parents651_0]
 rfl
#print axioms rootCall651
end SFT.Physics.GrandLockRootTrace
