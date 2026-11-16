import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents629_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_6 [] = .ok state629_6 := rfl
theorem parents629_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_5 ["SFT-PHYS-MECH-FORCE-001"] = .ok state629_6 := rfl
theorem parents629_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-FORCE-001"] = .ok state629_6 := rfl
theorem parents629_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_3 ["SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-FORCE-001"] = .ok state629_6 := rfl
theorem parents629_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_2 ["SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-FORCE-001"] = .ok state629_6 := rfl
theorem parents629_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-FORCE-001"] = .ok state629_6 := rfl
theorem parents629_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-FORCE-001"] = .ok state629_6 := by
 change (reachesOne sourceDictionary534 534 memoNode10152 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-FORCE-001"]) = _
 rewrite [rootCall628]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-FORCE-001"] = _
 exact parents629_1
theorem rootCall629 : reachesOne sourceDictionary534 535 memoNode10152 "SFT-PHYS-VALIDATION-MECHANICS-FORCE-001" = .ok result629 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state629_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-FORCE-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-MECHANICS-FORCE-001" result.1)) = _
 rewrite [parents629_0]
 rfl
#print axioms rootCall629
end SFT.Physics.GrandLockRootTrace
