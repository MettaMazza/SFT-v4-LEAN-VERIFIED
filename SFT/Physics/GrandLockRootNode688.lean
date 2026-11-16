import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode687
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents688_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state688_5 [] = .ok state688_5 := rfl
theorem parents688_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state688_4 ["SFT-PHYS-WAVE-INTERFERENCE-001"] = .ok state688_5 := rfl
theorem parents688_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state688_3 ["SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-INTERFERENCE-001"] = .ok state688_5 := rfl
theorem parents688_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state688_2 ["SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-INTERFERENCE-001"] = .ok state688_5 := rfl
theorem parents688_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state688_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-INTERFERENCE-001"] = .ok state688_5 := rfl
theorem parents688_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state688_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-INTERFERENCE-001"] = .ok state688_5 := by
 change (reachesOne sourceDictionary534 534 memoNode11241 "SFT-MATH-DYNAMICAL-SYSTEMS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-INTERFERENCE-001"]) = _
 rewrite [rootCall687]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state688_1 ["SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-INTERFERENCE-001"] = _
 exact parents688_1
theorem rootCall688 : reachesOne sourceDictionary534 535 memoNode11241 "SFT-PHYS-WAVE-DIFFRACTION-001" = .ok result688 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state688_0 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CHANNEL-CAPACITY-001","SFT-PHYS-MECH-CONSTRAINT-OSCILLATION-001","SFT-PHYS-FIELD-RADIATION-001","SFT-PHYS-WAVE-INTERFERENCE-001"]; pure (result.1,put result.2 "SFT-PHYS-WAVE-DIFFRACTION-001" result.1)) = _
 rewrite [parents688_0]
 rfl
#print axioms rootCall688
end SFT.Physics.GrandLockRootTrace
