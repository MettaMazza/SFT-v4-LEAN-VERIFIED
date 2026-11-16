import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents567_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state567_4 [] = .ok state567_4 := rfl
theorem parents567_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state567_3 ["SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state567_4 := rfl
theorem parents567_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state567_2 ["SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state567_4 := rfl
theorem parents567_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state567_1 ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state567_4 := rfl
theorem parents567_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state567_0 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = .ok state567_4 := by
 change (reachesOne sourceDictionary534 534 memoNode8895 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"]) = _
 rewrite [rootCall566]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state567_1 ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"] = _
 exact parents567_1
theorem rootCall567 : reachesOne sourceDictionary534 535 memoNode8895 "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003" = .ok result567 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state567_0 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"]; pure (result.1,put result.2 "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003" result.1)) = _
 rewrite [parents567_0]
 rfl
#print axioms rootCall567
end SFT.Physics.GrandLockRootTrace
