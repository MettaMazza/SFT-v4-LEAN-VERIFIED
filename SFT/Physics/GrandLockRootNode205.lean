import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits1
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents205_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 528 cache dep) state205_3 [] = .ok state205_3 := rfl
theorem parents205_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 528 cache dep) state205_2 ["SFT-PHYS-MECH-CONSERVATION-001"] = .ok state205_3 := rfl
theorem parents205_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 528 cache dep) state205_1 ["SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = .ok state205_3 := rfl
theorem parents205_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 528 cache dep) state205_0 ["SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = .ok state205_3 := by
 change (reachesOne sourceDictionary534 528 memoNode3595 "SFT-PHYS-FIELD-INVERSE-SQUARE-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 528 cache dep) next ["SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MECH-CONSERVATION-001"]) = _
 rewrite [rootCall204]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 528 cache dep) state205_1 ["SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = _
 exact parents205_1
theorem rootCall205 : reachesOne sourceDictionary534 529 memoNode3595 "SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003" = .ok result205 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 528 cache dep) state205_0 ["SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-GRAVITY-FIELD-SOURCE-001","SFT-PHYS-MECH-CONSERVATION-001"]; pure (result.1,put result.2 "SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003" result.1)) = _
 rewrite [parents205_0]
 rfl
#print axioms rootCall205
end SFT.Physics.GrandLockRootTrace
