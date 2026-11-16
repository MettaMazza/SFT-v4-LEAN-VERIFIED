import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents697_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state697_4 [] = .ok state697_4 := rfl
theorem parents697_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state697_3 ["SFT-PHYS-FIELD-RADIATION-001"] = .ok state697_4 := rfl
theorem parents697_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state697_2 ["SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001"] = .ok state697_4 := rfl
theorem parents697_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state697_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001"] = .ok state697_4 := rfl
theorem parents697_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state697_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001"] = .ok state697_4 := by
 change (reachesOne sourceDictionary534 534 memoNode11343 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001"]) = _
 rewrite [rootCall696]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state697_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001"] = _
 exact parents697_1
theorem rootCall697 : reachesOne sourceDictionary534 535 memoNode11343 "SFT-PHYS-WAVE-PERIOD-FREQUENCY-001" = .ok result697 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state697_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001"]; pure (result.1,put result.2 "SFT-PHYS-WAVE-PERIOD-FREQUENCY-001" result.1)) = _
 rewrite [parents697_0]
 rfl
#print axioms rootCall697
end SFT.Physics.GrandLockRootTrace
