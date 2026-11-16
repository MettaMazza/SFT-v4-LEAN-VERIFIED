import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents317_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_6 [] = .ok state317_6 := rfl
theorem parents317_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_5 ["SFT-PHYS-MECH-SPEED-VELOCITY-001"] = .ok state317_6 := rfl
theorem parents317_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_4 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-SPEED-VELOCITY-001"] = .ok state317_6 := rfl
theorem parents317_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_3 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-SPEED-VELOCITY-001"] = .ok state317_6 := rfl
theorem parents317_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_2 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-SPEED-VELOCITY-001"] = .ok state317_6 := rfl
theorem parents317_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-SPEED-VELOCITY-001"] = .ok state317_6 := rfl
theorem parents317_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_0 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-SPEED-VELOCITY-001"] = .ok state317_6 := by
 change (reachesOne sourceDictionary534 534 memoNode5229 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-SPEED-VELOCITY-001"]) = _
 rewrite [rootCall316]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-SPEED-VELOCITY-001"] = _
 exact parents317_1
theorem rootCall317 : reachesOne sourceDictionary534 535 memoNode5229 "SFT-PHYS-MECH-ACCELERATION-001" = .ok result317 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state317_0 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-SPEED-VELOCITY-001"]; pure (result.1,put result.2 "SFT-PHYS-MECH-ACCELERATION-001" result.1)) = _
 rewrite [parents317_0]
 rfl
#print axioms rootCall317
end SFT.Physics.GrandLockRootTrace
