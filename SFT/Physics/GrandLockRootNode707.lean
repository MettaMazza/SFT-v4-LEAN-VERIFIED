import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents707_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state707_5 [] = .ok state707_5 := rfl
theorem parents707_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state707_4 ["SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001"] = .ok state707_5 := rfl
theorem parents707_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state707_3 ["SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001"] = .ok state707_5 := rfl
theorem parents707_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state707_2 ["SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001"] = .ok state707_5 := rfl
theorem parents707_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state707_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001"] = .ok state707_5 := rfl
theorem parents707_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state707_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001"] = .ok state707_5 := by
 change (reachesOne sourceDictionary534 534 memoNode11449 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001"]) = _
 rewrite [rootCall706]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state707_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001"] = _
 exact parents707_1
theorem rootCall707 : reachesOne sourceDictionary534 535 memoNode11449 "SFT-PHYS-WAVE-SUPERPOSITION-001" = .ok result707 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state707_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-SPEED-LENGTH-FREQUENCY-001"]; pure (result.1,put result.2 "SFT-PHYS-WAVE-SUPERPOSITION-001" result.1)) = _
 rewrite [parents707_0]
 rfl
#print axioms rootCall707
end SFT.Physics.GrandLockRootTrace
