import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents541_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_6 [] = .ok state541_6 := rfl
theorem parents541_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_5 ["SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state541_6 := rfl
theorem parents541_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state541_6 := rfl
theorem parents541_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_3 ["SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state541_6 := rfl
theorem parents541_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_2 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state541_6 := rfl
theorem parents541_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state541_6 := rfl
theorem parents541_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = .ok state541_6 := by
 change (reachesOne sourceDictionary534 534 memoNode8574 "SFT-INFO-ENTROPY-UNCERTAINTY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"]) = _
 rewrite [rootCall540]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"] = _
 exact parents541_1
theorem rootCall541 : reachesOne sourceDictionary534 535 memoNode8574 "SFT-PHYS-THERMO-MICRO-MACRO-001" = .ok result541 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state541_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001"]; pure (result.1,put result.2 "SFT-PHYS-THERMO-MICRO-MACRO-001" result.1)) = _
 rewrite [parents541_0]
 rfl
#print axioms rootCall541
end SFT.Physics.GrandLockRootTrace
