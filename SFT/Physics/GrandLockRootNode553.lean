import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents553_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_7 [] = .ok state553_7 := rfl
theorem parents553_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_6 ["SFT-PHYS-THERMO-MICRO-MACRO-001"] = .ok state553_7 := rfl
theorem parents553_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_5 ["SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"] = .ok state553_7 := rfl
theorem parents553_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"] = .ok state553_7 := rfl
theorem parents553_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_3 ["SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"] = .ok state553_7 := rfl
theorem parents553_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_2 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"] = .ok state553_7 := rfl
theorem parents553_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"] = .ok state553_7 := rfl
theorem parents553_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"] = .ok state553_7 := by
 change (reachesOne sourceDictionary534 534 memoNode8713 "SFT-INFO-ENTROPY-UNCERTAINTY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"]) = _
 rewrite [rootCall552]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"] = _
 exact parents553_1
theorem rootCall553 : reachesOne sourceDictionary534 535 memoNode8713 "SFT-PHYS-THERMO-TEMPERATURE-001" = .ok result553 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state553_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-MICRO-MACRO-001"]; pure (result.1,put result.2 "SFT-PHYS-THERMO-TEMPERATURE-001" result.1)) = _
 rewrite [parents553_0]
 rfl
#print axioms rootCall553
end SFT.Physics.GrandLockRootTrace
