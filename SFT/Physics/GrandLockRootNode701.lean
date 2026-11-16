import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents701_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state701_5 [] = .ok state701_5 := rfl
theorem parents701_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state701_4 ["SFT-PHYS-WAVE-PERIOD-FREQUENCY-001"] = .ok state701_5 := rfl
theorem parents701_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state701_3 ["SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001"] = .ok state701_5 := rfl
theorem parents701_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state701_2 ["SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001"] = .ok state701_5 := rfl
theorem parents701_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state701_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001"] = .ok state701_5 := rfl
theorem parents701_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state701_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001"] = .ok state701_5 := by
 change (reachesOne sourceDictionary534 534 memoNode11384 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001"]) = _
 rewrite [rootCall700]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state701_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001"] = _
 exact parents701_1
theorem rootCall701 : reachesOne sourceDictionary534 535 memoNode11384 "SFT-PHYS-WAVE-PROPAGATION-001" = .ok result701 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state701_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-PERIOD-FREQUENCY-001"]; pure (result.1,put result.2 "SFT-PHYS-WAVE-PROPAGATION-001" result.1)) = _
 rewrite [parents701_0]
 rfl
#print axioms rootCall701
end SFT.Physics.GrandLockRootTrace
