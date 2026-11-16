import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents605_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state605_4 [] = .ok state605_4 := rfl
theorem parents605_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state605_3 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state605_4 := rfl
theorem parents605_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state605_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state605_4 := rfl
theorem parents605_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state605_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state605_4 := rfl
theorem parents605_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state605_0 ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state605_4 := by
 change (reachesOne sourceDictionary534 534 memoNode9692 "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall604]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state605_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents605_1
theorem rootCall605 : reachesOne sourceDictionary534 535 memoNode9692 "SFT-PHYS-VALIDATION-FORCE-SECTOR-ANCHORS-003" = .ok result605 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state605_0 ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-FORCE-SECTOR-ANCHORS-003" result.1)) = _
 rewrite [parents605_0]
 rfl
#print axioms rootCall605
end SFT.Physics.GrandLockRootTrace
