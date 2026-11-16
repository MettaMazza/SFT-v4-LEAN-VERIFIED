import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents559_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state559_4 [] = .ok state559_4 := rfl
theorem parents559_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state559_3 ["SFT-INFO-CONSERVATION-LOSS-001"] = .ok state559_4 := rfl
theorem parents559_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state559_2 ["SFT-PHYS-THERMO-ENTROPY-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok state559_4 := rfl
theorem parents559_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state559_1 ["SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-ENTROPY-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok state559_4 := rfl
theorem parents559_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state559_0 ["SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-ENTROPY-001","SFT-INFO-CONSERVATION-LOSS-001"] = .ok state559_4 := by
 change (reachesOne sourceDictionary534 534 memoNode8793 "SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-ENTROPY-001","SFT-INFO-CONSERVATION-LOSS-001"]) = _
 rewrite [rootCall558]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state559_1 ["SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-ENTROPY-001","SFT-INFO-CONSERVATION-LOSS-001"] = _
 exact parents559_1
theorem rootCall559 : reachesOne sourceDictionary534 535 memoNode8793 "SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003" = .ok result559 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state559_0 ["SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-ENTROPY-001","SFT-INFO-CONSERVATION-LOSS-001"]; pure (result.1,put result.2 "SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003" result.1)) = _
 rewrite [parents559_0]
 rfl
#print axioms rootCall559
end SFT.Physics.GrandLockRootTrace
