import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents669_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_6 [] = .ok state669_6 := rfl
theorem parents669_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_5 ["SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state669_6 := rfl
theorem parents669_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state669_6 := rfl
theorem parents669_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_3 ["SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state669_6 := rfl
theorem parents669_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_2 ["SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state669_6 := rfl
theorem parents669_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state669_6 := rfl
theorem parents669_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state669_6 := by
 change (reachesOne sourceDictionary534 534 memoNode10952 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-THERMO-TEMPERATURE-001"]) = _
 rewrite [rootCall668]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = _
 exact parents669_1
theorem rootCall669 : reachesOne sourceDictionary534 535 memoNode10952 "SFT-PHYS-VALIDATION-THERMO-MOLAR-ENERGY-001" = .ok result669 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state669_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-HOSTILE-PACKAGE-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-THERMO-TEMPERATURE-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-THERMO-MOLAR-ENERGY-001" result.1)) = _
 rewrite [parents669_0]
 rfl
#print axioms rootCall669
end SFT.Physics.GrandLockRootTrace
