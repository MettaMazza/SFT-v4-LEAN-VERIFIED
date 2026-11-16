import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents295_8 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_8 [] = .ok state295_8 := rfl
theorem parents295_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_7 ["SFT-COMP-SEM-VERIFICATION-001"] = .ok state295_8 := rfl
theorem parents295_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_6 ["SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state295_8 := rfl
theorem parents295_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_5 ["SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state295_8 := rfl
theorem parents295_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_4 ["SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state295_8 := rfl
theorem parents295_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_3 ["SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state295_8 := rfl
theorem parents295_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_2 ["SFT-INFO-ENCODING-DECODING-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state295_8 := rfl
theorem parents295_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_1 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state295_8 := rfl
theorem parents295_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_0 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"] = .ok state295_8 := by
 change (reachesOne sourceDictionary534 534 memoNode4929 "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"]) = _
 rewrite [rootCall294]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_1 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"] = _
 exact parents295_1
theorem rootCall295 : reachesOne sourceDictionary534 535 memoNode4929 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" = .ok result295 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state295_0 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-INFO-ENCODING-DECODING-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001","SFT-COMP-SEM-EVALUATION-001","SFT-COMP-SEM-TERMINATION-001","SFT-COMP-SEM-VERIFICATION-001"]; pure (result.1,put result.2 "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001" result.1)) = _
 rewrite [parents295_0]
 rfl
#print axioms rootCall295
end SFT.Physics.GrandLockRootTrace
