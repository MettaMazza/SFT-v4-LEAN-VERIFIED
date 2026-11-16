import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents631_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_6 [] = .ok state631_6 := rfl
theorem parents631_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_5 ["SFT-PHYS-MECH-MOMENTUM-001"] = .ok state631_6 := rfl
theorem parents631_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-MOMENTUM-001"] = .ok state631_6 := rfl
theorem parents631_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_3 ["SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-MOMENTUM-001"] = .ok state631_6 := rfl
theorem parents631_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_2 ["SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-MOMENTUM-001"] = .ok state631_6 := rfl
theorem parents631_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-MOMENTUM-001"] = .ok state631_6 := rfl
theorem parents631_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-MOMENTUM-001"] = .ok state631_6 := by
 change (reachesOne sourceDictionary534 534 memoNode10183 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-MOMENTUM-001"]) = _
 rewrite [rootCall630]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-MOMENTUM-001"] = _
 exact parents631_1
theorem rootCall631 : reachesOne sourceDictionary534 535 memoNode10183 "SFT-PHYS-VALIDATION-MECHANICS-MOMENTUM-001" = .ok result631 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state631_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-MOMENTUM-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-MECHANICS-MOMENTUM-001" result.1)) = _
 rewrite [parents631_0]
 rfl
#print axioms rootCall631
end SFT.Physics.GrandLockRootTrace
