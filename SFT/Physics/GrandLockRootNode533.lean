import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents533_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_7 [] = .ok state533_7 := rfl
theorem parents533_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_6 ["SFT-PHYS-THERMO-FLUCTUATION-001"] = .ok state533_7 := rfl
theorem parents533_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_5 ["SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"] = .ok state533_7 := rfl
theorem parents533_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_4 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"] = .ok state533_7 := rfl
theorem parents533_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_3 ["SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"] = .ok state533_7 := rfl
theorem parents533_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_2 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"] = .ok state533_7 := rfl
theorem parents533_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"] = .ok state533_7 := rfl
theorem parents533_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"] = .ok state533_7 := by
 change (reachesOne sourceDictionary534 534 memoNode8440 "SFT-INFO-ENTROPY-UNCERTAINTY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"]) = _
 rewrite [rootCall532]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_1 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"] = _
 exact parents533_1
theorem rootCall533 : reachesOne sourceDictionary534 535 memoNode8440 "SFT-PHYS-THERMO-IRREVERSIBILITY-001" = .ok result533 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state533_0 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-ENERGY-MOMENTUM-001","SFT-PHYS-THERMO-FLUCTUATION-001"]; pure (result.1,put result.2 "SFT-PHYS-THERMO-IRREVERSIBILITY-001" result.1)) = _
 rewrite [parents533_0]
 rfl
#print axioms rootCall533
end SFT.Physics.GrandLockRootTrace
