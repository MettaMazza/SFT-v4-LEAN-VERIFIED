import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents564_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state564_4 [] = .ok state564_4 := rfl
theorem parents564_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state564_3 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state564_4 := rfl
theorem parents564_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state564_2 ["SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state564_4 := rfl
theorem parents564_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state564_1 ["SFT-PHYS-MECH-INERTIA-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state564_4 := rfl
theorem parents564_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state564_0 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-MECH-INERTIA-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state564_4 := by
 change (reachesOne sourceDictionary534 534 memoNode8869 "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MECH-INERTIA-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall563]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state564_1 ["SFT-PHYS-MECH-INERTIA-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents564_1
theorem rootCall564 : reachesOne sourceDictionary534 535 memoNode8869 "SFT-PHYS-VACUUM-INERTIA-UNITY-003" = .ok result564 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state564_0 ["SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003","SFT-PHYS-MECH-INERTIA-001","SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VACUUM-INERTIA-UNITY-003" result.1)) = _
 rewrite [parents564_0]
 rfl
#print axioms rootCall564
end SFT.Physics.GrandLockRootTrace
