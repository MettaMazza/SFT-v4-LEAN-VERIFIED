import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents309_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state309_5 [] = .ok state309_5 := rfl
theorem parents309_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state309_4 ["SFT-COMP-SEC-INTEGRITY-001"] = .ok state309_5 := rfl
theorem parents309_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state309_3 ["SFT-COMP-SEC-COMMITMENT-001","SFT-COMP-SEC-INTEGRITY-001"] = .ok state309_5 := rfl
theorem parents309_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state309_2 ["SFT-COMP-SEC-HASHING-001","SFT-COMP-SEC-COMMITMENT-001","SFT-COMP-SEC-INTEGRITY-001"] = .ok state309_5 := rfl
theorem parents309_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state309_1 ["SFT-INFO-ENCODING-DECODING-001","SFT-COMP-SEC-HASHING-001","SFT-COMP-SEC-COMMITMENT-001","SFT-COMP-SEC-INTEGRITY-001"] = .ok state309_5 := rfl
theorem parents309_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state309_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-SEC-HASHING-001","SFT-COMP-SEC-COMMITMENT-001","SFT-COMP-SEC-INTEGRITY-001"] = .ok state309_5 := by
 change (reachesOne sourceDictionary534 534 memoNode5128 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-ENCODING-DECODING-001","SFT-COMP-SEC-HASHING-001","SFT-COMP-SEC-COMMITMENT-001","SFT-COMP-SEC-INTEGRITY-001"]) = _
 rewrite [rootCall308]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state309_1 ["SFT-INFO-ENCODING-DECODING-001","SFT-COMP-SEC-HASHING-001","SFT-COMP-SEC-COMMITMENT-001","SFT-COMP-SEC-INTEGRITY-001"] = _
 exact parents309_1
theorem rootCall309 : reachesOne sourceDictionary534 535 memoNode5128 "SFT-PHYS-MEAS-TARGET-CUSTODY-001" = .ok result309 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state309_0 ["SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-SEC-HASHING-001","SFT-COMP-SEC-COMMITMENT-001","SFT-COMP-SEC-INTEGRITY-001"]; pure (result.1,put result.2 "SFT-PHYS-MEAS-TARGET-CUSTODY-001" result.1)) = _
 rewrite [parents309_0]
 rfl
#print axioms rootCall309
end SFT.Physics.GrandLockRootTrace
