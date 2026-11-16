import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents551_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_7 [] = .ok state551_7 := rfl
theorem parents551_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_6 ["SFT-PHYS-THERMO-THIRD-LAW-001"] = .ok state551_7 := rfl
theorem parents551_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_5 ["SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"] = .ok state551_7 := rfl
theorem parents551_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"] = .ok state551_7 := rfl
theorem parents551_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_3 ["SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"] = .ok state551_7 := rfl
theorem parents551_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_2 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"] = .ok state551_7 := rfl
theorem parents551_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"] = .ok state551_7 := rfl
theorem parents551_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"] = .ok state551_7 := by
 change (reachesOne sourceDictionary534 534 memoNode8684 "SFT-INFO-ENTROPY-UNCERTAINTY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"]) = _
 rewrite [rootCall550]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"] = _
 exact parents551_1
theorem rootCall551 : reachesOne sourceDictionary534 535 memoNode8684 "SFT-PHYS-THERMO-STATISTICAL-WEIGHT-001" = .ok result551 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state551_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-THIRD-LAW-001"]; pure (result.1,put result.2 "SFT-PHYS-THERMO-STATISTICAL-WEIGHT-001" result.1)) = _
 rewrite [parents551_0]
 rfl
#print axioms rootCall551
end SFT.Physics.GrandLockRootTrace
