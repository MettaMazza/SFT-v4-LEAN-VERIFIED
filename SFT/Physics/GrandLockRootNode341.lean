import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents341_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_6 [] = .ok state341_6 := rfl
theorem parents341_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_5 ["SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"] = .ok state341_6 := rfl
theorem parents341_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_4 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"] = .ok state341_6 := rfl
theorem parents341_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_3 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"] = .ok state341_6 := rfl
theorem parents341_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_2 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"] = .ok state341_6 := rfl
theorem parents341_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"] = .ok state341_6 := rfl
theorem parents341_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_0 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"] = .ok state341_6 := by
 change (reachesOne sourceDictionary534 534 memoNode5475 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"]) = _
 rewrite [rootCall340]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"] = _
 exact parents341_1
theorem rootCall341 : reachesOne sourceDictionary534 535 memoNode5475 "SFT-PHYS-MECH-SPEED-VELOCITY-001" = .ok result341 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state341_0 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"]; pure (result.1,put result.2 "SFT-PHYS-MECH-SPEED-VELOCITY-001" result.1)) = _
 rewrite [parents341_0]
 rfl
#print axioms rootCall341
end SFT.Physics.GrandLockRootTrace
