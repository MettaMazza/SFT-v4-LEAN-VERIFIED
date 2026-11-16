import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents152_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_6 [] = .ok state152_6 := rfl
theorem parents152_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_5 ["SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state152_6 := rfl
theorem parents152_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_4 ["SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state152_6 := rfl
theorem parents152_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_3 ["SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state152_6 := rfl
theorem parents152_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_2 ["SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state152_6 := rfl
theorem parents152_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state152_6 := rfl
theorem parents152_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = .ok state152_6 := by
 change (reachesOne sourceDictionary534 534 memoNode2941 "SFT-MATH-GEOMETRY-TOPOLOGY-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"]) = _
 rewrite [rootCall151]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"] = _
 exact parents152_1
theorem rootCall152 : reachesOne sourceDictionary534 535 memoNode2941 "SFT-PHYS-FIELD-GAUGE-EQUIVALENCE-001" = .ok result152 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state152_0 ["SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001"]; pure (result.1,put result.2 "SFT-PHYS-FIELD-GAUGE-EQUIVALENCE-001" result.1)) = _
 rewrite [parents152_0]
 rfl
#print axioms rootCall152
end SFT.Physics.GrandLockRootTrace
