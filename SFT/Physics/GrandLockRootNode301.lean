import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents301_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state301_5 [] = .ok state301_5 := rfl
theorem parents301_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state301_4 ["SFT-COMP-SEM-VERIFICATION-001"] = .ok state301_5 := rfl
theorem parents301_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state301_3 ["SFT-COMP-SEC-ADVERSARIAL-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state301_5 := rfl
theorem parents301_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state301_2 ["SFT-COMP-SEC-INTEGRITY-001","SFT-COMP-SEC-ADVERSARIAL-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state301_5 := rfl
theorem parents301_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state301_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-COMP-SEC-INTEGRITY-001","SFT-COMP-SEC-ADVERSARIAL-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state301_5 := rfl
theorem parents301_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state301_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-COMP-SEC-INTEGRITY-001","SFT-COMP-SEC-ADVERSARIAL-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state301_5 := by
 change (reachesOne sourceDictionary534 534 memoNode5018 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-COMP-SEC-INTEGRITY-001","SFT-COMP-SEC-ADVERSARIAL-001","SFT-COMP-SEM-VERIFICATION-001"]) = _
 rewrite [rootCall300]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state301_1 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-COMP-SEC-INTEGRITY-001","SFT-COMP-SEC-ADVERSARIAL-001","SFT-COMP-SEM-VERIFICATION-001"] = _
 exact parents301_1
theorem rootCall301 : reachesOne sourceDictionary534 535 memoNode5018 "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001" = .ok result301 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state301_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-COMP-SEC-INTEGRITY-001","SFT-COMP-SEC-ADVERSARIAL-001","SFT-COMP-SEM-VERIFICATION-001"]; pure (result.1,put result.2 "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001" result.1)) = _
 rewrite [parents301_0]
 rfl
#print axioms rootCall301
end SFT.Physics.GrandLockRootTrace
