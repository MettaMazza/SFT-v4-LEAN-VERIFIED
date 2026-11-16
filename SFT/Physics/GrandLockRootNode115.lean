import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents115_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state115_3 [] = .ok state115_3 := rfl
theorem parents115_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state115_2 ["SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state115_3 := rfl
theorem parents115_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state115_1 ["SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state115_3 := rfl
theorem parents115_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state115_0 ["SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = .ok state115_3 := by
 change (reachesOne sourceDictionary534 534 memoNode2218 "SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"]) = _
 rewrite [rootCall114]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state115_1 ["SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"] = _
 exact parents115_1
theorem rootCall115 : reachesOne sourceDictionary534 535 memoNode2218 "SFT-PHYS-DYNAMICS-POTENTIAL-EVOLUTION-003" = .ok result115 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state115_0 ["SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001"]; pure (result.1,put result.2 "SFT-PHYS-DYNAMICS-POTENTIAL-EVOLUTION-003" result.1)) = _
 rewrite [parents115_0]
 rfl
#print axioms rootCall115
end SFT.Physics.GrandLockRootTrace
