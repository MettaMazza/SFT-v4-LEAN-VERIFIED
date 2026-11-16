import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits0
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents113_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state113_3 [] = .ok state113_3 := rfl
theorem parents113_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state113_2 ["SFT-PHYS-MECH-MOMENTUM-001"] = .ok state113_3 := rfl
theorem parents113_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state113_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-MOMENTUM-001"] = .ok state113_3 := rfl
theorem parents113_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state113_0 ["SFT-FOUNDATION-FOLD-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-MOMENTUM-001"] = .ok state113_3 := by
 change (reachesOne sourceDictionary534 534 memoNode2181 "SFT-FOUNDATION-FOLD-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-MOMENTUM-001"]) = _
 rewrite [rootCall112]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state113_1 ["SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-MOMENTUM-001"] = _
 exact parents113_1
theorem rootCall113 : reachesOne sourceDictionary534 535 memoNode2181 "SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003" = .ok result113 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state113_0 ["SFT-FOUNDATION-FOLD-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-PHYS-MECH-MOMENTUM-001"]; pure (result.1,put result.2 "SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003" result.1)) = _
 rewrite [parents113_0]
 rfl
#print axioms rootCall113
end SFT.Physics.GrandLockRootTrace
