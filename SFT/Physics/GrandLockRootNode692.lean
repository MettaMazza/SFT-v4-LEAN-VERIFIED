import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits5
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents692_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state692_5 [] = .ok state692_5 := rfl
theorem parents692_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state692_4 ["SFT-PHYS-WAVE-RESONANCE-001"] = .ok state692_5 := rfl
theorem parents692_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state692_3 ["SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = .ok state692_5 := rfl
theorem parents692_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state692_2 ["SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = .ok state692_5 := rfl
theorem parents692_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state692_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = .ok state692_5 := rfl
theorem parents692_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state692_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = .ok state692_5 := by
 change (reachesOne sourceDictionary534 534 memoNode11303 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-RESONANCE-001"]) = _
 rewrite [rootCall691]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state692_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-RESONANCE-001"] = _
 exact parents692_1
theorem rootCall692 : reachesOne sourceDictionary534 535 memoNode11303 "SFT-PHYS-WAVE-ENERGY-MOMENTUM-001" = .ok result692 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state692_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-RESONANCE-001"]; pure (result.1,put result.2 "SFT-PHYS-WAVE-ENERGY-MOMENTUM-001" result.1)) = _
 rewrite [parents692_0]
 rfl
#print axioms rootCall692
end SFT.Physics.GrandLockRootTrace
