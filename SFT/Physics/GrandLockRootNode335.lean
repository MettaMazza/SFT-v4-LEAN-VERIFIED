import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits2
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents335_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_6 [] = .ok state335_6 := rfl
theorem parents335_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_5 ["SFT-PHYS-MECH-DURATION-001"] = .ok state335_6 := rfl
theorem parents335_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_4 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-DURATION-001"] = .ok state335_6 := rfl
theorem parents335_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_3 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-DURATION-001"] = .ok state335_6 := rfl
theorem parents335_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_2 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-DURATION-001"] = .ok state335_6 := rfl
theorem parents335_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-DURATION-001"] = .ok state335_6 := rfl
theorem parents335_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_0 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-DURATION-001"] = .ok state335_6 := by
 change (reachesOne sourceDictionary534 534 memoNode5414 "SFT-FOUNDATION-FOLD-ASSEMBLY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-DURATION-001"]) = _
 rewrite [rootCall334]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-DURATION-001"] = _
 exact parents335_1
theorem rootCall335 : reachesOne sourceDictionary534 535 memoNode5414 "SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001" = .ok result335 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state335_0 ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-DURATION-001"]; pure (result.1,put result.2 "SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001" result.1)) = _
 rewrite [parents335_0]
 rfl
#print axioms rootCall335
end SFT.Physics.GrandLockRootTrace
