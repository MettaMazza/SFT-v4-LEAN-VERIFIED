import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents683_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_6 [] = .ok state683_6 := rfl
theorem parents683_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_5 ["SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state683_6 := rfl
theorem parents683_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state683_6 := rfl
theorem parents683_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_3 ["SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state683_6 := rfl
theorem parents683_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_2 ["SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state683_6 := rfl
theorem parents683_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state683_6 := rfl
theorem parents683_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state683_6 := by
 change (reachesOne sourceDictionary534 534 memoNode11187 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"]) = _
 rewrite [rootCall682]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = _
 exact parents683_1
theorem rootCall683 : reachesOne sourceDictionary534 535 memoNode11187 "SFT-PHYS-VALIDATION-WAVE-ENERGY-001" = .ok result683 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state683_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-WAVE-ENERGY-001" result.1)) = _
 rewrite [parents683_0]
 rfl
#print axioms rootCall683
end SFT.Physics.GrandLockRootTrace
