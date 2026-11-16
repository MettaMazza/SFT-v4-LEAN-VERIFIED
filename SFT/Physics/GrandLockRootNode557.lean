import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents557_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state557_5 [] = .ok state557_5 := rfl
theorem parents557_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state557_4 ["SFT-PHYS-MECH-CONSERVATION-001"] = .ok state557_5 := rfl
theorem parents557_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state557_3 ["SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = .ok state557_5 := rfl
theorem parents557_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state557_2 ["SFT-PHYS-VACUUM-INERTIA-UNITY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = .ok state557_5 := rfl
theorem parents557_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state557_1 ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-VACUUM-INERTIA-UNITY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = .ok state557_5 := rfl
theorem parents557_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state557_0 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-VACUUM-INERTIA-UNITY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = .ok state557_5 := by
 change (reachesOne sourceDictionary534 534 memoNode8755 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-VACUUM-INERTIA-UNITY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-MECH-CONSERVATION-001"]) = _
 rewrite [rootCall556]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state557_1 ["SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-VACUUM-INERTIA-UNITY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-MECH-CONSERVATION-001"] = _
 exact parents557_1
theorem rootCall557 : reachesOne sourceDictionary534 535 memoNode8755 "SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003" = .ok result557 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state557_0 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-VACUUM-ODD-RECURRENCE-003","SFT-PHYS-VACUUM-INERTIA-UNITY-003","SFT-PHYS-WAVE-RESONANCE-001","SFT-PHYS-MECH-CONSERVATION-001"]; pure (result.1,put result.2 "SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003" result.1)) = _
 rewrite [parents557_0]
 rfl
#print axioms rootCall557
end SFT.Physics.GrandLockRootTrace
