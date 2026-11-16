import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode216
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents217_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state217_3 [] = .ok state217_3 := rfl
theorem parents217_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state217_2 ["SFT-QUANTUM-MEASUREMENT-001"] = .ok state217_3 := rfl
theorem parents217_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state217_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-MEASUREMENT-001"] = .ok state217_3 := rfl
theorem parents217_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state217_0 ["SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003","SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-MEASUREMENT-001"] = .ok state217_3 := by
 change (reachesOne sourceDictionary534 534 memoNode3847 "SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-MEASUREMENT-001"]) = _
 rewrite [rootCall216]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state217_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-MEASUREMENT-001"] = _
 exact parents217_1
theorem rootCall217 : reachesOne sourceDictionary534 535 memoNode3847 "SFT-PHYS-GRAVITY-HORIZON-INFORMATION-003" = .ok result217 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state217_0 ["SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003","SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-MEASUREMENT-001"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-HORIZON-INFORMATION-003" result.1)) = _
 rewrite [parents217_0]
 rfl
#print axioms rootCall217
end SFT.Physics.GrandLockRootTrace
