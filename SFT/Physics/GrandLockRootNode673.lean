import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents673_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_6 [] = .ok state673_6 := rfl
theorem parents673_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_5 ["SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"] = .ok state673_6 := rfl
theorem parents673_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_4 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"] = .ok state673_6 := rfl
theorem parents673_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_3 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"] = .ok state673_6 := rfl
theorem parents673_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_2 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"] = .ok state673_6 := rfl
theorem parents673_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"] = .ok state673_6 := rfl
theorem parents673_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_0 ["SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"] = .ok state673_6 := by
 change (reachesOne sourceDictionary534 534 memoNode11027 "SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"]) = _
 rewrite [rootCall672]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_1 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"] = _
 exact parents673_1
theorem rootCall673 : reachesOne sourceDictionary534 535 memoNode11027 "SFT-PHYS-VALIDATION-VACUUM-EXTRACTION-003" = .ok result673 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state673_0 ["SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-VACUUM-EXTRACTION-003" result.1)) = _
 rewrite [parents673_0]
 rfl
#print axioms rootCall673
end SFT.Physics.GrandLockRootTrace
