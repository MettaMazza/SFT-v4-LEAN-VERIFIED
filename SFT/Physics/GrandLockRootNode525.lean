import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents525_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_7 [] = .ok state525_7 := rfl
theorem parents525_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_6 ["SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state525_7 := rfl
theorem parents525_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_5 ["SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state525_7 := rfl
theorem parents525_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state525_7 := rfl
theorem parents525_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_3 ["SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state525_7 := rfl
theorem parents525_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_2 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state525_7 := rfl
theorem parents525_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state525_7 := rfl
theorem parents525_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = .ok state525_7 := by
 change (reachesOne sourceDictionary534 534 memoNode8347 "SFT-INFO-ENTROPY-UNCERTAINTY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"]) = _
 rewrite [rootCall524]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"] = _
 exact parents525_1
theorem rootCall525 : reachesOne sourceDictionary534 535 memoNode8347 "SFT-PHYS-THERMO-EQUILIBRIUM-001" = .ok result525 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state525_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-TEMPERATURE-001"]; pure (result.1,put result.2 "SFT-PHYS-THERMO-EQUILIBRIUM-001" result.1)) = _
 rewrite [parents525_0]
 rfl
#print axioms rootCall525
end SFT.Physics.GrandLockRootTrace
