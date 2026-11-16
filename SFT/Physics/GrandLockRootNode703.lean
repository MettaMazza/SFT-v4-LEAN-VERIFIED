import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents703_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state703_5 [] = .ok state703_5 := rfl
theorem parents703_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state703_4 ["SFT-PHYS-WAVE-DISPERSION-001"] = .ok state703_5 := rfl
theorem parents703_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state703_3 ["SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-DISPERSION-001"] = .ok state703_5 := rfl
theorem parents703_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state703_2 ["SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-DISPERSION-001"] = .ok state703_5 := rfl
theorem parents703_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state703_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-DISPERSION-001"] = .ok state703_5 := rfl
theorem parents703_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state703_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-DISPERSION-001"] = .ok state703_5 := by
 change (reachesOne sourceDictionary534 534 memoNode11404 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-DISPERSION-001"]) = _
 rewrite [rootCall702]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state703_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-DISPERSION-001"] = _
 exact parents703_1
theorem rootCall703 : reachesOne sourceDictionary534 535 memoNode11404 "SFT-PHYS-WAVE-RESONANCE-001" = .ok result703 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state703_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-DISPERSION-001"]; pure (result.1,put result.2 "SFT-PHYS-WAVE-RESONANCE-001" result.1)) = _
 rewrite [parents703_0]
 rfl
#print axioms rootCall703
end SFT.Physics.GrandLockRootTrace
